/*
  SCRIPT:   TS_DATAFILE2.SQL
  OBJETIVO: VERIFICAR DATAFILES MAIORES QUE 1.5GB
  AUTOR:    JOSIVAN
  DATA:     
*/

SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF
SET LINE 150
SET PAGESIZE 200

rem
rem     Configurar Relatorio
rem
col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint
col p_temp5 new_value                   p_block     noprint
--
define p_sql       = ts_datafile
define p_tam_linha = 150
--
set termout off
--
select lower(name)                    p_temp4
      ,lower(name)                    p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')  p_temp1
      ,rpad('*', 150,'*')             p_temp2	
  from v$database
/
set termout on
--
rem
rem	Header e Footer - Query 2
rem
ttitle left p_traco skip -
       left p_data -
       right format 999 'Pag.: ' sql.pno skip 2 -
       center 'Tablespace x Datafile x Espaco' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off

COL TABLESPACE_NAME HEADING "tablespace" FORMAT A30
COL FILE_NAME       HEADING "datafile"   FORMAT A75
COL PER_FREE  FORMAT 999
COL MBYTES    FORMAT 999,999,999
COL MB_FREE   FORMAT 999,999,999
COL MB_USADO  FORMAT 999,999,999
--
BREAK ON TABLESPACE_NAME SKIP 1
--
  SELECT D.TABLESPACE_NAME
        ,D.FILE_NAME      
        ,SUM(D.BYTES)/1024     "TOTAL"
    FROM DBA_DATA_FILES D
   WHERE D.AUTOEXTENSIBLE = 'YES'
GROUP BY D.TABLESPACE_NAME
        ,D.FILE_NAME
  HAVING SUM(D.BYTES)/1024 > 1500000
/
 
CLEAR BREAK
TTITLE OFF
SET LINE 120
SET FEEDBACK ON
SET VERIFY ON
