--################################################################
-- Pesquisa quantidade de objetos inválidos 
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
-- Lista os objetos inválidos
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