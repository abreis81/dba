rem vedepen.sql - Verifica dependencias de owner / objetos
rem
col name format a25;
col type format a12;
col ref_name format a25;
col ref_type format a12;
SELECT name, type, referenced_name ref_name, referenced_type ref_type
FROM sys.dba_dependencies
WHERE referenced_owner like upper('%&REFERENCED_OWNER%')     
  AND name like upper('&NAME')
ORDER BY type,name,ref_type,ref_name
/
