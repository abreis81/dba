
/*
compute avg of "TOTAL(MB)" on report
break on report
set pages 100
set lines 150
*/
ALTER SESSION SET nls_date_format='dd/mm/yyyy';
SELECT           TRUNC(COMPLETION_TIME,'HH') DATA,
            COUNT(*)      "QUANTIDADE",
            count(*) * (select avg(bytes)/1024/1024 from v$log) "TOTAL(MB)"
FROM  V$ARCHIVED_LOG
WHERE           COMPLETION_TIME >= TRUNC(SYSDATE,'DD') - 30 -- Específica a quantidade de dias
GROUP BY TRUNC(COMPLETION_TIME,'HH')
ORDER BY TRUNC(COMPLETION_TIME,'HH');
