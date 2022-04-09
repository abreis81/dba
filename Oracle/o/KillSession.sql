select 'alter system kill session '||''''||sid||','||serial#||''''||';' from v$session where terminal in (
select terminal from v$session where sid in (
select SESSION_ID from v$locked_object where object_id=2645))
/