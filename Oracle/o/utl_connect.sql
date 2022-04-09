rem 
rem  nome        : utl_connect.sql
rem  objetivo    : Forcar conexao com outro username sem senha
rem  uso         : sqlplus ou similar
rem  limitacoes  : dba
rem 

clear screen
set verify off
set feedback off
set echo off

accept p_user    prompt "Username........ ? [ ] "
--
select 'alter user '||username||' identified by values '||''''||password||''''||';'
  from dba_users
 where username = upper('&&p_user')
/

alter user &p_user identified by teste;

set termout on
connect &p_user/teste

show user

set verify on
set feedback on
set echo on
