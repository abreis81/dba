create or replace procedure aplic.p_altera_obj(owner in varchar2, tabela in varchar2)
is

aux number := 0;
def varchar2(100);
own varchar2(50) := upper(owner);
tab varchar2(128) := upper(tabela);

begin
	
	select count(1) into aux from dba_tables where table_name=tab and owner=own;
	if aux <> 0 then
			
		for rc1 in (select * from dba_tab_columns@db1 a where table_name=tab and owner=own
							  and not exists (select 'x' from dba_tab_columns b where b.owner=a.owner and b.table_name=a.table_name
							  																												and b.column_name=a.column_name) order by column_id) loop
			if rc1.data_type = 'NUMBER' THEN
				if rc1.DATA_PRECISION is null and rc1.DATA_SCALE is null then
					def := 'NUMBER';
				elsif rc1.DATA_PRECISION is null and rc1.DATA_SCALE=0 then
					def := 'INTEGER';
				elsif rc1.DATA_PRECISION is not null and rc1.DATA_SCALE=0 then
				 	def := 'NUMBER('||rc1.DATA_PRECISION||')';
				else
					def := 'NUMBER('||rc1.DATA_PRECISION||','||rc1.DATA_SCALE||')';
				end if;
			elsif rc1.data_type = 'DATE' THEN
				def := rc1.DATA_TYPE;
			else
				def := rc1.DATA_TYPE||'('||rc1.DATA_LENGTH||')';
			end if;
			execute immediate 'alter table '||own||'.'||rc1.table_name||' add '||rc1.column_name||' '||def;
		end loop;
		
		for rc1 in (select * from dba_tab_columns@db1 a where table_name=tab and owner=own
							  and not exists (select 'x' from dba_tab_columns b where b.owner=a.owner and b.table_name=a.table_name
							  																												and b.column_name=a.column_name
							  																												and b.data_length=a.data_length 
							  																											  and nvl(b.data_precision,0)=nvl(a.data_precision,0) 
							  																											  and nvl(b.data_scale,0)=nvl(a.data_scale,0))) loop
			if rc1.data_type = 'NUMBER' THEN
				if rc1.DATA_PRECISION is null and rc1.DATA_SCALE is null then
					def := 'NUMBER';
				elsif rc1.DATA_PRECISION is null and rc1.DATA_SCALE=0 then
					def := 'INTEGER';
				elsif rc1.DATA_PRECISION is not null and rc1.DATA_SCALE=0 then
				 	def := 'NUMBER('||rc1.DATA_PRECISION||')';
				else
					def := 'NUMBER('||rc1.DATA_PRECISION||','||rc1.DATA_SCALE||')';
				end if;
			elsif rc1.data_type = 'DATE' THEN
				def := rc1.DATA_TYPE;
			else
				def := rc1.DATA_TYPE||'('||rc1.DATA_LENGTH||')';
			end if;
			execute immediate 'alter table '||own||'.'||rc1.table_name||' modify '||rc1.column_name||' '||def;
		end loop;
		
		for rc1 in (select column_name, table_name from dba_tab_columns a where table_name=tab and owner=own
							  and not exists (select 'x' from dba_tab_columns@db1 b where b.owner=a.owner and b.table_name=a.table_name
							  																												and b.column_name=a.column_name)) loop
							  																												
			execute immediate 'alter table '||own||'.'||rc1.table_name||' drop column '||rc1.column_name;
		end loop;
		
		seu.p_altera_log(tab);
	else
		p_cria_obj(own,tab);
	end if;

end;
/
		