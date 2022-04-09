column column_name format a20
prompt Digite o nome da tabela
accept tabela
select owner, constraint_name, decode(constraint_type,'C','check','P','Primary') tipo
from dba_constraints where table_name=upper('&tabela')
/
select owner, constraint_name, column_name, position from dba_cons_columns
where table_name=upper('&tabela')
/