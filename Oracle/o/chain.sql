select
  owner       c1,
  table_name     c2,
  pct_free      c3,
  pct_used      c4,
  avg_row_len    c5,
  num_rows      c6,
  chain_cnt     c7,
  chain_cnt/num_rows c8
from dba_tables
where
owner not in ('SYS','SYSTEM','PERFSTAT')
and
(chain_cnt/num_rows > .1 or chain_cnt > 1000)
and
table_name not in
 (select table_name from dba_tab_columns
  where
 data_type in ('RAW','LONG RAW')
 )
and
chain_cnt > 0
order by chain_cnt desc
;
