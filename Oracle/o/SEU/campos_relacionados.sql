COL COLUMN_NAME FORMAT A30
COL TABLE_NAME FORMAT A30
COL DATA_TYPE FORMAT A10
CREATE OR REPLACE VIEW SEU.VW_RELACIONAMENTOS 
AS
select a.table_name TABELA_FILHO, a.column_name COLUNA_FILHO, b.data_type DATA_TYPE_FILHO, b.DATA_LENGTH DATA_LENGTH_FILHO ,b.DATA_PRECISION DATA_PRECISION_FILHO, b.DATA_SCALE DATA_SCALE_FILHO
,d.table_name TABELA_PAI, d.column_name COLUNA_PAI, e.data_type DATA_TYPE_PAI, e.DATA_LENGTH DATA_LENGTH_PAI, e.DATA_PRECISION DATA_PRECISION_PAI, e.DATA_SCALE DATA_SCALE_PAI
from user_cons_columns a,
		 user_tab_columns b,
		 user_constraints c,
		 user_cons_columns d,
		 user_tab_columns e,
		 user_constraints f
where b.table_name = a.table_name
and	 b.column_name = a.column_name
and  a.constraint_name = c.constraint_name
and  e.table_name = d.table_name
and	 e.column_name = d.column_name
and  d.constraint_name = f.constraint_name
and  c.r_constraint_name = f.constraint_name
and  c.constraint_type = 'R'	
and  a.position = d.position 
order by c.constraint_name,c.table_name;
  