set ver off
set echo off
set head off
accept usuario prompt "Digite o usuario: "
select 'alter user &&usuario identified by values '||''''||password||''''||';'
from dba_users where username=upper('&usuario');
set head on

