clear screen
--
set line 100
--
ttitle center "Tabelas que nao possuem CHAINED" skip 2
--
  select table_name
        ,num_rows
        ,blocks
        ,empty_blocks
        ,100*((num_rows * AVG_ROW_LEN)/((GREATEST(blocks,1) + empty_blocks)* 4096)) space_full
        ,chain_cnt
        ,avg_row_len
    from dba_tables
   where chain_cnt = 0
order by table_name
/
ttitle off
