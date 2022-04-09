set echo off

accept objeto prompt "Digite o nome do Objeto: "
accept usuario prompt "Digite o owner: "  

set echo off
set head on
set ver off
col object_name format a40
col table_name format a40
set lines 200
set pages 1000

alter session set nls_date_format='dd/mm/yyyy hh24:mi';



select owner, object_name, object_type, created, last_ddl_time 
from dba_objects where object_name like upper('%&objeto%')
and owner =UPPER('&usuario');

select grantee, privilege, table_name 
from dba_tab_privs where table_name like upper('%&objeto%')
and owner =UPPER('&usuario');

set head on
set ver on