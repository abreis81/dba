SET PAGES 0
/* 
  objetos invalidos
*/
select decode(object_type,'PACKAGE BODY','alter package '||object_name||' compile body;',
'alter '||object_type||' "'||object_name||'" compile;') Objetos_invalidos
from user_objects where status='INVALID';