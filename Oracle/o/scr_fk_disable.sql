set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
--
spool scdifk;
--
column c0 noprint;
column c1 noprint;
--
set term off;
--
-- Script Disable Foreign Key
--
  select a.table_name||a.constraint_name||'q0' c0
        ,0 c1
        ,'alter table '||a.owner||'.'||a.table_name||' disable'
    from sys.dba_constraints a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and a.constraint_type       = 'R'
   union
  select a.table_name||a.constraint_name||'q1' c0
        ,0 c1
        ,' constraint '||a.constraint_name||' ;'
    from sys.dba_constraints a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and a.constraint_type       = 'R'
group by a.table_name
        ,a.constraint_name
order by 1, 2
/
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
