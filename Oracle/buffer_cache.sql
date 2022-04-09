--- Buffer cache hit ratio

select
    100*(1 - (v3.value / (v1.value + v2.value))) "Cache Hit Ratio [%]"
from
  v$sysstat v1, v$sysstat v2, v$sysstat v3
where
  v1.name = 'db block gets' and
  v2.name = 'consistent gets' and
  v3.name = 'physical reads'


--Buffer cache para sessão especifica
--You can also see the buffer cache hit ratio for one specific session since that session started: 

 SELECT (P1.value + P2.value - P3.value) / (P1.value + P2.value)
     FROM   v$sesstat P1, v$statname N1, v$sesstat P2, v$statname N2,
            v$sesstat P3, v$statname N3
     WHERE  N1.name = 'db block gets'
     AND    P1.statistic# = N1.statistic#
     AND    P1.sid = <enter SID of session here>
     AND    N2.name = 'consistent gets'
     AND    P2.statistic# = N2.statistic#
     AND    P2.sid = P1.sid
     AND    N3.name = 'physical reads'
     AND    P3.statistic# = N3.statistic#
     AND    P3.sid = P1.sid

----------------------

     SELECT   250 * TRUNC (rownum / 250) + 1 || ' to ' || 
              250 * (TRUNC (rownum / 250) + 1) "Interval", 
              SUM (count) "Buffer Cache Hits"
     FROM     v$recent_bucket
     GROUP BY TRUNC (rownum / 250)


------------------------

---- Informações de leitura por datafile

  SELECT   A.file_name, B.phyrds, B.phyblkrd
     FROM     SYS.dba_data_files A, v$filestat B
     WHERE    B.file# = A.file_id
     ORDER BY A.file_id

--------------------------

--- QUERYS que mais leram o disco.

 SELECT   executions, buffer_gets, disk_reads, 
              first_load_time, sql_text
     FROM     v$sqlarea
     ORDER BY disk_reads desc
