SET SERVEROUTPUT ON SIZE 100000
SET VER OFF
SET ECHO OFF
SET PAGES 10000
UNDEF LISTA
COL OWNER_REF NEW_VALUE OWNER_REF

ACCEPT LISTA prompt "Digite o Owner(s) referenciado(s), separados por ',' sem espaços: "

SELECT UPPER(REPLACE('&&LISTA',',',''''||','||'''')) OWNER_REF FROM DUAL;

SPOOL CRIA_FK_REF.SQL

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
							 		
cursor c_cons_col(own varchar2, cons varchar2) is select column_name, position 
													  from dba_cons_columns where owner = own
													  						 and constraint_name = cons
													  						order by position asc;
													  						
tipo_cons varchar2(100);
coluna varchar2(1000);	
rtable varchar2(1000);									  						
begin
																													
   for rc_cons in c_cons loop
			dbms_output.put_line('ALTER TABLE '||rc_cons.owner||'."'||rc_cons.table_name||'" ADD CONSTRAINT '||rc_cons.constraint_name);
			select decode(rc_cons.constraint_type,'P','PRIMARY KEY','R','FOREIGN KEY','CHECK') into tipo_cons from dual;
			dbms_output.put_line(tipo_cons||' (');
		  for rc_cons_col in c_cons_col(rc_cons.owner, rc_cons.constraint_name) loop
			   select decode(rc_cons_col.position,1,' ',',')||rc_cons_col.column_name into coluna from dual;
				 dbms_output.put_line(coluna);
			end loop;
			dbms_output.put_line(')');
			--select table_name into rtable  from dba_constraints where owner = rc_cons.r_owner and constraint_name = rc_cons.r_constraint_name;
		  dbms_output.put_line('REFERENCES '||rc_cons.r_owner||'.'||rc_cons.r_table);
			dbms_output.put_line('/');
			dbms_output.put_line('--');
   end loop;
   
end loop;
/

SPOOL OFF
