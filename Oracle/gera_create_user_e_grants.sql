set lines 300
set pages 0
set heading off
set feedback off
col comando for a290
spool create_users.sql
SELECT	comando
FROM	(
--################################################################
-- Cria o usuário
select	1 id,'create user '
	||username
	||' identified by values '''
	||password
	||''' default tablespace '
	||default_tablespace
	||' temporary tablespace '
	||temporary_tablespace
	||';' comando
from	dba_users
where	username not in('SYS','SYSTEM','OUTLN','DBSNMP')
--############################################################################
-- Cria Roles
union
select	2 id,'create role '||role||';' comando
from	dba_roles
where	role not in
('CONNECT',
'RESOURCE',
'DBA',
'SELECT_CATALOG_ROLE',
'EXECUTE_CATALOG_ROLE',
'DELETE_CATALOG_ROLE',
'EXP_FULL_DATABASE',
'IMP_FULL_DATABASE',
'GATHER_SYSTEM_STATISTICS',
'LOGSTDBY_ADMINISTRATOR',
'AQ_ADMINISTRATOR_ROLE',
'AQ_USER_ROLE',
'OEM_MONITOR',
'HS_ADMIN_ROLE',
'RECOVERY_CATALOG_OWNER',
'GLOBAL_AQ_USER_ROLE')
--################################################################
-- Atribui quota dos Tablespaces
union
select	3 id,'alter user '
	||username
	||' quota '
	||decode(bytes,0,'unlimited',bytes)
	||' on '
	||tablespace_name
	||';' comando
from	dba_ts_quotas
where	username not in('SYS','SYSTEM','OUTLN','DBSNMP')
--################################################################
-- Grant das roles
union
select 	4 id,'grant '||granted_role||' to '||grantee||';' comando
from	dba_role_privs
where	grantee not in('SYS','SYSTEM','OUTLN','DBSNMP')
--################################################################
-- Grant de systema
union
select 	5 id,'grant '||PRIVILEGE||' to '||grantee||';' comando
from	dba_sys_privs
where	grantee not in('SYS','SYSTEM','OUTLN','DBSNMP')
--################################################################
-- Grant de tabelas
union
select 	6 id,'grant '||PRIVILEGE||' on '||owner||'.'||table_name||' to '||grantee||';' comando
from	dba_tab_privs
where	grantee not in('SYS','SYSTEM','OUTLN','DBSNMP')
)
ORDER BY id;
spool off