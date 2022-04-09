set serveroutput on size 50000
declare

cursor c1 is select constraint_name, table_name,r_constraint_name from ALL_CONSTRAINTS WHERE OWNER='SEU'
and table_name='SEUAAW' AND CONSTRAINT_TYPE='R';
																																	--AND STATUS='DISABLED';
cursor c2(tabela in varchar2, cons in varchar2) is select column_name, position from ALL_cons_columns 
																									where owner='SEU' and table_name=tabela and constraint_name=cons;
cursor c3(cons in varchar2) is select table_name,column_name, position 
															from ALL_cons_columns where owner='SEU' and constraint_name=cons;

str varchar2(1000);
ref varchar2(128);

type v_campos is table of varchar2(100) index by binary_integer;
campos v_campos;

pos number :=1;

begin
	for rc1 in c1 loop
		str := 'select distinct ';
		for rc2 in c2 (rc1.table_name, rc1.constraint_name) loop
			if rc2.position=1 then
				str := str||rc2.column_name;
			else
				str := str||','||rc2.column_name;
			end if;
			campos(pos) := rc2.column_name;
			pos := pos + 1;
		end loop;
		SELECT TABLE_NAME INTO REF FROM ALL_CONSTRAINTS WHERE OWNER='SEU' AND CONSTRAINT_NAME=RC1.R_CONSTRAINT_NAME;
		str :=str||' from SEU.'||rc1.table_name||' a where NOT EXISTS (SELECT '||''''||'X'||''''||
		' FROM seu.'||ref||' b where b.';
		pos := 1;
		for rc3 in c3 (rc1.r_constraint_name) loop
			if rc3.position=1 then
				str := str||rc3.column_name||' = a.'||campos(pos);
			else
				str := str||' and b.'||rc3.column_name||' = a.'||campos(pos);
			end if;	
			pos := pos + 1;
		end loop;
		str := str||')';
		dbms_output.put_line(str);
	end loop;
end;
