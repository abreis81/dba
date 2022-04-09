set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
--
column c0 noprint;
column c1 print;
--
break on c1;
--
select a.table_name||'q0'||' ' c0
      ,'Table/Owner:' c1
      ,rpad(a.table_name,30,' ')||' '||rpad(a.owner,30,' ')
  from sys.dba_tables a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
 union
select a.table_name||'q1'||b.constraint_type c0
      ,'Constraints:' c1
      ,rpad(b.constraint_name,30,' ')||' '||rpad(b.constraint_type,1,' ')||' '||rpad(b.status,11,' ')
  from sys.dba_tables a
      ,sys.dba_constraints b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.table_name        (+) = a.table_name
   and b.constraint_type   (+)!= 'C'
 union
select a.table_name||'q2'||decode(substr(b.uniqueness,1,1),'U','A','B') c0
      ,'Indexes    :' c1
      ,rpad(b.index_name,30,' ')||' '||rpad(b.uniqueness,1,' ')||' '||rpad(b.status,11,' ')
  from sys.dba_tables a
      ,sys.dba_indexes b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.table_owner       (+) = a.owner
   and b.table_name        (+) = a.table_name
 union
select a.table_name||'q3' c0
      ,'            ' c1
      ,' '
  from sys.dba_tables a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
 order by 1, 3
/
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
