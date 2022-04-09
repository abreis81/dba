--Pesquisa filesystem do Banco de Dados
select	distinct
	substr(name,0,instr(name,'/',-1)) dir	
from	(
	select name from v$datafile
	UNION
	select name from v$controlfile
	UNION
	select name from v$tempfile
	UNION
	select member name from v$logfile);
	
	
--Remover Banco de Dados
set lines 0
set pages 0
select	'rm -f '||name  dir	
from	(
	select name from v$datafile
	UNION
	select name from v$tempfile
	UNION
	select name from v$controlfile
	UNION
	select member name from v$logfile);	