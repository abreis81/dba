set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
--
spool scdrcon;
--
column c0 noprint;
--
set term off;
--
-- Script Drop Constraint
--
  select a.constraint_name||'q0' c0, 
         '    alter table '||a.owner||'.'||a.table_name
    from sys.dba_constraints a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and a.constraint_type      != 'C'
   union
  select a.constraint_name||'q1' c0, 
         'drop constraint '||a.constraint_name||';'
    from sys.dba_constraints a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and a.constraint_type      != 'C'
order by 1
/
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
