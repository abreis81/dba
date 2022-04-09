set ver off pause off feed off head off lines 80 pages 0 wrap on
col com  format  a80
col erro format a80
spool c:\temp\compilar_&&BASE..sql
set transaction use rollback segment r06

select 'alter '||decode(a.object_type,'PACKAGE BODY','PACKAGE',a.object_type)
  ||' '||a.OWNER||'."'||a.object_name||'" compile '
--  ||' '||a.OWNER||'.'||a.object_name||' compile '
  ||decode(a.object_type,'PACKAGE BODY','BODY')||';' com,
--'show errors '||a.object_type||' '||a.OWNER||'."'||a.object_name||'"' erro
'show errors '||a.object_type||' '||a.OWNER||'.'||a.object_name erro
from order_object_by_dependency p, sys.all_objects a
where p.object_id      = a.object_id
and   a.status         = 'INVALID'
and   a.object_type   in ('FUNCTION','PROCEDURE','TRIGGER','VIEW','PACKAGE','PACKAGE BODY')
order by a.owner asc,dlevel desc
/
select 'alter index '||owner||'.'||index_name||' rebuild ONLINE;' from dba_indexes where status<>'VALID'
/
spool off
set ver on pause off feed on head on
@c:\temp\compilar_&&BASE..sql
