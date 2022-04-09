set echo off
set serveroutput on size 100000
set pages 1000

accept own prompt "Digite o owner: "
accept diretorio prompt "Digite o diretorio: "

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
														
																		 
coluna varchar2(100);
tamanho varchar2(100);
nulo varchar2(50);																			 
rtable varchar2(100);
tipo_cons varchar2(50);
arq utl_file.file_type;

begin
	arq := utl_file.fopen('&&diretorio','ddl_ind_&&owner..sql','w');
	for rc_tab in c_tab loop
	    utl_file.put_line(arq,'-- INICIO DA '||rc_tab.table_name||' ------------------------');
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
		utl_file.put_line(arq,'-- FIM DA '||rc_tab.table_name||'------------------------------------------');
		utl_file.put_line(arq,'--');
	end loop;  
        utl_file.fclose(arq);  
end;
/


SPOOL OFF

set ver on
set feed on
			