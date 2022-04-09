SELECT 'ALTER '||decode(object_type,'PACKAGE BODY','Package','UNDEFINED','SnapShot',object_type)||
   decode(OBJECT_TYPE,'PACKAGE BODY',' '||owner||'.'||OBJECT_NAME||' COMPILE BODY;',
   ' '||owner||'.'||OBJECT_NAME||' COMPILE; ') Linha_de_Alteracao
FROM   all_OBJECTS
WHERE  STATUS = 'INVALID'
order by 1
/

