set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
spool sccrind;
column c0 noprint;
column c1 noprint;
set term off;
-- Script Create Index
select a.table_name||a.index_name||'q0' c0, 0 c1,
       'create '||decode(a.uniqueness,'UNIQUE',a.uniqueness,null)||' index '||
        a.owner||'.'||a.index_name
  from sys.dba_indexes a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
 union
select a.table_name||a.index_name||'q1' c0, 0 c1,
       '           on '||a.owner||'.'||a.table_name||' ('
  from sys.dba_indexes a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
 union
select a.table_name||a.index_name||'q2' c0, b.column_position c1,
       '              '||
       b.column_name||
       decode(b.column_position,max(c.column_position),' )',' ,')
  from sys.dba_indexes a, sys.dba_ind_columns b, sys.dba_ind_columns c
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.table_owner       (+) = a.table_owner
   and b.table_name        (+) = a.table_name
   and b.index_owner       (+) = a.owner
   and b.index_name        (+) = a.index_name 
   and c.table_owner       (+) = a.table_owner
   and c.table_name        (+) = a.table_name
   and c.index_owner       (+) = a.owner
   and c.index_name        (+) = a.index_name 
 group by a.table_name, a.index_name, b.column_position, b.column_name
 union
select a.table_name||a.index_name||'q3' c0, 0 c1,
       '      storage (initial '||b.bytes||' next '||b.next_extent||
       '  pctincrease '||b.pct_increase||')'
  from sys.dba_indexes a, sys.dba_segments b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.segment_name      (+) = a.index_name
 union
select a.table_name||a.index_name||'q4' c0, 0 c1,
       '   tablespace '||b.tablespace_name||';'
  from sys.dba_indexes a, sys.dba_segments b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.segment_name      (+) = a.index_name
 order by 1, 2;
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
