spool c:\tbedge_log_tr1.log

SET LINES 1000
COLUMN INFO_TRANS FORMAT A10

SELECT AGENCIA,CONTA,DTHR_LOG,DIGAGENCIA,ID,INFO_TRANS,OPERACAO,RAZAO,
TIPO,TRANSACAO,USUARIO,VALOR,NNUM_SITE,DIGCONTA
FROM TBEDGE_LOG_TR
WHERE TRANSACAO= ' '
AND   OPERACAO = ' '
AND   VALOR = 0.00
AND  dthr_log >= TO_DATE('14/05/01','DD/MM/YY')
AND dthr_log <= TO_DATE('14/05/01','DD/MM/YY') + 0.9999
/

spool off
