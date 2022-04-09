set serveroutput on size 50000

declare
	cursor c1 is select sequence_name, last_number from user_sequences where sequence_name in (
																																						'SCR_TIT'            
                                                                            ,'SCR_RATEIO_TIT'     
                                                                            ,'SCR_ITEM_SERVICO_NF'
                                                                            ,'SCR_PARCELA');
  str varchar2(100);
  ln number := 0 ;
  ret number := 0;
  
begin
	for rc1 in c1 loop
		begin
		  dbms_output.put_line('O next da sequence '||rc1.sequence_name||' e: '||rc1.last_number);
		  ln := rc1.last_number - 2;
			str := 'alter sequence '||rc1.sequence_name||' increment by -'||ln;
			execute immediate str;
			str := 'select '||rc1.sequence_name||'.nextval from dual';
			execute immediate str into ret;
			str := 'alter sequence '||rc1.sequence_name||' increment by 1';
			execute immediate str;
			str := 'select '||rc1.sequence_name||'.currval from dual';
			execute immediate str into ret;
			dbms_output.put_line('O valor da sequence '||rc1.sequence_name||' passou para '||ret);
		exception when others then
			dbms_output.put_line('Ocorreu erro ao decrementar a sequence '||rc1.sequence_name);
		end;
	end loop;
end;
			
                                                                                   