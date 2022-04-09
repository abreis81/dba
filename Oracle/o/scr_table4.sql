set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
spool &&FILENAME;
column c0 noprint;
column c1 noprint;
set term off;
-- Script Create Table
select a.table_name||'q0' c0, 0 c1,
       'create table '||a.owner||'.'||a.table_name||' ('
  from sys.dba_tables a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
 union
select a.table_name||'q1' c0, b.column_id c1,
       '             '||
       rpad(b.column_name,35,' ')||
       rpad(b.data_type||decode(b.data_type,'VARCHAR',
                           '('||b.data_length||')',
                                       'VARCHAR2',
                           '('||b.data_length||')',
                                       'CHAR',
                           '('||b.data_length||')',
                           decode(b.data_precision,null,
                                  null,
                                  decode(b.data_scale,null,
                                         '('||b.data_precision||')',
                                                      0,
                                         '('||b.data_precision||')',
                                         '('||b.data_precision||','||
                                              b.data_scale||')'
                                        )
                                 )
                          ),15,' ')||
       decode(b.nullable,'N','NOT NULL','NULL')||
       decode(b.column_id,max(c.column_id),' )',' ,')
  from sys.dba_tables a, sys.dba_tab_columns b, sys.dba_tab_columns c
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.table_name        (+) = a.table_name
   and c.owner             (+) = b.owner
   and c.table_name        (+) = b.table_name
 group by a.table_name, b.column_id, b.column_name, b.data_type,
          b.data_length, b.data_precision, b.data_scale, b.nullable
 union
select a.table_name||'q2' c0, 0 c1,
       '     storage (initial '||b.bytes||' next '||b.next_extent||
       ' pctincrease '||b.pct_increase||')'
  from sys.dba_tables a, sys.dba_segments b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.segment_name      (+) = a.table_name
 union
select a.table_name||'q3' c0, 0 c1,
       '  tablespace '||b.tablespace_name||';'
  from sys.dba_tables a, sys.dba_segments b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and b.owner             (+) = a.owner
   and b.segment_name      (+) = a.table_name
 order by 1, 2;
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine FILENAME;
undefine TABELA;
set term on;
