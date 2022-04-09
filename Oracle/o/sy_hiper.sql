alter session set nls_date_format='dd/mm/yy';
col loc new_value loc noprint
select substr(global_name,1,4) loc from global_name;
spool C:\TEMP\SY.&&loc
SELECT 'CREATE PUBLIC SYNONYM '||OBJECT_NAME||' FOR '||OWNER||'.'||OBJECT_NAME||';'
FROM DBA_OBJECTS
WHERE   (TRUNC(LAST_DDL_TIME) = trunc(sysdate) or trunc(created) = trunc(sysdate))
AND OBJECT_TYPE NOT IN ('TRIGGER')
/
SPOOL OFF
@C:\TEMP\SY.&&loc
