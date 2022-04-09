set pagesize 0
--
select * 
  from sys.dba_sys_privs
 where grantee like upper('&grantee')
/

