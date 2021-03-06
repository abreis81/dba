/*
  script:   lst_table_block.sql
  objetivo: verificacao de chained e migracao
  autor:    Josivan
  data:     
*/
--
set lines 90
set pagesize 100
--
column table_name       format a30      heading "Table"
column blocks           format 999,999  heading "Blocks" 
column empty_blocks     format 999,999  heading "Empties" 
column space_full       format 999.99   HEADING "% Full" 
column num_rows         format 99,999,999  HEADING "Rows"
column chain_cnt        format 999,999  HEADING "Chains"
column avg_row_len      format 999,999  HEADING "Avg(Bytes)"
--
  select table_name
        ,num_rows
        ,blocks
        ,empty_blocks
        ,100*((num_rows * AVG_ROW_LEN)/((GREATEST(blocks,1) + empty_blocks) * 4096)) space_full
        ,chain_cnt
        ,avg_row_len
    from dba_tables    
   where tablespace_name like('GF%')
order by table_name
/
