create or replace procedure seu.p_trunc_seuaet
is

str varchar2(500);

begin
	
	str := 'truncate table seu.seuaet';
	execute immediate str;

exception when others then
	RAISE_APPLICATION_ERROR(-20999,'Erro ao truncar a tabela SEUAET: '||sqlerrm);
end;
/
