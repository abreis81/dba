
set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
spool &&1;
--
column c1 noprint;
column c2 noprint;
--
set term off;
--
-- Script Create R_Constraint
--
select b.table_name||b.constraint_name||'q1' c1
      ,0 c2
      ,'alter table '||b.owner||'.'||b.table_name||' add ('
  from sys.dba_constraints a
      ,sys.dba_constraints b
 where a.owner              like upper ('&&1')
   and a.constraint_type       = 'P'
   and b.r_owner           (+) = a.owner
   and b.r_constraint_name (+) = a.constraint_name
   and b.constraint_type   (+) = 'R'
 union
select b.table_name||b.constraint_name||'q2' c1
      ,0 c2
      ,' constraint '||b.constraint_name||' foreign key ('
  from sys.dba_constraints a
      ,sys.dba_constraints b
 where a.owner              like upper ('&&1')
   and a.constraint_type       = 'P'
   and b.r_owner           (+) = a.owner
   and b.r_constraint_name (+) = a.constraint_name
   and b.constraint_type   (+) = 'R'
 union
select b.table_name||b.constraint_name||'q3' c1
      ,c.position c2
      ,'            '||c.column_name||decode(c.position,max(d.position),' )',' ,')
  from sys.dba_constraints a
      ,sys.dba_constraints b
      ,sys.dba_cons_columns c
      ,sys.dba_cons_columns d
 where a.owner              like upper ('&&1')
   and a.constraint_type       = 'P'
   and b.r_owner           (+) = a.owner
   and b.r_constraint_name (+) = a.constraint_name
   and b.constraint_type   (+) = 'R'
   and c.owner             (+) = b.owner
   and c.table_name        (+) = b.table_name
   and c.constraint_name   (+) = b.constraint_name
   and d.owner             (+) = b.owner
   and d.table_name        (+) = b.table_name
   and d.constraint_name   (+) = b.constraint_name
 group by b.table_name
         ,b.constraint_name
         ,c.column_name
         ,c.position
 union
select b.table_name||b.constraint_name||'q4' c1
      ,0 c2
      ,' references '||a.owner||'.'||a.table_name||' ('
  from sys.dba_constraints a
      ,sys.dba_constraints b
 where a.owner              like upper ('&&1')
   and a.constraint_type       = 'P'
   and b.r_owner           (+) = a.owner
   and b.r_constraint_name (+) = a.constraint_name
   and b.constraint_type   (+) = 'R'
union
  select b.table_name||b.constraint_name||'q5' c1
        ,c.position c2
        ,'            '||c.column_name||decode(c.position,max(d.position),' ) );',' ,')
    from sys.dba_constraints a
        ,sys.dba_constraints b
        ,sys.dba_cons_columns c
        ,sys.dba_cons_columns d
   where a.owner              like upper ('&&1')
     and a.constraint_type       = 'P'
     and b.r_owner           (+) = a.owner
     and b.r_constraint_name (+) = a.constraint_name
     and b.constraint_type   (+) = 'R'
     and c.owner             (+) = a.owner
     and c.table_name        (+) = a.table_name
     and c.constraint_name   (+) = a.constraint_name
     and d.owner             (+) = a.owner
     and d.table_name        (+) = a.table_name
     and d.constraint_name   (+) = a.constraint_name
group by b.table_name
        ,b.constraint_name
        ,c.column_name
        ,c.position
 order by 1, 2;

set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
