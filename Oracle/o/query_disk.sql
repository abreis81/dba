column statment format a40
column username format a15
col rds_exec_ratio format 9999999.99
col percent format 99.99
select b.username, a.disk_reads reads,
(a.disk_reads*100)/c.total percent,a.executions exec,
a.disk_reads / decode(a.executions, 0, 1, a.executions) rds_exec_ratio,
a.command_type, a.sql_text statment
from v$sqlarea a,dba_users b
,(select sum(disk_reads) total from v$sqlarea) c
where a.parsing_user_id = b.user_id
and a.disk_reads > 500000
order by 2 desc,3 desc
/
