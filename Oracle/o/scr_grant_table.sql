set pagesize 0
set head off
set feed off
set linesize 140
spool spgrant.sql

select 'grant execute on ' || substr(object_name,1,40) || ' to GALP;'
  from user_objects
 where object_type in ('PROCEDURE','FUNCTION','PACKAGE');

select 'grant all on ' || substr(object_name,1,40) || ' to GALP;'
  from user_objects
 where object_type in ('SEQUENCE','VIEW');

Select 'Grant Select, Insert, Update, Delete On ' ||substr(object_name,1,40) || ' To GALP;'
  from user_objects
 where object_type in ('TABLE'); 

spool off;
