set head off
set pagesize 0
set feed off
set linesize 300
--
spool dconstr.sql
--
select 'spool dconstr.lst' from dual;
--
select 'alter table ' || rtrim(table_name) || ' disable constraint ' ||rtrim(constraint_name) || ';'
  from user_constraints
 where constraint_type = 'R';
--
select 'spool off' from dual;
--
spool off
spool econstr.sql
--
select 'spool econstr.lst' from dual;
--
select 'alter table ' || rtrim(table_name) || ' enable constraint ' ||rtrim(constraint_name) || ';'
  from user_constraints
 where constraint_type = 'R';
--
select 'spool off' from dual;
--
spool off
set feed on
set head on
set pagesize 25
