set ver off
set serveroutput on size 1000000
accept owner prompt "Digite o owner base para a comparacao: "
accept owner_destino prompt "Digite o owner a ser comparado: "
accept base_remota prompt "Digite a base a ser comparada (db_link): "

prompt "Criando tabelas temporarias..."

drop table dba_tables_temp ;
drop table dba_cons_columns_temp;
drop table dba_indexes_temp;
drop table dba_ind_columns_temp ;
drop table dba_constraints_temp ;
drop table dba_tab_columns_temp ;

create table dba_tables_temp as select * from dba_tables where rownum < 1;                                             
create table dba_cons_columns_temp as select * from dba_cons_columns where rownum < 1;
create table dba_indexes_temp as select * from dba_indexes where rownum < 1;
create table dba_ind_columns_temp as select * from dba_ind_columns where rownum < 1;
 
create table dba_constraints_temp (
 OWNER              VARCHAR2(30)
 ,CONSTRAINT_NAME    VARCHAR2(30)
 ,CONSTRAINT_TYPE    VARCHAR2(1)
 ,TABLE_NAME         VARCHAR2(30)
 ,SEARCH_CONDITION   VARCHAR2(4000)
 ,R_OWNER            VARCHAR2(30)
 ,R_CONSTRAINT_NAME  VARCHAR2(30)
 ,DELETE_RULE        VARCHAR2(9)
 ,STATUS             VARCHAR2(8)
 ,DEFERRABLE         VARCHAR2(14)
 ,DEFERRED           VARCHAR2(9)
 ,VALIDATED          VARCHAR2(13)
 ,GENERATED          VARCHAR2(14)
 ,BAD                VARCHAR2(3)
 ,RELY               VARCHAR2(4)
 ,LAST_CHANGE        DATE)
/

create table dba_tab_columns_temp (
OWNER                          VARCHAR2(30)
,TABLE_NAME                     VARCHAR2(30)
,COLUMN_NAME                    VARCHAR2(30)
,DATA_TYPE                      VARCHAR2(106)
,DATA_TYPE_MOD                  VARCHAR2(3)
,DATA_TYPE_OWNER                VARCHAR2(30)
,DATA_LENGTH                    NUMBER
,DATA_PRECISION                 NUMBER
,DATA_SCALE                     NUMBER
,NULLABLE                       VARCHAR2(1)
,COLUMN_ID                      NUMBER
,DEFAULT_LENGTH                 NUMBER
,DATA_DEFAULT                   varchar2(4000)
,NUM_DISTINCT                   NUMBER
,LOW_VALUE                      RAW(32)
,HIGH_VALUE                     RAW(32)
,DENSITY                        NUMBER
,NUM_NULLS                      NUMBER
,NUM_BUCKETS                    NUMBER
,LAST_ANALYZED                  DATE
,SAMPLE_SIZE                    NUMBER
,CHARACTER_SET_NAME             VARCHAR2(44)
,CHAR_COL_DECL_LENGTH           NUMBER
,GLOBAL_STATS                   VARCHAR2(3)
,USER_STATS                     VARCHAR2(3)
,AVG_COL_LEN                    NUMBER)
/
 

create index ix_dba_tables_temp on dba_tables_temp (owner,table_name);
create index ix_dba_tab_columns_temp on dba_tab_columns_temp (table_name, column_name);
create index ix_dba_constraints_temp on dba_constraints_temp (table_name, constraint_name);
create index ix_dba_cons_columns_temp on dba_cons_columns_temp (table_name);
create index ix_dba_ind_columns_temp on dba_ind_columns_temp (table_name);
create index ix_dba_indexes_temp on dba_indexes_temp (table_name,index_name);

insert into dba_tables_temp (select * from dba_tables@&&base_remota where owner=upper('&&OWNER_DESTINO'));

insert into dba_cons_columns_temp (select * from dba_cons_columns@&&base_remota where owner=upper('&&OWNER_DESTINO'));

insert into dba_indexes_temp (select * from dba_indexes@&&base_remota where owner=upper('&&OWNER_DESTINO'));

insert into dba_ind_columns_temp (select * from dba_ind_columns@&&base_remota where table_owner=upper('&&OWNER_DESTINO')); 


declare

cursor c1 is select * from dba_tab_columns@&&base_remota where owner=upper('&&OWNER_DESTINO');

DATA_DEFAULT varchar2(4000);

begin

	for rc1 in c1 loop
		DATA_DEFAULT := rc1.DATA_DEFAULT;
		insert into dba_tab_columns_temp values (
																							 rc1.OWNER                    
		                                          ,rc1.TABLE_NAME              
                                              ,rc1.COLUMN_NAME             
                                              ,rc1.DATA_TYPE               
                                              ,rc1.DATA_TYPE_MOD           
                                              ,rc1.DATA_TYPE_OWNER         
                                              ,rc1.DATA_LENGTH             
                                              ,rc1.DATA_PRECISION          
                                              ,rc1.DATA_SCALE              
                                              ,rc1.NULLABLE                
                                              ,rc1.COLUMN_ID               
                                              ,rc1.DEFAULT_LENGTH          
                                              ,DATA_DEFAULT            
                                              ,rc1.NUM_DISTINCT            
                                              ,rc1.LOW_VALUE               
                                              ,rc1.HIGH_VALUE              
                                              ,rc1.DENSITY                 
                                              ,rc1.NUM_NULLS               
                                              ,rc1.NUM_BUCKETS             
                                              ,rc1.LAST_ANALYZED           
                                              ,rc1.SAMPLE_SIZE             
                                              ,rc1.CHARACTER_SET_NAME      
                                              ,rc1.CHAR_COL_DECL_LENGTH    
                                              ,rc1.GLOBAL_STATS            
                                              ,rc1.USER_STATS              
                                              ,rc1.AVG_COL_LEN);
		commit;
	end loop;
end;
/

declare 

cursor c1 is select * from dba_constraints@&&base_remota where owner=upper('&&OWNER_DESTINO');

search varchar2(4000);

begin

	for rc1 in c1 loop
		search := rc1.SEARCH_CONDITION;
		insert into dba_constraints_temp values (  rc1.OWNER              
                                              ,rc1.CONSTRAINT_NAME   
                                              ,rc1.CONSTRAINT_TYPE   
                                              ,rc1.TABLE_NAME        
                                              ,SEARCH 
                                              ,rc1.R_OWNER           
                                              ,rc1.R_CONSTRAINT_NAME 
                                              ,rc1.DELETE_RULE       
                                              ,rc1.STATUS            
                                              ,rc1.DEFERRABLE        
                                              ,rc1.DEFERRED          
                                              ,rc1.VALIDATED         
                                              ,rc1.GENERATED         
                                              ,rc1.BAD               
                                              ,rc1.RELY              
                                              ,rc1.LAST_CHANGE);
		commit;
	end loop;
end;
/



declare

cursor c1 is select owner, table_name from dba_tables where owner=upper('&&OWNER');

cursor c2(tab_owner in varchar2, tab_name in varchar2) is select * from dba_tab_columns
			 where owner=tab_owner and table_name=tab_name;

cursor c3(tab_owner in varchar2, tab_name in varchar2) is select * from dba_indexes
			  where owner=tab_owner and table_name=tab_name;

cursor c4(tab_owner in varchar2, tab_name in varchar2, ind_name in varchar2) is select * from dba_ind_columns
			  where table_owner=tab_owner and table_name=tab_name and index_name=ind_name
			  order by COLUMN_POSITION;

cursor c5(tab_owner in varchar2, tab_name in varchar2) is select * from dba_constraints
				where owner=tab_owner and table_name=tab_name;
				
cursor c6(tab_owner in varchar2, tab_name in varchar2, cons_name in varchar2) is select * from dba_cons_columns
				where owner=tab_owner and table_name=tab_name and constraint_name=cons_name order by position;


qtde number := 0;
qtde2 number := 0;
qtde_dif number := 0;
qtde_campo_o number := 0;
qtde_campo_d number := 0;
cons_type varchar2(2);
cons_type_name varchar2(100);

--tipo varchar2(10);

v_DATA_TYPE      dba_tab_columns.DATA_TYPE%type      ;
v_DATA_LENGTH    dba_tab_columns.DATA_LENGTH%type    ;
v_DATA_PRECISION dba_tab_columns.DATA_PRECISION%type ;
v_DATA_SCALE     dba_tab_columns.DATA_SCALE%type     ;
v_DATA_DEFAULT   dba_tab_columns_temp.DATA_DEFAULT%type;
v_DATA_DEFAULT2   dba_tab_columns_temp.DATA_DEFAULT%type;
v_UNIQUENESS			dba_indexes.UNIQUENESS%type;
V_CONSTRAINT_NAME	dba_constraints.CONSTRAINT_NAME%type;
v_R_OWNER					dba_constraints.R_OWNER%type;
V_R_CONSTRAINT_NAME	dba_constraints.R_CONSTRAINT_NAME%type;
v_coluna					varchar2(1000);
v_coluna_d				varchar2(1000);
v_posicao					number;
v_search_condition_o varchar2(4000);
v_search_condition_d varchar2(4000);

begin
	
	for rc1 in c1 loop                 
		select count(1) into qtde from dba_tables_temp where table_name=rc1.table_name;
		-- verificacao de tabela          
		if qtde = 0 then 
			dbms_output.put_line('A tabela '||rc1.table_name||' n�o existe na &&base_remota');
		else
			for rc2 in c2(rc1.owner, rc1.table_name) loop
				select count(1) into qtde from dba_tab_columns_temp where owner = upper('&&owner_destino') and table_name=rc1.table_name 
										      																		and column_name = rc2.column_name;
				--verificacao de coluna
				if qtde = 0 then
					dbms_output.put_line('O campo '||rc2.column_name||' da tabela '||rc1.table_name||
															 ' n�o existe na base &&base_remota');
				else
					v_DATA_TYPE       := 0;
					v_DATA_LENGTH     := 0;
					v_DATA_PRECISION  := 0;
					v_DATA_SCALE      := 0;
					select DATA_TYPE, DATA_LENGTH, DATA_PRECISION, DATA_SCALE, v_DATA_DEFAULT into 
								 v_DATA_TYPE, v_DATA_LENGTH, v_DATA_PRECISION, v_DATA_SCALE, v_DATA_DEFAULT
						from dba_tab_columns_temp where owner=upper('&&owner_destino') and table_name=rc1.table_name
								 and column_name=rc2.column_name;
					--verificacao de datatype
					if rc2.data_type <> v_data_type then
						dbms_output.put_line('O campo '||rc2.column_name||' da tabela '||rc1.table_name||' possui datatype '||rc2.data_type||' na origem e '||v_data_type||' na &&base_remota');
					else
						if rc2.data_type = 'NUMBER' then
							if (RC2.DATA_PRECISION <> v_DATA_PRECISION or rc2.DATA_SCALE <> v_DATA_SCALE) then
								dbms_output.put_line ('A precis�o do campo '||rc2.column_name||' da tabela '||rc1.table_name||' � diferente');
							end if;
						elsif (rc2.data_type = 'VARCHAR2' OR rc2.data_type='VARCHAR' or rc2.data_type='CHAR' ) then
						  if (rc2.DATA_LENGTH <> v_DATA_LENGTH) then 
							  dbms_output.put_line ('O tamanho do campo '||rc2.column_name||' da tabela '||rc1.table_name||' � '||rc2.DATA_LENGTH||' na origem e '||v_DATA_LENGTH||' na &&base_remota'); 
							end if;
						end if;
						v_DATA_DEFAULT2 := rc2.DATA_DEFAULT; 
						--verificacao de valor default
						if v_DATA_DEFAULT <> v_DATA_DEFAULT2 then
							dbms_output.put_line ('O valor DEFAULT do campo '||rc2.column_name||' da tabela '||rc1.table_name||' � '||v_DATA_DEFAULT2||' na origem e '||v_DATA_DEFAULT||' na &&base_remota');
						end if;
					end if;
					-- fim de verificacao de datatype
				end if;
				 -- fim de verificacao de coluna
			end loop;
			for rc3 in c3(rc1.owner, rc1.table_name) loop
				select count(1) into qtde from dba_indexes_temp 
						 where owner=upper('&&owner_destino') 
						 and table_name=rc1.table_name 
						 and index_name=rc3.index_name;
			-- verificacao de indices
				if qtde = 0 then
				  -- verificando se o indice existe, mas com nome diferente
				  qtde := 0 ;
				  qtde2 := 0;
				  /*
				  for rc_col in (select table_owner, table_name, column_name, column_position from dba_ind_columns
				  											where table_owner = rc1.owner 
				  												and table_name  = rc1.table_name
				  												and index_name  = rc3.index_name) loop
				  	
				  	select count(1) into qtde from dba_ind_columns_temp
				  														where table_owner = rc_col.table_owner
				  															and table_name  = rc_col.table_name
				  															and column_name = rc_col.column_name
				  															and column_position = rc_col.column_position;
				  	if qtde = 0 then
				  		dbms_output.put_line ('O �ndice '||rc3.index_name||' para a tabela '
							||rc1.table_name||' n�o existe ou est� diferente na &&base_remota');
							exit;
				  	end if;
				  	qtde2 := qtde2 + 1;
					end loop;
					
					select count(1) into qtde from dba_ind_columns
				  											where table_owner = rc1.owner 
				  												and table_name  = rc1.table_name
				  												and index_name  = rc3.index_name;
				  												
					*/
					SELECT COUNT(1) into qtde FROM 
					(select table_owner, table_name, column_name, column_position,index_name, 
						(select count(1) from  dba_ind_columns where table_owner= a.table_owner
																				 and table_name = a.table_name
																				 and index_name = a.index_name) tot
				  	from dba_ind_columns a ) orig,
					(select table_owner, table_name, column_name, column_position,index_name,
						(select count(1) from  dba_ind_columns_temp where table_owner= b.table_owner
																				 and table_name = b.table_name
																				 and index_name = b.index_name) tot
						from dba_ind_columns_temp b ) dest	
					where orig.table_owner = rc1.owner
						and   orig.table_name = rc1.table_name
						and   orig.index_name = rc3.index_name
						and   dest.table_name=orig.table_name
						and   dest.column_name = orig.column_name
						and   dest.column_position = orig.column_position
						and   dest.tot = orig.tot		;
					
					if qtde > 0 then 
					
						dbms_output.put_line ('O �ndice '||rc3.index_name||' da tabela '||rc1.table_name
				  	||' est� com nome diferente na &&base_remota');	
				  	
					else 
						
						dbms_output.put_line ('O �ndice '||rc3.index_name||' para a tabela '
						||rc1.table_name||' n�o existe ou est� diferente na &&base_remota');
							
				  end if;
				  	
				else
			  	select uniqueness into v_UNIQUENESS from dba_indexes_temp 
						 where owner=upper('&&owner_destino') and table_name=rc1.table_name and index_name=rc3.index_name;
					if (rc3.UNIQUENESS <> v_UNIQUENESS) then
						dbms_output.put_line ('O �ndice '||rc3.index_name||' da tabela '
						||rc1.table_name||' n�o � '||rc3.UNIQUENESS);
					end if;
					qtde_campo_o := 0;
					qtde_campo_d := 0;
					select count(*) into qtde_campo_o from dba_ind_columns where table_owner=rc1.owner 
																							 										and table_name=rc1.table_name
																							 										and index_name=rc3.index_name;	
					select count(*) into qtde_campo_d from dba_ind_columns_temp where table_owner=upper('&&owner_destino') 
																																				and table_name=rc1.table_name
																							 													and index_name=rc3.index_name;
					if qtde_campo_o <> qtde_campo_d then
						if qtde_campo_o < qtde_campo_d then
							dbms_output.put_line ('O �ndice '||rc3.index_name||' da tabela '
							||rc1.table_name||' possui '||to_char(qtde_campo_o-qtde_campo_d)
							||' coluna(s) a menos na origem');
						else
							dbms_output.put_line ('O �ndice '||rc3.index_name||' da tabela '
							||rc1.table_name||' possui '||to_char(qtde_campo_d-qtde_campo_o)
							||' coluna(s) a mais na origem');
						end if;
					else
						qtde := 0;
						for rc4 in c4(rc1.owner, rc1.table_name, rc3.index_name) loop
						  v_posicao := 0;
						  for rc_posicao in (select column_position  from dba_ind_columns_temp
				  																where table_owner=upper('&&owner_destino')  
				  																	and table_name=rc1.table_name
				  																	and index_name = rc3.index_name
				  																	and column_name = rc4.column_name) loop
				  			v_posicao := rc_posicao.column_position;
				  		end loop;
				  		if rc4.column_position <> v_posicao then
				  			if v_posicao = 0 then
				  				dbms_output.put_line ('A coluna '||rc4.column_name||' do �ndice '
									||rc3.index_name||' n�o faz parte do ind�ce na &&base_remota');	
				  			else					
									dbms_output.put_line ('A coluna '||rc4.column_name||' do �ndice '
									||rc3.index_name||' est� na posicao '||v_posicao||' sendo que a origem �:'
									||rc4.column_position);
								end if;
				  		end if;
						end loop;	
					end if; 				
				end if;
			-- fim de verificacao de indices 
			end loop;
			--verificacao de constraints
			for rc5 in c5(rc1.owner, rc1.table_name) loop
				select count(1) into qtde from dba_constraints_temp 
																	where owner =  upper('&&owner_destino')
																		and table_name = rc1.table_name
																		and constraint_name = rc5.constraint_name;
				
				
				if qtde = 0 then
				--verificacao de constraint com nome diferente
					if rc5.constraint_type='C' then
						 select column_name into v_coluna from dba_cons_columns
																							where constraint_name = rc5.constraint_name
																							and owner = rc1.owner
																							and table_name = rc1.table_name;
						 select count(1) into qtde from dba_cons_columns_temp a
						  															,dba_constraints_temp b
						  											   where b.owner = upper('&&owner_destino') 
						  											   	 and b.table_name = rc1.table_name
						  											   	 and b.constraint_type = rc5.constraint_type
						  											   	 and a.column_name = v_coluna
						  											   	 and a.constraint_name = b.constraint_name
						  											   	 and a.owner = b.owner
						  											   	 and a.table_name = b.table_name;
						 if qtde = 0 then
						  	dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
						  	||rc1.table_name||' n�o existe');
						 else
						  	v_search_condition_o := rc5.search_condition;
						  	select search_condition, a.constraint_name into v_search_condition_d, v_constraint_name 
						  												from dba_cons_columns_temp a
						  															,dba_constraints_temp b
						  											   where b.owner = upper('&&owner_destino') 
						  											   	 and b.table_name = rc1.table_name
						  											   	 and b.constraint_type = rc5.constraint_type
						  											   	 and a.column_name = v_coluna
						  											   	 and a.constraint_name = b.constraint_name
						  											   	 and a.owner = b.owner
						  											   	 and a.table_name = b.table_name;
						 		if v_search_condition_o <> v_search_condition_d then
						 			dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
						  		||rc1.table_name||' n�o existe');
						  	else
								null;
						  		--dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
						  		--||rc1.table_name||' possui o nome de '||v_constraint_name||' na base &&base_remota'); 
						  	end if;
						 end if;
					elsif rc5.constraint_type='R' then
					  qtde := 0;
						for rc_cons_rem in (select constraint_name from dba_constraints_temp where owner = upper('&&owner_destino') 
																														 and table_name = rc1.table_name
																														 and constraint_type = rc5.constraint_type
																														 and r_owner = rc5.r_owner
																														 and r_constraint_name = rc5.r_constraint_name) loop
								qtde := qtde + 1;
								dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
					  		||rc1.table_name||' possui o nome de '||rc_cons_rem.constraint_name||' na base &&base_remota');	
							end loop;
						if qtde = 0 then
							dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
						  	||rc1.table_name||' n�o existe na &&base_remota');
						end if;
				  elsif rc5.constraint_type='U' or rc5.constraint_type='P' then
				  	
				  	qtde_dif := 1;
				  	for rc_cons_rem in (select constraint_name from dba_constraints_temp
				  																						where owner = upper('&&owner_destino') 
				  																							and table_name = rc1.table_name
				  																							and constraint_type = rc5.constraint_type) loop
				  		select count(1) into qtde from dba_cons_columns a where owner=upper('&&owner')
				  																						 	and constraint_name=rc5.constraint_name
				  																						 	and not exists (select 'x' from dba_cons_columns_temp b
				  																						 	where b.owner=upper('&&owner_destino')
				  																						 	  and b.constraint_name=rc_cons_rem.constraint_name
				  																						 	  and b.column_name = a.column_name
				  																						 	  and b.position = a.position);
				  																						 	  
				  		select count(1) into qtde2 from dba_cons_columns_temp a where owner=upper('&&owner_destino')
				  																						 	and constraint_name=rc_cons_rem.constraint_name
				  																						 	and not exists (select 'x' from dba_cons_columns_temp b
				  																						 	where b.owner=upper('&&owner')
				  																						 	  and b.constraint_name=rc5.constraint_name
				  																						 	  and b.column_name = a.column_name
				  																						 	  and b.position = a.position);		
				  		dbms_output.put_line('cons '||qtde);																 	  
				  		if qtde = 0 and qtde2 = 0 then
				  			dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
					  		||rc1.table_name||' possui o nome de '||rc_cons_rem.constraint_name||' na base &&base_remota');	
					  		qtde_dif := 0;
				  		  exit;
							end if;
				  		
				  	end loop;
				  	
				  	if qtde_dif > 0 then	
				  		dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
							||rc1.table_name||' n�o existe na &&base_remota');        
				  	end if;
				  																																  
					else 
						null;
					end if;
					--fim da verificacao de constraint com nome diferente
					--end loop;
			  else
			  	if rc5.constraint_type='C' then
			  	  select column_name into v_coluna from dba_cons_columns
																							where constraint_name = rc5.constraint_name
																							and owner = rc1.owner
																							and table_name = rc1.table_name;
			  		v_search_condition_o := rc5.search_condition;
						select search_condition, column_name into v_search_condition_d, v_coluna_d
						  												from dba_constraints_temp a,
						  												     dba_cons_columns_temp b
						  											   where a.owner = upper('&&owner_destino') 
						  											   	 and a.table_name = rc1.table_name
						  											   	 and a.constraint_name = rc5.constraint_name
						  											   	 and a.constraint_type = rc5.constraint_type
						  											   	 and b.owner = a.owner
						  											   	 and b.table_name = a.table_name
						  											   	 and b.constraint_name = a.constraint_name;
						  											   	 
						if v_search_condition_o <> v_search_condition_d then
						 		dbms_output.put_line('A check constraint '||rc5.constraint_name||' da tabela '
						  	||rc1.table_name||' possui condicao diferente na &&base_remota');
						end if;
						if v_coluna <> v_coluna_d then
						  	dbms_output.put_line('O campo da check constraint '||rc5.constraint_name||' da tabela '
						  	||rc1.table_name||' esta diferente na &&base_remota'); 
						end if;
					end if;
					
					if rc5.constraint_type='R' then
						select count(1) into qtde from dba_constraints_temp
																		 where owner = upper('&&owner_destino') 
																			 and table_name = rc1.table_name
																			 and constraint_name = rc5.constraint_name
																			 and constraint_type = rc5.constraint_type
																			 and r_owner = rc5.r_owner
																			 and r_constraint_name = rc5.r_constraint_name;
						if qtde = 0 then
							select r_owner, r_constraint_name into v_r_owner, v_r_constraint_name
								from dba_constraints_temp where owner = upper('&&owner_destino') 
																			 			and table_name = rc1.table_name
																			 			and constraint_name = rc5.constraint_name
																			 			and constraint_type = rc5.constraint_type;
							dbms_output.put_line('A constraint '||rc5.constraint_name||' da tabela '
					  		||rc1.table_name||' referencia a constraint '||v_r_constraint_name||' da &&base_remota');
						end if; 
					end if;
					
					if rc5.constraint_type='U' or rc5.constraint_type='P' then
						select constraint_type 
					        ,decode(constraint_type,'R','FOREIGN','U','UNIQUE','P','PRIMARY','CHECK') 
					        into cons_type, cons_type_name
					    from dba_constraints_temp where owner=upper('&&owner_destino')
																			    and constraint_name = rc5.constraint_name;
																															 
						if rc5.constraint_type <> cons_type then
							dbms_output.put_line ('A constraint '||rc5.constraint_name||' e '||cons_type_name||' na &&base_remota');
						else																								
							qtde_campo_o := 0;
							qtde_campo_d := 0;
							select count(*) into qtde_campo_o from dba_cons_columns where owner=rc1.owner 
																								 										and table_name=rc1.table_name
																								 										and constraint_name=rc5.constraint_name;	
							select count(*) into qtde_campo_d from dba_cons_columns_temp where owner=upper('&&owner_destino')  
																																					and table_name=rc1.table_name
																								 													and constraint_name=rc5.constraint_name;
							if qtde_campo_o <> qtde_campo_d then
								if qtde_campo_o < qtde_campo_d then
									dbms_output.put_line ('A constraint '||rc5.constraint_name||' da tabela '
									||rc1.table_name||' possui '||to_char(qtde_campo_o-qtde_campo_d)
									||' coluna(s) a menos na origem');
								else
									dbms_output.put_line ('A constraint '||rc5.constraint_name||' da tabela '
									||rc1.table_name||' possui '||to_char(qtde_campo_d-qtde_campo_o)
									||' coluna(s) a mais na origem');
								end if;
							else
								qtde := 0;
								for rc6 in c6(rc1.owner, rc1.table_name, rc5.constraint_name) loop
									v_posicao := 0;
							  	for rc_posicao in (select position  from dba_cons_columns_temp
				  																	where owner=upper('&&owner_destino')  
				  																		and table_name=rc1.table_name
				  																		and constraint_name = rc5.constraint_name
				  																		and column_name = rc6.column_name) loop
				  					v_posicao := rc_posicao.position;
				  				end loop;
				  				if rc6.position <> v_posicao then
				  					if v_posicao = 0 then
				  						dbms_output.put_line ('A coluna '||rc6.column_name||' da constraint '
											||rc5.constraint_name||' n�o faz parte da constraint na &&base_remota');
				  					else				
											dbms_output.put_line ('A coluna '||rc6.column_name||' da constraint '
											||rc5.constraint_name||' est� na posicao '||v_posicao||' sendo que a origem �:'
											||rc6.position);
										end if;
				  				end if;
								end loop;	
							end if;
						end if;				
					end if;
				end if; 
				--fim da verificacao de constraints
			end loop;
		end if;
		-- fim de verificacao de tabela
	end loop;
end;
/


drop table dba_tables_temp ;
drop table dba_cons_columns_temp;
drop table dba_indexes_temp;
drop table dba_ind_columns_temp ;
drop table dba_constraints_temp ;
drop table dba_tab_columns_temp ;