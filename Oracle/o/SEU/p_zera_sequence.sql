create or replace procedure seu.p_zera_sequence (tabela in varchar2)
is

valor number := 0;
str varchar2(1000);
aux number;

cursor c1 is select sequence_name,last_number -1 atual from user_sequences where table_name=tabela;

begin
  
  for rc1 in c1 loop
		str := 'alter sequence '||rc1.sequence_name||' increment by -'||rc1.atual;
		execute immediate str;
		str := 'select '||rc1.sequence_name||'.nextval from dual';
		execute immediate str into aux;
		str := 'alter sequence '||rc1.sequence_name||' increment by 1';
		execute immediate str;
	end loop;
	
end;
/

	