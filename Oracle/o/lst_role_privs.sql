set pagesize 0
spool seroleprivs
select * 
  from sys.dba_role_privs
 where granted_role like upper('&granted_role')
   and grantee      like upper('&grantee');
spool off
