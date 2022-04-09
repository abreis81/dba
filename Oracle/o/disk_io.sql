
create or replace view j_filestat_sum (sumphyrds, sumphywrts) as
select sum(phyrds)
      ,sum(phywrts)
  from v$filestat
/ 
--
set lines 200
--
column "DATAFILE" format a75
column "PARTITION" format a10
column "PCT_READS" format 999.99
column "PCT_WRITES" format 999.99
--
break on "PARTITION" skip 1
--
compute sum of "READS"      on "PARTITION"
compute sum of "PCT_READS"  on "PARTITION"
compute sum of "WRITES"     on "PARTITION"
compute sum of "PCT_WRITES" on "PARTITION"
--
  SELECT SUBSTR(b.name, 13, INSTR(b.name,'/', 2)) "PARTITION"
        ,b.name                                  "DATAFILE"
        ,phyrds                                  "READS"
        ,(phyrds/sumphyrds) * 100                "PCT_READS"
        ,phywrts                                 "WRITES"
        ,(phywrts/sumphywrts) * 100              "PCT_WRITES"
    FROM v$filestat a
        ,v$datafile b
        ,j_filestat_sum
   WHERE a.file# = b.file#
ORDER BY SUBSTR(b.name, 13, INSTR(b.name,'/', 2))
/

DROP VIEW j_filestat_sum;
