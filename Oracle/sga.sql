--- SGA TARGET ADVICE

select sga_size, sga_size_factor, estd_db_time, estd_db_time_factor, estd_physical_reads
 from v$sga_target_advice order by sga_size_factor;
 
--- Componentes da sga 
 
select component, current_size from v$sga_dynamic_components;

--- Show sga

select * from v$sga;

--- Informacao SGA

select * from v$sgainfo;

--- PGA advice

select (pga_target_for_estimate/1024/1024) target_mb, pga_target_factor,
round(bytes_processed/1024/1024) mb_processed,
round(estd_extra_bytes_rw/1024/1024) Extra_mb_rw,
estd_pga_cache_hit_percentage cache_hit_perc,
estd_overalloc_count
from V$PGA_TARGET_ADVICE;

--- PGA session

SELECT
s.value,s.sid,a.username
FROM
V$SESSTAT S, V$STATNAME N, V$SESSION A
WHERE
n.STATISTIC# = s.STATISTIC# and
name = 'session pga memory'
AND s.sid=a.sid
ORDER BY s.value desc

--- Show pga
SELECT * FROM V$PGASTAT;

----

SELECT
low_optimal_size/1024 "Low (K)",
(high_optimal_size + 1)/1024 "High (K)",
optimal_executions "Optimal",
onepass_executions "1-Pass",
multipasses_executions ">1 Pass"
FROM v$sql_workarea_histogram
WHERE total_executions <> 0;

----

SELECT name PROFILE, cnt COUNT,
DECODE(total, 0, 0, ROUND(cnt*100/total)) PERCENTAGE
FROM (SELECT name, value cnt, (sum(value) over ()) total
FROM V$SYSSTAT
WHERE name like 'workarea exec%');

----

SELECT
sum(s.value)/1024/1024 M
FROM
V$SESSTAT S, V$STATNAME N, V$SESSION A
WHERE
n.STATISTIC# = s.STATISTIC# and
name = 'session pga memory'
AND s.sid=a.sid;
--ORDER BY s.value desc;
