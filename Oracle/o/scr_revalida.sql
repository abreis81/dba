/*
  script:   scr_revalida.sql
  objetivo: revalidar objetos
  autor:    Josivan
  data:     
*/

set feed off
set pagesize 0
set termout off
--
spool rev__.sql
--
select 'set termout on' from dual;
select 'set echo on' from dual;
--
  select 'alter ' || rtrim(object_type) || ' ' || rtrim(object_name)||' compile;'
    from user_objects
   where status = 'INVALID'
     and object_type not in ('PACKAGE BODY')
order by object_name 
/

select 'alter package ' ||  rtrim(object_name) ||' compile body;'
  from user_objects
 where status = 'INVALID'
   and object_type in ('PACKAGE BODY')
/

spool off
@rev__
set echo off
set termout off
host rm make__.sql
set feed on
set pagesize 24
set termout on
