set echo off
set serveroutput on size 100000
set pages 1000

set ver off
set feed off 


declare

cursor c_seg is select owner, segment_name, segment_type from dba_segments where tablespace_name=upper('&&tablespace');

cursor c_tab(own varchar2, seg varchar2) is select owner, table_name, initial_extent, next_extent, max_extents, pct_increase, tablespace_name
				   from dba_tables where owner = own
				   					  and upper(table_name) = seg;
				   				
cursor c_col(own varchar2, tab varchar2) is select column_id,column_name, data_type, data_length, data_precision, data_scale, nullable 
											 	from dba_tab_columns where owner = own
																	   and table_name = tab
																	 order by column_id asc;
																			 
cursor c_ind(own varchar2, tab varchar2) is select owner, index_name, uniqueness, initial_extent, next_extent, max_extents, pct_increase, tablespace_name
												from dba_indexes where owner = own
																   and table_name = tab;

cursor c_ind2(own varchar2, seg varchar2) is select owner, index_name, uniqueness, initial_extent, next_extent, max_extents, pct_increase, tablespace_name, table_name
												from dba_indexes where owner = own
																   and index_name = seg;
																   
cursor c_ind_col(own varchar2, ind varchar2) is select column_name, column_position 
													from dba_ind_columns where table_owner = own
													                       and index_name = ind
																		 order by column_position asc;	

cursor c_cons(own varchar2, tab varchar2) is select constraint_name, constraint_type, r_owner, r_constraint_name , search_condition 
												from dba_constraints where owner = own
																	   and table_name = tab;
cursor c_cons2(own varchar2, ind varchar2) is select constraint_name, constraint_type, r_owner, r_constraint_name , search_condition, table_name
												from dba_constraints where owner = own
																	   and constraint_name = ind;
																			  
																			  
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

begin

for rc_seg in c_seg loop
  if rc_seg.segment_type='TABLE' then 
	for rc_tab in c_tab(rc_seg.owner, rc_seg.segment_name) loop
	    dbms_output.put_line('-- INICIO DA '||rc_tab.table_name||' ------------------------');
	    dbms_output.put_line('--');
		dbms_output.put_line('CREATE TABLE '||rc_tab.owner||'."'||rc_tab.table_name||'" (');
		for rc_col in c_col(rc_tab.owner, rc_tab.table_name) loop
			select decode(rc_col.column_id,1,' ',',')||rc_col.column_name into coluna from dual;
			select decode(rc_col.data_type,'NUMBER',rc_col.data_precision,rc_col.data_length)||decode(rc_col.data_scale, NULL, '',0,'',',')||decode(rc_col.data_scale,NULL,'',0,'',rc_col.data_scale) into tamanho from dual;
			select decode(rc_col.nullable,'Y',' ','NOT NULL') into nulo from dual;			
			if (rc_col.data_type = 'FLOAT' or rc_col.data_type='DATE' or tamanho is null) then
			    dbms_output.put_line(rpad(coluna,30,' ')||rc_col.data_type||' '||nulo);
			else
			    dbms_output.put_line(rpad(coluna,30,' ')||rc_col.data_type||'('||tamanho||') '||nulo);
			end if;			
		end loop;
		dbms_output.put_line(') TABLESPACE '||rc_tab.tablespace_name);
		dbms_output.put_line('STORAGE (');
		dbms_output.put_line('INITIAL     '||rc_tab.initial_extent);
		dbms_output.put_line('NEXT        '||rc_tab.next_extent);
		dbms_output.put_line('MAXEXTENTS  '||rc_tab.max_extents);
		dbms_output.put_line('PCTINCREASE '||rc_tab.pct_increase||' )');
		dbms_output.put_line('/');
		dbms_output.put_line('--');
		dbms_output.put_line('-- INDICES ---------------------------------------------------------------------');
		dbms_output.put_line('--');
		for rc_ind in c_ind(rc_tab.owner, rc_tab.table_name) loop
			dbms_output.put_line('CREATE INDEX '||rc_tab.owner||'.'||rc_ind.index_name||' on '||rc_tab.owner||'."'||rc_tab.table_name||'" (');
			for rc_ind_col in c_ind_col(rc_tab.owner, rc_ind.index_name) loop
				select decode(rc_ind_col.column_position,1,' ',',')||rc_ind_col.column_name into coluna from dual;
				dbms_output.put_line(coluna);
			end loop;
			dbms_output.put_line(') TABLESPACE '||rc_ind.tablespace_name);
			dbms_output.put_line('STORAGE (');
			dbms_output.put_line('INITIAL     '||rc_ind.initial_extent);
			dbms_output.put_line('NEXT        '||rc_ind.next_extent);
			dbms_output.put_line('MAXEXTENTS  '||rc_ind.max_extents);
			dbms_output.put_line('PCTINCREASE '||rc_ind.pct_increase||' )');
			dbms_output.put_line('/');
			dbms_output.put_line('--');
		end loop;
		dbms_output.put_line('--');
		dbms_output.put_line('-- CONSTRAINTS -----------------------------------------------------------------');
		dbms_output.put_line('--');
		for rc_cons in c_cons(rc_tab.owner, rc_tab.table_name) loop
		    select decode(rc_cons.constraint_type,'P','PRIMARY KEY','R','FOREIGN KEY','CHECK') into tipo_cons from dual;
			dbms_output.put_line('ALTER TABLE '||rc_tab.owner||'."'||rc_tab.table_name||'" ADD CONSTRAINT '||rc_cons.constraint_name);
			dbms_output.put_line(tipo_cons||' (');
			if (rc_cons.constraint_type = 'C') then
				dbms_output.put_line(rc_cons.search_condition);
			else 
				for rc_cons_col in c_cons_col(rc_tab.owner, rc_cons.constraint_name) loop
					select decode(rc_cons_col.position,1,' ',',')||rc_cons_col.column_name into coluna from dual;
					dbms_output.put_line(coluna);
				end loop;
			end if;
			dbms_output.put_line(')');
			if (rc_cons.constraint_type = 'R') then
			    select table_name into rtable  from dba_constraints where owner = rc_cons.r_owner and constraint_name = rc_cons.r_constraint_name;
				dbms_output.put_line('REFERENCES '||rc_cons.r_owner||'.'||rtable);
			end if;
			dbms_output.put_line('/');
			dbms_output.put_line('--');
		end loop;
		dbms_output.put_line('--');
		dbms_output.put_line('-- GRANTS ----------------------------------------------------------------------');
		dbms_output.put_line('--');
		for rc_grant in c_grant(rc_tab.owner, rc_tab.table_name) loop
			dbms_output.put_line('GRANT '||rc_grant.privilege||' ON "'||rc_grant.table_name||'" TO '||rc_grant.grantee||';');
		end loop;
		dbms_output.put_line('--');
		dbms_output.put_line('-- SINONIMOS -------------------------------------------------------------------');
		dbms_output.put_line('--');
		for rc_syn in c_syn(rc_tab.owner, rc_tab.table_name) loop
		    if (rc_syn.owner = 'PUBLIC') then 
				dbms_output.put_line('CREATE PUBLIC SYNONYM "'||rc_syn.synonym_name||'" FOR '||rc_syn.table_owner||'."'||rc_syn.table_name||'"');
			else
				dbms_output.put_line('CREATE SYNONYM '||rc_syn.owner||'."'||rc_syn.synonym_name||'" FOR '||rc_syn.table_owner||'."'||rc_syn.table_name||'"');
			end if;
			dbms_output.put_line('/');
		end loop;
		dbms_output.put_line('--');
		dbms_output.put_line('-- FIM DA '||rc_tab.table_name||'------------------------------------------');
		dbms_output.put_line('--');
	end loop; 
	end if;
	if rc_seg.segment_type='INDEX' then    
	for rc_ind in c_ind2(rc_seg.owner, rc_seg.segment_name) loop
			dbms_output.put_line('CREATE INDEX '||rc_seg.owner||'.'||rc_ind.index_name||' on '||rc_seg.owner||'."'||rc_ind.table_name||'" (');
			for rc_ind_col in c_ind_col(rc_seg.owner, rc_ind.index_name) loop
				select decode(rc_ind_col.column_position,1,' ',',')||rc_ind_col.column_name into coluna from dual;
				dbms_output.put_line(coluna);
			end loop;
			dbms_output.put_line(') TABLESPACE '||rc_ind.tablespace_name);
			dbms_output.put_line('STORAGE (');
			dbms_output.put_line('INITIAL     '||rc_ind.initial_extent);
			dbms_output.put_line('NEXT        '||rc_ind.next_extent);
			dbms_output.put_line('MAXEXTENTS  '||rc_ind.max_extents);
			dbms_output.put_line('PCTINCREASE '||rc_ind.pct_increase||' )');
			dbms_output.put_line('/');
			dbms_output.put_line('--');
	for rc_cons in c_cons2(rc_seg.owner, rc_ind.index_name) loop
		    select decode(rc_cons.constraint_type,'P','PRIMARY KEY','R','FOREIGN KEY','CHECK') into tipo_cons from dual;
			dbms_output.put_line('ALTER TABLE '||rc_seg.owner||'."'||rc_cons.table_name||'" ADD CONSTRAINT '||rc_cons.constraint_name);
			dbms_output.put_line(tipo_cons||' (');
			for rc_cons_col in c_cons_col(rc_seg.owner, rc_cons.constraint_name) loop
					select decode(rc_cons_col.position,1,' ',',')||rc_cons_col.column_name into coluna from dual;
					dbms_output.put_line(coluna);
		  end loop;
			dbms_output.put_line(')');
			dbms_output.put_line('/');
			dbms_output.put_line('--');
	end loop;
	end loop;
	end if;
end loop;
end;
/

set ver on
set feed on
			