set lines 200
set pages 0
set ver off
undef sid
select 'alter system kill session '||''''||sid||','||serial#||''''||';' from 
v$session where sid=&sid;