set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
--
spool scdrrcon;
--
column c0 noprint;
--
set term off;
--
-- Script Drop R_Constraint
--
  select b.table_name||b.constraint_name||'q0' c0
        ,'    alter table '||b.owner||'.'||b.table_name
    from sys.dba_constraints a
        ,sys.dba_constraints b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and a.constraint_type       = 'P'
     and b.r_constraint_name (+) = a.constraint_name
     and b.constraint_type   (+) = 'R'
   union
  select b.table_name||b.constraint_name||'q1' c0, 
         'drop constraint '||b.constraint_name||';'
    from sys.dba_constraints a
        ,sys.dba_constraints b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and a.constraint_type       = 'P'
     and b.r_constraint_name (+) = a.constraint_name
     and b.constraint_type   (+) = 'R'
order by 1
/
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
