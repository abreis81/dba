SET SERVEROUTPUT ON SIZE 100000
SET VER OFF
SET PAGES 10000
UNDEF LISTA
COL OWNER_REF NEW_VALUE OWNER_REF

ACCEPT LISTA prompt "Digite o Owner(s) referenciado(s), separados por ',' sem espaços: "

SELECT UPPER(REPLACE('&&LISTA',',',''''||','||'''')) OWNER_REF FROM DUAL;


SPOOL DROP_FK.SQL

declare

cursor c_cons is select a.owner owner
								, a.table_name 
								, a.constraint_name constraint_name 
								, a.constraint_type constraint_type
								, b.table_name r_table
								, b.owner r_owner
								from dba_constraints a
										,dba_constraints b
							 	where a.r_owner = b.owner
							 		and a.r_constraint_name = b.constraint_name
							 		and b.owner in ('&&OWNER_REF')
									order by a.owner;

begin
	for rc_cons in c_cons loop
		dbms_output.put_line('ALTER TABLE '||rc_cons.owner||'.'||rc_cons.table_name);
		dbms_output.put_line('DROP CONSTRAINT '||rc_cons.constraint_name);
		dbms_output.put_line('/');
		dbms_output.put_line('-----------------------------------------------------');
	end loop;
end;
/

SPOOL OFF