column object_name formar a30
select object_name, object_type, to_char(created,'dd/mm hh24:mi') criado,
to_char(last_ddl_time, 'dd/mm hh24:mi') ultimo_cmd_ddl
from dba_objects where 
last_ddl_time > to_date('21/11 12:30','dd/mm hh24:mi')
/