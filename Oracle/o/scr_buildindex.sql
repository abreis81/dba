set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
spool screbuild;
--
column c0 noprint;
column c1 noprint;
--
set term off;
--
-- Script Create Index
--
  select a.table_name||a.index_name||'q0' c0
        ,0 c1
        ,'alter index '||a.owner||'.'||a.index_name||' rebuild '
    from sys.dba_indexes a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
   union
  select a.table_name||a.index_name||'q3' c0
        ,0 c1
        ,'      storage (initial '||b.bytes||' next '||b.next_extent||'  pctincrease '||b.pct_increase||')'
    from sys.dba_indexes a
        ,sys.dba_segments b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.segment_name      (+) = a.index_name
   union
  select a.table_name||a.index_name||'q4' c0
        ,0 c1,
         '   tablespace '||b.tablespace_name||' unrecoverable;'
    from sys.dba_indexes a
        ,sys.dba_segments b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.segment_name      (+) = a.index_name
order by 1, 2;
--
set verify on;
set feedback on;
set pagesize 14;
set heading on;
undefine TABELA;
set term on;
