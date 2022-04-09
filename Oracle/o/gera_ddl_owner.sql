set echo off
set serveroutput on size 100000
set pages 1000

accept own prompt "Digite o owner: "


set ver off
set feed off 

spool DDL_OWNER.SQL

declare

cursor c_tab is select owner, table_name, initial_extent, next_extent, max_extents, pct_increase, tablespace_name
				   from dba_tables where owner = upper('&&own')
				   			and PARTITIONED='NO';
				   				
cursor c_col(own varchar2, tab varchar2) is select column_id,column_name, data_type, data_length, data_precision, data_scale, nullable 
											 	from dba_tab_columns where owner = own
																	   and table_name = tab
																	 order by column_id asc;
																			 
cursor c_ind(own varchar2, tab varchar2) is select owner, index_name, uniqueness, initial_extent, next_extent, max_extents, pct_increase, tablespace_name
												from dba_indexes where owner = own
																   and table_name = tab;
																		   
cursor c_ind_col(own varchar2, ind varchar2) is select column_name, column_position 
													from dba_ind_columns where table_owner = own
													                       and index_name = ind
																		 order by column_position asc;	

cursor c_cons(own varchar2, tab varchar2) is select constraint_name, constraint_type, r_owner, r_constraint_name , search_condition 
												from dba_constraints where owner = own
																	   and table_name = tab;
																			  
cursor c_cons_col(own varchar2, cons varchar2) is select column_name, position 
													  from dba_cons_columns where owner = own
													  						 and constraint_name = cons
													  						order by position asc;
													  						
cursor c_grant(own varchar2, tab varchar2) is select grantee, table_name, privilege	
												  from dba_tab_privs where owner = own
												  					   and table_name = tab;
												  					   
cursor c_syn(own varchar2, tab varchar2) is select owner, synonym_name, table_name, table_owner
												from dba_synonyms where table_owner = own
																	and table_name = tab;
														
																		 
coluna varchar2(100);
tamanho varchar2(100);
nulo varchar2(50);																			 
rtable varchar2(100);
tipo_cons varchar2(50);
arq utl_file.file_type;

begin
	arq := utl_file.fopen('&&diretorio','ddl_&&owner..sql','w');
	for rc_tab in c_tab loop
	    utl_file.put_line(arq,'-- INICIO DA '||rc_tab.table_name||' ------------------------');
	    utl_file.put_line(arq,'--');
		utl_file.put_line(arq,'CREATE TABLE '||rc_tab.owner||'."'||rc_tab.table_name||'" (');
		for rc_col in c_col(rc_tab.owner, rc_tab.table_name) loop
			select decode(rc_col.column_id,1,' ',',')||rc_col.column_name into coluna from dual;
			select decode(rc_col.data_type,'NUMBER',rc_col.data_precision,rc_col.data_length)||decode(rc_col.data_scale, NULL, '',0,'',',')||decode(rc_col.data_scale,NULL,'',0,'',rc_col.data_scale) into tamanho from dual;
			select decode(rc_col.nullable,'Y',' ','NOT NULL') into nulo from dual;			
			if (rc_col.data_type = 'FLOAT' or rc_col.data_type='DATE' or tamanho is null) then
			    utl_file.put_line(arq,rpad(coluna,30,' ')||rc_col.data_type||' '||nulo);
			else
			    utl_file.put_line(arq,rpad(coluna,30,' ')||rc_col.data_type||'('||tamanho||') '||nulo);
			end if;			
		end loop;
		utl_file.put_line(arq,') TABLESPACE '||rc_tab.tablespace_name);
		utl_file.put_line(arq,'STORAGE (');
		utl_file.put_line(arq,'INITIAL     '||rc_tab.initial_extent);
		utl_file.put_line(arq,'NEXT        '||rc_tab.next_extent);
		utl_file.put_line(arq,'MAXEXTENTS  '||rc_tab.max_extents);
		utl_file.put_line(arq,'PCTINCREASE '||rc_tab.pct_increase||' )');
		utl_file.put_line(arq,'/');
		utl_file.put_line(arq,'--');
		utl_file.put_line(arq,'-- INDICES ---------------------------------------------------------------------');
		utl_file.put_line(arq,'--');
		for rc_ind in c_ind(rc_tab.owner, rc_tab.table_name) loop
			utl_file.put_line(arq,'CREATE INDEX '||rc_tab.owner||'.'||rc_ind.index_name||' on '||rc_tab.owner||'."'||rc_tab.table_name||'" (');
			for rc_ind_col in c_ind_col(rc_tab.owner, rc_ind.index_name) loop
				select decode(rc_ind_col.column_position,1,' ',',')||rc_ind_col.column_name into coluna from dual;
				utl_file.put_line(arq,coluna);
			end loop;
			utl_file.put_line(arq,') TABLESPACE '||rc_ind.tablespace_name);
			utl_file.put_line(arq,'STORAGE (');
			utl_file.put_line(arq,'INITIAL     '||rc_ind.initial_extent);
			utl_file.put_line(arq,'NEXT        '||rc_ind.next_extent);
			utl_file.put_line(arq,'MAXEXTENTS  '||rc_ind.max_extents);
			utl_file.put_line(arq,'PCTINCREASE '||rc_ind.pct_increase||' )');
			utl_file.put_line(arq,'/');
			utl_file.put_line(arq,'--');
		end loop;
		utl_file.put_line(arq,'--');
		utl_file.put_line(arq,'-- CONSTRAINTS -----------------------------------------------------------------');
		utl_file.put_line(arq,'--');
		for rc_cons in c_cons(rc_tab.owner, rc_tab.table_name) loop
		    select decode(rc_cons.constraint_type,'P','PRIMARY KEY','R','FOREIGN KEY','CHECK') into tipo_cons from dual;
			utl_file.put_line(arq,'ALTER TABLE '||rc_tab.owner||'."'||rc_tab.table_name||'" ADD CONSTRAINT '||rc_cons.constraint_name);
			utl_file.put_line(arq,tipo_cons||' (');
			if (rc_cons.constraint_type = 'C') then
				utl_file.put_line(arq,rc_cons.search_condition);
			else 
				for rc_cons_col in c_cons_col(rc_tab.owner, rc_cons.constraint_name) loop
					select decode(rc_cons_col.position,1,' ',',')||rc_cons_col.column_name into coluna from dual;
					utl_file.put_line(arq,coluna);
				end loop;
			end if;
			utl_file.put_line(arq,')');
			if (rc_cons.constraint_type = 'R') then
			    select table_name into rtable  from dba_constraints where owner = rc_cons.r_owner and constraint_name = rc_cons.r_constraint_name;
				utl_file.put_line(arq,'REFERENCES '||rc_cons.r_owner||'.'||rtable);
			end if;
			utl_file.put_line(arq,'/');
			utl_file.put_line(arq,'--');
		end loop;
		utl_file.put_line(arq,'--');
		utl_file.put_line(arq,'-- GRANTS ----------------------------------------------------------------------');
		utl_file.put_line(arq,'--');
		for rc_grant in c_grant(rc_tab.owner, rc_tab.table_name) loop
			utl_file.put_line(arq,'GRANT '||rc_grant.privilege||' ON "'||rc_grant.table_name||'" TO '||rc_grant.grantee||';');
		end loop;
		utl_file.put_line(arq,'--');
		utl_file.put_line(arq,'-- SINONIMOS -------------------------------------------------------------------');
		utl_file.put_line(arq,'--');
		for rc_syn in c_syn(rc_tab.owner, rc_tab.table_name) loop
		    if (rc_syn.owner = 'PUBLIC') then 
				utl_file.put_line(arq,'CREATE PUBLIC SYNONYM "'||rc_syn.synonym_name||'" FOR '||rc_syn.table_owner||'."'||rc_syn.table_name||'"');
			else                      
				utl_file.put_line(arq,'CREATE SYNONYM '||rc_syn.owner||'."'||rc_syn.synonym_name||'" FOR '||rc_syn.table_owner||'."'||rc_syn.table_name||'"');
			end if;
			utl_file.put_line(arq,'/');
		end loop;
		utl_file.put_line(arq,'--');
		utl_file.put_line(arq,'-- FIM DA '||rc_tab.table_name||'------------------------------------------');
		utl_file.put_line(arq,'--');
	end loop;  
        utl_file.fclose(arq);  
end;
/


SPOOL OFF

set ver on
set feed on
			