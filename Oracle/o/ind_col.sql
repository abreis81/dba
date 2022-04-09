COLUMN COLUMN_NAME FORMAT A30
COLUMN INDEX_NAME FORMAT A30
set echo off
set ver off
undef tabela
undef owner
ACCEPT TABELA prompt "Tabela: "
ACCEPT owner prompt "owner: "
SELECT INDEX_NAME, COLUMN_NAME, COLUMN_POSITION
FROM DBA_IND_COLUMNS WHERE TABLE_NAME=UPPER('&tABELA')
and TABLE_owner=upper('&owner')
order by INDEX_NAME, COLUMN_POSITION;
select num_rows from dba_tables where table_name=UPPER('&TABELA')
and owner=upper('&owner')
/
select index_name, distinct_keys from dba_indexes where table_name=UPPER('&TABELA')
and owner=upper('&owner')
/
