/*
  script:   lst_fk_table.sql
  objetivo: lista o relacionamento da tabela origem com suas dependentes
  autor:    Josivan
  data:     
  bibliotecas:  DBA_CONSTRAINTS
                DBA_CONS_COLUMNS
*/
--
clear screen
--
col table_name      format A15 head 'TABLE_NAME'
col constraint_name format A30 head 'CONSTRAINT_NAME'
col column_name     format A25 head 'COLUNA_UTILIZADA'
col table2          format A25 head 'TABLE_REFERENCIADA'
--
ttitle center "TABELAS RELACIONADAS" skip 2
--
set linesize 100
--
  select t.table_name
        ,c.constraint_name
        ,acc.column_name
        ,c.table_name       table2
    from all_constraints t
        ,all_constraints c
        ,all_cons_columns acc
   where c.r_constraint_name = t.constraint_name
     and c.table_name        = acc.table_name
     and c.constraint_name   = acc.constraint_name
     and t.table_name        = '&tabela'
/
