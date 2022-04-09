create or replace procedure sinc_t10_t11 (usuario in varchar2, tabela in varchar2)
is
cursos c_campo is select a.column_name from all_cons_columns a, all_constraints b
where a.table_name=tabela and b.owner=usuario
	and a.constraint_name=b.constraint_name and b.constraint_type='P';
tab_dest varchar2(100);
usuario_dest varchar2(20);
begin
	dbms_reputil.replication_off;
	tab_dest:=tabela;
	usuario_dest:=usuario;
end;

	

