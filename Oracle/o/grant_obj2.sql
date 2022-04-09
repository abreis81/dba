set pages 0
set lines 200
set ver off
accept owner prompt "Digite o owner da aplicacao: "

select 'grant '||decode(object_type,'TABLE','SELECT,INSERT,UPDATE,DELETE','SEQUENCE','SELECT','EXECUTE')||' ON '||
OBJECT_NAME||' TO &&OWNER._rw;'
FROM USER_OBJECTS 
WHERE OBJECT_TYPE IN ('TABLE','SEQUENCE','TYPE','FUNCTION','PACKAGE','PROCEDURE')
UNION
SELECT 'GRANT SELECT ON '||OBJECT_NAME||' TO &&OWNER._RO;'
FROM USER_OBJECTS
WHERE OBJECT_TYPE ='TABLE';  