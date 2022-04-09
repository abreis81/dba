select decode(object_type,'PACKAGE BODY','drop package '||owner||'.'||object_name||';',
'drop '||object_type||' '||owner||'.'||object_name||';') Objetos_invalidos
from dba_objects where status='INVALID';
