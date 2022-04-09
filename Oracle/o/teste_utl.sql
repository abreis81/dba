accept caminho prompt "Digite o caminho do arq: "

set serveroutput on size 50000

declare

arq utl_file.file_type;
str varchar2(50);

begin

	arq := utl_file.fopen(&caminho,'teste_rod.txt','w');
	str := 'teste123';
	utl_file.put_line(arq,str);
	utl_file.fclose(arq);

end;
/
