/*
  SCRIPT:   LST_JOBS.SQL
  OBJETIVO: 
  AUTOR:    JOSIVAN
  DATA:     
*/

COL LAST     FORMAT A11 heading 'Ultima|Execucao';
COL NEXT     FORMAT A11 heading 'Proxima|Execucao';
COL THIS     FORMAT A17;
COL WHAT     FORMAT A30 heading 'Tarefa';
COL NO_JOB   FORMAT A7 heading 'Numero|Job';
COL INTERVAL FORMAT A13 heading 'Intervalo';
--
  SELECT SUBSTR(SCHEMA_USER,1,3)||'.'||TO_CHAR(JOB) NO_JOB
        ,to_char(LAST_DATE,'dd/mm hh24:mi') LAST
        ,to_char(NEXT_DATE,'dd/mm hh24:mi') NEXT
        ,INTERVAL
        ,WHAT
        ,BROKEN
    FROM ALL_JOBS
ORDER BY WHAT
        ,NEXT_DATE
/
