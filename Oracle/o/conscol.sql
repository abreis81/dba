prompt Nome da tabela;
accept tabela;
prompt owner;
accept usuario;
select a.table_name, substr(a.column_name,1,25) Coluna 
from all_cons_columns a, all_constraints b
where a.table_name=UPPER('&Tabela') and b.owner=upper('&usuario')
	and a.constraint_name=b.constraint_name and b.constraint_type='P'
/
 