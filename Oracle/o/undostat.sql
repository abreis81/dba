set pages 1000
set lines 200
col retencao format a10

select * from (select BEGIN_TIME, END_TIME, UNDOBLKS, MAXQUERYLEN Tempo_de_execucao, EXPSTEALCNT, EXPBLKREUCNT
, DECODE(SSOLDERRCNT,0,'OK','REDEFINIR UNDO_RETENTION') Retencao
, decode(NOSPACEERRCNT,0,'OK','AUMENTAR UNDO') Tamanho
from v$undostat 
order by MAXQUERYLEN desc) 
where rownum < 11;

select case when a.necessario > b.atual
 THEN 'Aumentar tablespace Undo'
 ELSE 'Undo esta ok' END Tamanho_Undo
FROM (SELECT trunc(((UR * (UPS * DBS)) + (DBS * 24))/1024/1024) AS necessario
 FROM (SELECT value AS UR FROM v$parameter WHERE name = 'undo_retention'),
 (SELECT (SUM(undoblks)/SUM(((end_time - begin_time)*86400))) AS UPS FROM v$undostat),
 (select block_size as DBS from dba_tablespaces where tablespace_name=
 (select value from v$parameter where name = 'undo_tablespace'))) a
,(select trunc(sum(bytes/1024/1024)) AS  atual
  from
  dba_data_files where tablespace_name=
  (select value from v$parameter where name = 'undo_tablespace')) b
/

SELECT trunc(((UR * (UPS * DBS)) + (DBS * 24))/1024/1024) AS necessario
 FROM (SELECT value AS UR FROM v$parameter WHERE name = 'undo_retention'),
 (SELECT (SUM(undoblks)/SUM(((end_time - begin_time)*86400))) AS UPS FROM v$undostat),
 (select block_size as DBS from dba_tablespaces where tablespace_name=
 (select value from v$parameter where name = 'undo_tablespace'));