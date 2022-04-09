set serveroutput on size 500000
declare
  
  cursor c0 is SELECT distinct b.table_name
			 					from dba_cons_columns a, dba_constraints b
								where a.owner=b.owner and b.owner='SEU' 
		  						and a.constraint_name=b.constraint_name
		  						and b.constraint_type='R' and not exists
									(select 'x' from dba_ind_columns c 
										where c.table_owner=b.owner 
											and c.table_name=b.table_name 
											and c.column_name=a.column_name
											and c.column_position=a.position);
											
	cursor c1 (tabela in varchar2) is SELECT distinct a.constraint_name constraint_name, b.table_name table_name, b.owner owner
			 					from dba_cons_columns a, dba_constraints b
								where a.owner=b.owner and b.owner='SEU' 
		  						and a.constraint_name=b.constraint_name
		  						and b.table_name = tabela
		  						and b.constraint_type='R' and not exists
									(select 'x' from dba_ind_columns c 
										where c.table_owner=b.owner 
											and c.table_name=b.table_name 
											and c.column_name=a.column_name
											and c.column_position=a.position) order by 2,1;
											
	cursor c2 (constraint in varchar2, own in varchar2,tabela in varchar2) is select column_name, position
																																from dba_cons_columns
																																where constraint_name=constraint
																																	and owner=own
																																	and table_name=tabela
																																	order by position;
																																	
	str varchar2(1000);
  ind_name varchar2(100);
	seq number := 0;
begin
 for rc0 in c0 loop
  select nvl(max(to_number(substr(index_name,instr(index_name,'_',1,2)+2,1))),0) + 1 into seq from dba_indexes where
  table_name=rc0.table_name and index_name like '%IX%';
	for rc1 in c1(rc0.table_name) loop
		ind_name := 'IX_'||rc1.table_name||'_0'||seq;
		str :='create index '||rc1.owner||'.'||ind_name||' on '||rc1.owner||'.'||rc1.table_name||'(';
		for rc2 in c2(rc1.constraint_name, rc1.owner, rc1.table_name) loop 
			if rc2.position = 1 then
				str := str||chr(10)||rc2.column_name;
			else
				str := str||chr(10)||','||rc2.column_name;
			end if;
		end loop;
		str := str||chr(10)||') tablespace seux';
		begin
			--execute immediate str;
			dbms_output.put_line(str);
		exception when others then
			dbms_output.put_line(rc1.table_name||' '||ind_name||' '||sqlerrm);
		end;
		seq := seq + 1;
	end loop;
 end loop;
end;
/