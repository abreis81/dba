set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
spool sccrfk;
column c0 noprint;
column c1 noprint;
set term off;
-- Script Create Foreign Key
select a.table_name||a.constraint_name||'q0' c0
      ,0 c1
      ,'alter table '||a.owner||'.'||a.table_name||' add ('
  from sys.dba_constraints a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'R'
 union
select a.table_name||a.constraint_name||'q1' c0
      ,0 c1
      ,' constraint '||a.constraint_name||' foreign key ('
  from sys.dba_constraints a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'R'
 union
select a.table_name||a.constraint_name||'q2' c0
      ,b.position c1
      ,'            '||b.column_name||decode(b.position,max(c.position),' )',' ,')
  from sys.dba_constraints a, sys.dba_cons_columns b, sys.dba_cons_columns c
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'R'
   and b.owner             (+) = a.owner
   and b.table_name        (+) = a.table_name
   and b.constraint_name   (+) = a.constraint_name
   and c.owner             (+) = a.owner
   and c.table_name        (+) = a.table_name
   and c.constraint_name   (+) = a.constraint_name
 group by a.table_name
         ,a.constraint_name
         ,b.position
         ,b.column_name
 union
select a.table_name||a.constraint_name||'q3' c0
      ,0 c1
      ,' references '||b.owner||'.'||b.table_name||' ('
  from sys.dba_constraints a, sys.dba_constraints b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'R'
   and b.owner             (+) = a.r_owner
   and b.constraint_name   (+) = a.r_constraint_name
 union
select a.table_name||a.constraint_name||'q4' c0
      ,b.position c1
      ,'            '||b.column_name||decode(b.position,max(c.position),' ));',' ,')
  from sys.dba_constraints a, sys.dba_cons_columns b, sys.dba_cons_columns c
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'R'
   and b.owner             (+) = a.r_owner
   and b.constraint_name   (+) = a.r_constraint_name
   and c.owner             (+) = a.r_owner
   and c.constraint_name   (+) = a.r_constraint_name
 group by a.table_name
         ,a.constraint_name
         ,b.position
         ,b.column_name
 order by 1, 2;
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
