SELECT s.sid,sysdate,s.username, A.executions, a.disk_reads,
       decode(executions,0,0,round(a.disk_reads/A.executions,5)) as media_io,
       s.saddr, A.sql_text, s.username, s.status, s.schemaname, s.machine, s.terminal,
       s.program
  FROM v$session s, V$SQLAREA A
 WHERE s.sql_address = a.address
 ORDER BY a.DISK_READS desc
