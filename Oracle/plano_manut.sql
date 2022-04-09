/*
SET LINESIZE 145
SET PAGESIZE 9999

COLUMN sid               FORMAT 99999      HEADING 'SID'
COLUMN serial#           FORMAT 99999999   HEADING 'serial#'
COLUMN sql_id            FORMAT a9         HEADING 'sql_id'          JUSTIFY right
COLUMN session_status    FORMAT a9         HEADING 'Status'          JUSTIFY right
COLUMN USERNAME          FORMAT a14        HEADING 'USERNAME'        JUSTIFY right
COLUMN LOGON_TIME        FORMAT a20        HEADING 'LOGON_TIME'      JUSTIFY right
COLUMN os_username       FORMAT a12        HEADING 'O/S User'        JUSTIFY right
COLUMN os_pid            FORMAT 9999999    HEADING 'O/S PID'         JUSTIFY right
COLUMN session_program   FORMAT a26        HEADING 'Session Program' TRUNC
COLUMN session_terminal  FORMAT a10        HEADING 'Terminal'        JUSTIFY right
COLUMN session_machine   FORMAT a19        HEADING 'Machine'         JUSTIFY right
COLUMN Startup_Time      FORMAT a25        HEADING 'Startup_Time'    JUSTIFY right
COLUMN EVENT             FORMAT a35        HEADING 'EVENT'           JUSTIFY right
COLUMN LOCKWAIT          FORMAT a20        HEADING 'LOCKWAIT'        JUSTIFY right

prompt 
prompt +----------------------------------------------------+
prompt | Active User Sessions (All)                         |
prompt +----------------------------------------------------+
*/
SELECT
  i.INST_ID 
  ,  s.SQL_HASH_VALUE     SQL_HASH_VALUE
  , s.sid                sid
  , s.serial#            serial#
  , sql_id               sql_id
  , lpad(s.status,9)     session_status
  , lpad(s.username,14)  USERNAME
  , TO_CHAR(s.LOGON_TIME,'DD/MM/YYYY:HH24:MI:SS') LOGON_TIME
  , lpad(s.osuser,12)    os_username
  , lpad(p.spid,7)       os_pid
  , s.program            session_program
  , lpad(s.terminal,10)  session_terminal
  , lpad(s.machine,19)   session_machine
  , s.SQL_HASH_VALUE     SQL_HASH_VALUE
  , s.PREV_HASH_VALUE    PREV_HASH_VALUE
  , s.EVENT              EVENT
  , s.LOCKWAIT           LOCKWAIT
  , s.SECONDS_IN_WAIT    SECONDS_IN_WAIT
  , TO_CHAR(i.startup_time,'DD/MM/YYYY:HH24:MI:SS') Startup_Time
FROM
   gv$process p
  , gv$session s
  , gv$instance i 
WHERE
    p.addr (+) = s.paddr
    and p.INST_ID = s.INST_ID
    and s.INST_ID = i.INST_ID
--  AND s.status   = 'ACTIVE'
  AND s.sid=2486
  AND s.username IS NOT null
ORDER BY sid
/
/*
=================================================================================================================================================
                                                                                              Para ver o plano de execução:
=================================================================================================================================================

select * from table(dbms_xplan.display_cursor('&&HASH_VALUE'));

select * from table(dbms_xplan.display_cursor('&&HASH_VALUE'));
