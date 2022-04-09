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
column c1 noprint;
--
break on c2 on c3;
--
  select a.table_name||'q0'||' '   c0
        ,0                         c1
        ,'Tab/Own:'                c2
        ,rpad(a.table_name,30,' ') c3
        ,rpad(a.owner,30,' ')
    from sys.dba_tables a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
   union
  select a.table_name||'q1'||b.constraint_type||b.constraint_name c0
        ,c.position c1
        ,'Constrs:' c2
        ,rpad(b.constraint_name,30,' ')||' '||rpad(b.constraint_type,1,' ')||' '||rpad(b.status,3,' ') c3
        ,rpad(c.column_name,30,' ')||' '||lpad(c.position,2,' ')
    from sys.dba_tables a
        ,sys.dba_constraints b
        ,sys.dba_cons_columns c
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.table_name        (+) = a.table_name
     and b.constraint_type   (+)!= 'C'
     and c.owner             (+) = b.owner
     and c.table_name        (+) = b.table_name
     and c.constraint_name   (+) = b.constraint_name
   union
  select a.table_name||'q2'||decode(substr(b.uniqueness,1,1),'U','A','B')||b.index_name c0
        ,c.column_position c1
        ,'Indexes:' c2
        ,rpad(b.index_name,30,' ')||' '||rpad(b.uniqueness,1,' ')||' '||rpad(b.status,3,' ') c3
        ,rpad(c.column_name,30,' ')||' '||lpad(c.column_position,2,' ')
    from sys.dba_tables a
        ,sys.dba_indexes b
        ,sys.dba_ind_columns c
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.table_owner       (+) = a.owner
     and b.table_name        (+) = a.table_name
     and c.index_owner       (+) = b.owner
     and c.index_name        (+) = b.index_name
     and c.table_owner       (+) = b.table_owner
     and c.table_name        (+) = b.table_name
   union
  select a.table_name||'q3' c0
        ,0 c1
        ,' ' c2
        ,' ' c3
        ,' '
    from sys.dba_tables a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
order by 1, 2
/
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
