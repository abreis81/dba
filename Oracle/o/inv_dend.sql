set echo off feed off head off ver off lines 2000 def on trimspool on
----------------------------------------------------------------------------------------------
--Este script recompila todos os objetos dependentes do owner/objeto informados, na ordem
--correta de dependência
----------------------------------------------------------------------------------------------

accept xSPOOL  prompt 'Digite o arquivo de SPOOL a criar.: '
accept xOWNER  prompt 'Digite o OWNER do Objeto alterado.: '
accept xOBJECT prompt 'Digite o OBJETO alterado..........: '

column a1 for 99

spool c:\temp\invalidos.&xSPOOL


select 
	'alter ' || 
	decode(o.object_type,'PACKAGE BODY','PACKAGE',o.object_type) || ' ' ||
	o.owner || '.' || o.object_name || ' compile' || 
	decode(o.object_type,'PACKAGE BODY',' body;',';') || chr(10) || 'show err' a2
from
	(
	select 
		max(level) nivel, object_id id_pai
	from 
		public_dependency
	start with referenced_object_id in
		(
		select 
			object_id
		from
			dba_objects
		where
			owner LIKE UPPER('&xOWNER%') and
			object_name LIKE UPPER('&xOBJECT%')
		)
	connect by 
		referenced_object_id = prior object_id
	group by
		object_id
	) p,
	dba_objects o
where
	o.object_id = p.id_pai	and
	o.status = 'INVALID'	and
	o.object_type in	
		(
		'FUNCTION',
		'PROCEDURE',
		'PACKAGE',
		'PACKAGE BODY',
		'TRIGGER',
		'VIEW'
		)
order by
	nivel;

prompt spool off
--prompt host notepad p:\oracle\spool\invalidos.log

spool off

set feed on head on

@c:\temp\invalidos.&xSPOOL
