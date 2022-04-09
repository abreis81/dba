SET PAGES 1000
accept usr prompt "digite o usuario:"
select 'alter system kill session '||''''||sid||','||serial#||''''||'IMMEDIATE;'||'         '||USERNAME||' '||osuser||' '||MACHINE
from v$session
where username LIKE UPPER('&&usr%')
/