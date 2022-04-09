-- pctused.sql
-- © 2000 by Donald Keith Burleson
set heading off;
set pages 9999;
set feedback off;
spool pctused.lst;
define spare_rows = 2;
define blksz = 8192;
select
  ' alter table '||owner||'.'||table_name||
  ' pctused '||least(round(100-((&spare_rows*avg_row_len)/(&blksz/10))),95)||
  ' '||
  ' pctfree '||greatest(round((&spare_rows*avg_row_len)/(&blksz/10)),5)||
  ';'
from
  dba_tables
where
avg_row_len > 1
and
avg_row_len < 2000
and
table_name not in
 (select table_name from dba_tab_columns b
  where
 data_type in ('RAW','LONG RAW','BLOB','CLOB')
 )
order by owner, table_name
/
spool off;
