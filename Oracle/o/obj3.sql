set echo off
set head on
set ver off
col object_name format a40
col table_name format a40
set lines 200
set pages 1000

alter session set nls_date_format='dd/mm/yyyy hh24:mi';



select object_name, object_type, created, last_ddl_time 
from USER_objects where object_name='SP_IC_INTEGRA_COMPRA_PULLFLOW';

select grantee, privilege, table_name 
from USER_tab_privs where table_name='SP_IC_INTEGRA_COMPRA_PULLFLOW';

set echo on
set head on
set ver on