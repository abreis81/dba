set heading off
set pagesize 0
set linesize 79
set verify off
set echo off

spool comp_all.sql

select
    decode( OBJECT_TYPE, 'PACKAGE BODY',
    'alter package ' || OWNER||'.'||OBJECT_NAME || ' compile body;',
    'alter ' || OBJECT_TYPE || ' ' || OWNER||'.'||OBJECT_NAME || ' compile;' )
from
    dba_objects a,
    sys.order_object_by_dependency b
where
    A.OBJECT_ID = B.OBJECT_ID(+) and
    STATUS = 'INVALID' and
    OBJECT_TYPE in ( 'PACKAGE BODY', 'PACKAGE', 'FUNCTION', 'PROCEDURE',
                      'TRIGGER', 'VIEW' )
order by
    DLEVEL DESC,
    OBJECT_TYPE,
    OBJECT_NAME;

spool off

