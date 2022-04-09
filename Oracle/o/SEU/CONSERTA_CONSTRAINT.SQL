declare

cursor c1 is select index_name, table_name from dba_indexes a where owner='SEU' and index_name like 'UN%'
						 and not exists (select 'x' from dba_constraints b where owner='SEU' and constraint_type='U'
						                 and b.constraint_name=a.index_name);
						                 
cursor c2( indice in varchar2) is select column_name, column_position from dba_ind_columns 
														where index_name=indice order by column_position;

str varchar2(4000);

begin
	
	for rc1 in c1 loop
		str := 'alter table seu.'||rc1.table_name||' add constraint '||rc1.index_name||' unique ('||chr(10);
		for rc2 in c2(rc1.index_name) loop
			if rc2.column_position > 1 then
				str := str||',';
			end if;
			str := str||rc2.column_name||chr(10);
		end loop;
		str := str||')';
		execute immediate str;
		dbms_output.put_line(str);
	end loop;
end;