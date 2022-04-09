set pages 1000
/* 
  objetos invalidos
*/
select decode(object_type,'PACKAGE BODY','alter package '||owner||'."'||object_name||'" compile body;',
'alter '||decode(object_type,'UNDEFINED','MATERIALIZED VIEW',object_type)||' '||owner||'."'||object_name||'" compile;') Objetos_invalidos
from dba_objects where status='INVALID';
/* 
  indices invalidos 
*/
--select owner, index_name from dba_indexes where status='UNUSABLE';