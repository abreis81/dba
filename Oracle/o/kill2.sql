spool c:\kill.sql
SELECT 'alter system kill session '||''''||a.sid||','||a.serial#||''''||' ;'
  FROM V$session a
      ,v$lock b
 WHERE a.sid=b.sid and a.username='REPADMIN'
/
spool off
