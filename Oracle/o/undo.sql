column   sid format   999
column   segment_name format   a15
select b.segment_name, a.username, a.sid, a.serial#, c.used_ublk, 
c.used_urec,c.START_UBAFIL, c.START_UBABLK, c.START_UBAREC , b.status,
b.TABLESPACE_NAME, b.SEGMENT_ID, b.FILE_ID, b.BLOCK_ID
from v$session a, dba_rollback_segs b, v$transaction c
where b.segment_id = c.xidusn
  and a.taddr = c.addr;