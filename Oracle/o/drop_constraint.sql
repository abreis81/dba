/*
  script:   drop_constraint.sql
  objetivo: drop as constraints
  autor:    Josivan
  data:     
*/

set head off
set pagesize 0
set feed off
set linesize 300
spool dropchk.sql
--
select 'spool dropchk.lst' from dual;

select 'alter table '||rtrim(table_name)||' drop constraint '||rtrim(constraint_name)||';'
  from user_constraints
 where constraint_type = 'C'
   and constraint_name like 'SYS_%'
   and table_name not like '%INTERFACE%'
/

select 'spool off' from dual;

spool off
set feed on
set head on
set pagesize 25
