
/*
  script:   trigger_alter.sql 
  objetivo: Relatorio diario 
  autor:    Josivan
  data:     
*/

set head off
set pagesize 0
set feed off
set linesize 300
--
spool dtrigger.sql

select 'spool dtrigger.lst' from dual;
select 'alter trigger ' || rtrim(trigger_name) || ' disable;'
  from user_triggers;
select 'spool off' from dual;

spool off
--
spool etrigger.sql

select 'spool etrigger.lst' from dual;

select 'alter trigger ' || rtrim(trigger_name) || ' enable;'
  from user_triggers;

select 'spool off' from dual;

spool off
set feed on
set head on
set pagesize 25
