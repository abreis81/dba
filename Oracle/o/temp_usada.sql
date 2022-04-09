column tablespace format a20
column username format a15
column osuser format a15
set lines 300
select a.tablespace, b.sid, b.serial#, b.username, b.osuser,((a.blocks*c.value)/1024)/1024 Ocupado_MB
from v$sort_usage a, v$session b, v$parameter c
where
a.SESSION_ADDR = b.SADDR and
lower(c.name)='db_block_size'
order by 6 asc;