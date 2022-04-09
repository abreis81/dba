-----------------------------------
-- Esse script irá lhe mostrar todas as TABLESPACES do banco de dados que está com 0% livre para crescimento.
-- 02/01/2007
-- http://forum.imasters.com.br/lofiversion/index.php/t153642.html
-----------------------------------
SET SERVEROUTPUT ON
SET PAGESIZE 1000
SET LINESIZE 255
SET FEEDBACK OFF

PROMPT
PROMPT Tablespace perto de 0% free
PROMPT ***************************

SELECT a.tablespace_name,
       b.size_kb,
       a.free_kb,
       Trunc((a.free_kb/b.size_kb) * 100) "LIVRE_%"
FROM   (SELECT tablespace_name,
               Trunc(Sum(bytes)/1024) free_kb
        FROM   dba_free_space
        GROUP BY tablespace_name) a,
       (SELECT tablespace_name,
               Trunc(Sum(bytes)/1024) size_kb
        FROM   dba_data_files
        GROUP BY tablespace_name) b
WHERE  a.tablespace_name = b.tablespace_name
AND    Round((a.free_kb/b.size_kb) * 100,2) < 10
/

PROMPT
SET FEEDBACK ON
SET PAGESIZE 18
