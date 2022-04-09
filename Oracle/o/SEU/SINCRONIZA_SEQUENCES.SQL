declare
  
  cursor c1 is select owner, table_name 
  						 from DBA_tables
  						 where owner='SEU'
               and table_name in ('SEUACG');
               
	v_str varchar2(1000);
	v_qtde number :=0;
	v_seq varchar2(100);
	v_cache number :=0;
	v_curr number :=0;
	v_dif number :=0;
	v_aux number :=0;
	
begin
	
	for rc1 in c1 loop
		begin
	  	v_str := 'select max(S'||SUBSTR(rc1.table_name,4,3)||'_NREG) -1 from '||rc1.owner||'.'||rc1.table_name;
	  	execute immediate v_str into v_qtde;
			v_str := 'select sequence_name, cache_size from DBA_sequences where sequence_owner='||''''
						 ||rc1.owner||''''||' and sequence_name like '||''''||'%'||rc1.table_name||'%INSERT'||'''';
			execute immediate v_str into v_seq, v_cache;
			DBMS_OUTPUT.PUT_LINE(v_seq);
			if v_cache <> 0 then 
				v_str := 'alter sequence '||rc1.owner||'.'||v_seq||' nocache minvalue 0';
		  	execute immediate v_str;
			end if;
		
			v_str := 'select last_number -1 from DBA_sequences where sequence_owner='||''''||rc1.owner||''''
							 ||' and sequence_name='||''''||v_seq||'''';
			execute immediate v_str into v_curr;
			for i in v_curr.. v_qtde loop
				v_str := 'select '||rc1.owner||'.'||v_seq||'.nextval from dual';
				execute immediate v_str into v_aux;
			end loop;
			if v_cache <> 0 then 
				v_str := 'alter sequence '||rc1.owner||'.'||v_seq||' cache '||v_cache;
		  	execute immediate v_str;
			end if;
		exception when others then
			dbms_output.put_line(SQLERRM);
		end;
	end loop;
end;
