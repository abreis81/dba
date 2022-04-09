/* 
  objetos invalidos
*/
select decode(object_type,'PACKAGE BODY','alter package '||owner||'."'||object_name||'" compile body;',
'alter '||object_type||' '||owner||'."'||object_name||'" compile;') Objetos_invalidos
from dba_objects where status='INVALID' and owner like '%RSD%';
/* 
  indices invalidos 
*/
select owner, index_name from dba_indexes where status<>'VALID';