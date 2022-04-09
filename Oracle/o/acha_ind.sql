accept tabela
accept usuario
select index_name from dba_indexes where table_name=upper('&tabela')
and owner=upper('&usuario')
/