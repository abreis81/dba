REM name: freespace_temp.sql
REM 	This script is used to list database freespace, total database
REM space, largest extent, fragments and percent freespace. 
REM  
REM  Usage sqlplus system/passwd @freespace
REM  
REM     Date         Create           Description
REM    30-Oct-96   F. Zhang           Initial creation
REM 
REM  dba tool key: freespace.sql -- list database freespace, total space and percent free 
REM 
SET HEAD ON
accept prefix prompt "Prefixo da tablespace: "
set ver off
DEF MBYTES_CRITICO=100
DEF PCT_CRITICO=10
col tablespace format a20
col free heading 'Free(Mb)' format 999999.9
col total heading 'Total(Mb)' format 9999999.9
col used heading 'Used(Mb)' format 999999.9
col pct_free heading 'Pct|Free' format 99999.9
col largest heading 'Largest(Mb)' format 99999.9
col fragm format 9999
col status format a7
compute sum of total on report
compute sum of free on report
compute sum of used on report
break on report
select substr(a.tablespace_name,1,20) tablespace,
round(sum(a.total1)/1024/1024, 1) Total,
round(sum(a.total1)/1024/1024, 1)-round(sum(a.sum1)/1024/1024, 1) used,
round(sum(a.sum1)/1024/1024, 1) free,
decode(round(sum(a.total1)/1024/1024, 1),0,0,round(sum(a.sum1)/1024/1024, 1)*100/round(sum(a.total1)/1024/1024, 1)) pct_free,
round(sum(a.maxb)/1024/1024, 1) largest,
max(a.cnt) fragm,
substr(decode(round(sum(a.total1)/1024/1024, 1),0,'ATENCAO')||decode(sign(decode(round(sum(a.total1)/1024/1024, 1),0,0,round(sum(a.sum1)/1024/1024, 1)*100/round(sum(a.total1)/1024/1024, 1))-&pct_critico),-1,decode(sign(round(sum(a.sum1)/1024/1024, 1)-&mbytes_critico),-1,'CRITICO')),1,7) STATUS
from
(select tablespace_name, 0 total1, sum(bytes) sum1, 
max(bytes) MAXB,
count(bytes) cnt
from dba_free_space
--where tablespace_name like upper(nvl('&prefix','%'))
group by tablespace_name
union
select tablespace_name, sum(bytes) total1, 0, 0, 0 from dba_temp_files
where tablespace_name like upper(nvl('&prefix','%'))
group by tablespace_name) a
where tablespace_name like upper(nvl('&prefix','%'))
group by a.tablespace_name
order by 1
/
