--################################################################
-- Pesquisa quantidade de objetos inv�lidos 
--################################################################

set lines 125
col object_type for a20
select	owner,
	object_type,
	status,
	count(*) 
from 	dba_objects 
where 	status <> 'VALID' 
group by owner,
	 object_type,
	 status;
	 
--################################################################
-- Lista os objetos inv�lidos
--################################################################

set lines 125
col object_type for a20
col object_name for a30
select	owner,
	object_type,
	object_name,
	status
from 	dba_objects 
where 	status <> 'VALID';