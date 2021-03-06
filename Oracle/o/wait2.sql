set serveroutput on
set verify off
set feed off
set lines 120 pages 5000

prompt 'Please enter SID: '

DECLARE
/************************************************************************
Name:     SCAN.SQL
Author:   Bear Dang    Tran Technologies, LTD   bear@trantechnologies.com
Purpose:  Based on a given SID:
          1. Reveal the table/index/temp/rollback segment being accessed at a 
             point-in-time
             'db file sequential read','db file scattered read', 
             'db file parallel write', 'direct path read' or 'direct path write'
          2. If the wait event is for an 'enqueue', return the locking session
          3. Reveal the holder of a 'library cache load lock',
             'library cache lock'
          4. Reveal the segment causing 'buffer busy waits', 'free buffer waits'
          5. If the session is waiting on a 'latch free', return the latch
          6. For any other wait, return the event
Note:     Should be logged in as SYS - run as @scan from SQL prompt
          For diagnosing P3 (reason) for buffer busy waits: Note 224963.999 or
          check for new information as P3 values seem to change for each release
Views:    v$session_wait, v$session, v$sqlarea, v$lock, v$latch, dba_extents
Tables:   x$kgllk
Created:  5-28-01
Modified: 4-14-02 added scan for 'buffer busy waits' - Bear

*************************************************************************/ 
v_sid v$session_wait.sid%type := '&sid';

/* Obtain wait information based on a given SID */
CURSOR lc_wait IS
  SELECT vw.sid, vw.event, vw.p1, vw.p2, vw.p3, vs.sql_address
  FROM v$session_wait vw, v$session vs
  WHERE vw.sid = v_sid
  AND vw.sid = vs.sid;

/* Obtain current sql text */
CURSOR lc_sql(ln_address v$session.sql_address%type) IS
  SELECT sql_text 
  FROM v$sqlarea
  WHERE address = ln_address;

/* Join dba_extents.file_id with v$session_wait.p1 and 
|| dba_extents.block_id with v$session_wait.p2. Column dba_extents.block_id 
|| is the block header for each extent.
*/
CURSOR lc_seg(ln_file v$session_wait.p1%type, ln_block v$session_wait.p2%type) IS
  SELECT tablespace_name, owner, segment_name, block_id
  FROM dba_extents
  WHERE file_id = ln_file
  AND block_id <= ln_block
  AND ln_block BETWEEN block_id
  AND block_id + blocks -1;

/* If the wait event is an enqueue, obtain the blocking session and sql_text
|| from v$lock, v$session, and v$sqlarea
*/ 
CURSOR lc_enqueue(ln_sid v$session_wait.sid%type) IS
  SELECT vl2.sid, va.sql_text
  FROM v$lock vl1, v$lock vl2, v$session vs, v$sqlarea va
  WHERE vl1.id1 = vl2.id1
  AND vl2.sid = vs.sid
  AND vs.sql_address = va.address
  AND vl1.sid = ln_sid
  AND vl2.block != 0;

/* If the wait event is a library cache lock, obtain the
|| locking session from x$kgllk where kgllkreq = 0
*/  
CURSOR lc_lbc_lock(ln_sid v$session_wait.sid%type) IS
  SELECT vs.sid, sa.sql_text
  FROM v$session vs, v$sqlarea sa
  WHERE vs.sql_address = sa.address
  AND vs.saddr = 
    (SELECT kgllkses
     FROM x$kgllk
     WHERE kgllkreq = 0
     AND kgllkhdl IN
       (SELECT kgllkhdl
        FROM x$kgllk
        WHERE kgllkreq > 0
        AND kgllkses IN
          (SELECT vs.saddr 
           FROM v$session vs
           WHERE vs.sid = ln_sid)));

/* If the wait event is for a latch free, 
|| obtain the specific latch name 
*/ 
CURSOR lc_latch(ln_p2 v$session_wait.p2%type) IS
  SELECT name
  FROM v$latch
  WHERE latch# = ln_p2;

v_count number := 0;

BEGIN
    /* Open and fetch the first cursor into a local record */
    FOR lr_wait IN lc_wait LOOP
      
      /* Fetch lc_sql into a local record to capture current sql text based on the
      || sql_address argument from outer cursor lc_wait
      */
      FOR lr_sql in lc_sql(lr_wait.sql_address) LOOP
      dbms_output.put_line(chr(10)||'Current SQL is: '||substr(lr_sql.sql_text,1,200));
      END LOOP;
      
      /* If the event begins with 'db' or 'direct' then fetch the cursor lc_seg
      || into a local record based on the p1 and p2 arguments from outer cursor lc_wait
      */
      IF lr_wait.event LIKE 'db%' OR lr_wait.event LIKE 'direct%' THEN
          FOR lr_seg IN lc_seg(lr_wait.p1, lr_wait.p2) LOOP
             dbms_output.put_line(chr(10)||'Session '||lr_wait.sid||
             ' is doing a '||upper(lr_wait.event)||' on '||lr_seg.owner||'.'
             ||lr_seg.segment_name||' - tablespace '||lr_seg.tablespace_name||
             '.'||chr(10));
             v_count := v_count + 1;
          END LOOP;    

      /* If the event is an 'enqueue' then fetch cursor lc_enqueue into a local 
      || record based on the SID argument from outer cursor lc_wait
      */
      ELSIF lr_wait.event = 'enqueue' THEN
          FOR lr_enqueue in lc_enqueue(lr_wait.sid) LOOP
             dbms_output.put_line(chr(10)||'Enqueue - Locking session is '||
             lr_enqueue.sid||'.'||chr(10)||chr(10)||'Sql text for locking session is: '||
             chr(10)||chr(10)||substr(lr_enqueue.sql_text,1,180)||chr(10));
             v_count := v_count + 1;
          END LOOP;
      
      /* If the event begins with 'library cache' then fetch cursor lc_lbc_lock
      || into a local record based on the SID argument from outer cursor lc_wait
      */
      ELSIF lr_wait.event like 'library cache l%' THEN
          FOR lr_lbc_lock in lc_lbc_lock(lr_wait.sid) LOOP
             dbms_output.put_line(chr(10)||'Library cache load lock - Locking session is '||
             lr_lbc_lock.sid||'.'||chr(10)||chr(10)||'Sql text for locking session is: '||
             chr(10)||chr(10)||substr(lr_lbc_lock.sql_text,1,180)||chr(10));
             v_count := v_count + 1;
          END LOOP;
      
      /* If the event is 'buffer busy waits' then fetch the cursor lc_seg
      || into a local record based on the p1 and p2 arguments from outer cursor lc_wait
      */
      ELSIF lr_wait.event in ('buffer busy waits','free buffer waits') THEN
          FOR lr_seg IN lc_seg(lr_wait.p1, lr_wait.p2) LOOP
             dbms_output.put_line(chr(10)||'Session '||lr_wait.sid||
             ' is waiting on '||upper(lr_wait.event)||'.'||chr(10)||chr(10)||
             'Attempting to access segment '||lr_seg.owner||'.'||lr_seg.segment_name||
             ' - tablespace '||lr_seg.tablespace_name||' in buffer cache.'||chr(10));
             IF lr_wait.event = 'buffer busy waits' THEN
             dbms_output.put_line('Reason for wait is '||lr_wait.p3||'.'||chr(10));
             END IF;
             v_count := v_count + 1;
          END LOOP;    

      /* If the wait event is 'latch free' then fetch cursor lc_latch into a local record 
      || based on the p2 argument from outer cursor lc_wait
      */
      ELSIF lr_wait.event = 'latch free' THEN
          FOR lr_latch in lc_latch(lr_wait.p2) LOOP
             dbms_output.put_line(chr(10)||'Session is waiting on a Latch free.'||chr(10)||
             chr(10)||'Latch: '||lr_latch.name||'.'||chr(10));
             v_count := v_count + 1;
          END LOOP;
      
      /* If the wait event does NOT match any of the above then return the event */
      ELSE 
          dbms_output.put_line(chr(10)||'Session '||lr_wait.sid||' is waiting on a '||
          lr_wait.event||'.'||chr(10));
          v_count := v_count + 1;
      END IF;

  END LOOP;

/* If counter = 0 then cursors lc_wait, lc_enqueue, lc_lbc_lock, lc_latch, and lc_seg were 
|| not populated due to an invalid SID.
*/
  IF v_count = 0 THEN
     dbms_output.put_line(chr(10)||'The SID entered does not exist.'||chr(10));
  END IF;

END;
/ 
