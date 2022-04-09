set heading off
set linesize 1000
spool c:\banconovo\cons_edge.sql
select a.table_name, 'alter table '||a.table_name||' add constraint '||b.constraint_name||
' PRIMARY KEY('||substr(a.column_name,1,15)||') using index tablespace ix_prod' 
from dba_cons_columns a, dba_constraints b
where a.constraint_name=b.constraint_name and a.owner='EDGE' and
b.constraint_type='P'
order by a.position;
spool off


