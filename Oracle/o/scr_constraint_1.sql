set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :';
accept ARQUIVO char prompt 'Tecle o <arquivo>.lst :';
--
spool &&ARQUIVO;
--
column c0 noprint;
column c1 noprint;
--
set term off;
--
/*------------------------*/
||                        ||
|| Script Create Table    ||
||                        ||
*/------------------------*/
select a.table_name||'q0' c0
      ,0 c1
      ,'create table '||a.owner||'.'||a.table_name||' ('
  from sys.dba_tables a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
 union
select a.table_name||'q1' c0
      ,b.column_id c1
      ,'             '||rpad(b.column_name,31,' ')
                      ||rpad(b.data_type||decode(b.data_type,'VARCHAR','('||b.data_length||')','VARCHAR2','('||b.data_length||')'
      ,'CHAR'
      ,'('||b.data_length||')'
      ,decode(b.data_precision,null,null,
         decode(b.data_scale,null,'('||b.data_precision||')',0,'('||b.data_precision||')','('||b.data_precision||','||b.data_scale||')'))),20,' ')||
         decode(b.nullable,'N','NOT NULL','NULL')||decode(b.column_id,max(c.column_id),' )',' ,')
    from sys.dba_tables a
        ,sys.dba_tab_columns b
        ,sys.dba_tab_columns c
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.table_name        (+) = a.table_name
     and c.owner             (+) = b.owner
     and c.table_name        (+) = b.table_name
group by a.table_name
        ,b.column_id
        ,b.column_name
        ,b.data_type
        ,b.data_length
        ,b.data_precision
        ,b.data_scale
        ,b.nullable
   union
  select a.table_name||'q2' c0
        ,0 c1
        ,'     storage (initial '||b.bytes||' next '||b.next_extent||' pctincrease '||b.pct_increase||')'
    from sys.dba_tables a
        ,sys.dba_segments b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.segment_name      (+) = a.table_name
   union
  select a.table_name||'q3' c0
        ,0 c1
        ,'  tablespace '||b.tablespace_name||';'
    from sys.dba_tables a
        ,sys.dba_segments b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.segment_name      (+) = a.table_name
order by 1, 2;

/*----------------------------*/
||                            ||
|| Script Create Primary Key  ||
||                            ||
*/----------------------------*/
select a.table_name||a.constraint_name||'q0' c0
      ,0 c1
      ,'alter table '||a.owner||'.'||a.table_name||' add ('
  from sys.dba_constraints a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'P'
 union
select a.table_name||a.constraint_name||'q1' c0
      ,0 c1
      ,' constraint '||a.constraint_name||' primary key ('
  from sys.dba_constraints a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'P'
 union
select a.table_name||a.constraint_name||'q2' c0
      ,b.position c1
      ,'            '||b.column_name||decode(b.position,max(c.position),' ))',' ,')
  from sys.dba_constraints a
      ,sys.dba_cons_columns b
      ,sys.dba_cons_columns c
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'P'
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
      ,'     enable primary key using index'
  from sys.dba_constraints a
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type = 'P'
 union
select a.table_name||a.constraint_name||'q4' c0
      ,0 c1
      ,'    storage (initial '||b.bytes||' next '||b.next_extent||' pctincrease '||b.pct_increase||')'
  from sys.dba_constraints a
      ,sys.dba_segments b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'P'
   and b.owner             (+) = a.owner
   and b.segment_name      (+) = a.constraint_name
 union
select a.table_name||a.constraint_name||'q5' c0
      ,0 c1
      ,' tablespace '||b.tablespace_name||' unrecoverable;'
  from sys.dba_constraints a
      ,sys.dba_segments b
 where a.owner              like upper ('&&OWNER')
   and a.table_name         like upper ('&&TABELA')
   and a.constraint_type       = 'P'
   and b.owner             (+) = a.owner
   and b.segment_name      (+) = a.constraint_name
 order by 1, 2;

/*------------------------*/
||                        ||
|| Script Create Index    ||
||                        ||
*/------------------------*/
  select a.table_name||a.index_name||'q0' c0
        ,0 c1
        ,'create '||decode(a.uniqueness,'UNIQUE',a.uniqueness,null)||' index '||a.owner||'.'||a.index_name
    from sys.dba_indexes a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and not exists (select 1 from sys.dba_constraints b
                      where  b.owner          = a.owner 
                        and b.table_name      = a.table_name 
                        and b.constraint_name = a.index_name
                        and b.constraint_type = 'P')
   union
  select a.table_name||a.index_name||'q1' c0
        ,0 c1
        ,'           on '||a.owner||'.'||a.table_name||' ('
    from sys.dba_indexes a
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and not exists (select 1 from sys.dba_constraints b
                      where  b.owner          = a.owner 
                        and b.table_name      = a.table_name 
                        and b.constraint_name = a.index_name
                        and b.constraint_type = 'P')
   union
  select a.table_name||a.index_name||'q2' c0
        ,b.column_position c1
        ,'              '||b.column_name||decode(b.column_position,max(c.column_position),' )',' ,')
    from sys.dba_indexes a
        ,sys.dba_ind_columns b
        ,sys.dba_ind_columns c
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
     and not exists (select 1 from sys.dba_constraints b
                      where b.owner           = a.owner 
                        and b.table_name      = a.table_name 
                        and b.constraint_name = a.index_name
                        and b.constraint_type = 'P')
group by a.table_name
        ,a.index_name
        ,b.column_position
        ,b.column_name
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
     and not exists (select 1 from sys.dba_constraints b
                      where  b.owner          = a.owner 
                        and b.table_name      = a.table_name 
                        and b.constraint_name = a.index_name
                        and b.constraint_type = 'P')
   union
  select a.table_name||a.index_name||'q4' c0
        ,0 c1
        ,'   tablespace '||b.tablespace_name||' unrecoverable;'
    from sys.dba_indexes a, sys.dba_segments b
   where a.owner              like upper ('&&OWNER')
     and a.table_name         like upper ('&&TABELA')
     and b.owner             (+) = a.owner
     and b.segment_name      (+) = a.index_name
     and not exists (select 1 from sys.dba_constraints b
                      where  b.owner          = a.owner 
                        and b.table_name      = a.table_name 
                        and b.constraint_name = a.index_name
                        and b.constraint_type = 'P')
order by 1, 2;
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
