SELECT 'EXEC SP_LISTA_ERROS('||''''||TO_CHAR(MIN(A.ENQ_TIME),
'DD/MM/YYYY HH24:MI')||''''||','||''''||
TO_CHAR((MAX(A.ENQ_TIME)+1/1440),'DD/MM/YYYY HH24:MI')||''''||');'
FROM SYSTEM.DEF$_AQERROR A
/
