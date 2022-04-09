REM  This script examines various V$ parameters.  The script makes suggestions
REM  on mods that can be made to your system if specific conditions exist.  The
REM  report should be run after the system has been up for at least 5 hours
REM  and should be run over a period of time to get a real feel for what the
REM  real condition of the database is.  A one-time sample run on an inactive
REM  system will not give an accurate picture of what is really occuring within
REM  the database.
REM
REM  If the database is shut down on a nightly basis for backups, the script can
REM  be run just prior to shutdown each night to enable trending analysis.
REM
REM  This script can be run on any platform but is tailored to evaluate an
REM  Oracle7.0.x database. The script should be run from an account that
REM  has DBA privileges and on which CATDBSYN.SQL has been run.
REM
REM **NOTE:  Be sure to change the "spool" path to reflect your directory
REM          structure.
REM
REM Alterada e atualizada por CRF em 19/11/97

Accept arquivo prompt 'Entre o Nome do Arquivo: '
spool d:\dba\&arquivo
set pages 60
set verify off
set head off
col name format a45
col phyrds format 9,999,999
col phywrts format 9,999,999
set echo off termout off feedback off
set newpage 1
set linesize 80
define cr=chr(10)
ttitle 'SYSTEM STATISTICS FOR ORACLE7'
select 'LIBRARY CACHE STATISTICS:' from dual;
ttitle off
select 'PINS - # of times an item in the library cache was executed - '||
sum(pins),
'RELOADS - # of library cache misses on execution steps - '||sum(reloads)||
&cr||&cr,
'RELOADS / PINS * 100 = '||round((sum(reloads) / sum(pins) * 100),2)||'%'
from v$librarycache
/
prompt If more than 1%, tune the library cache...
prompt To increase library cache, increase SHARED_POOL_SIZE
prompt
prompt ** NOTE: Increasing SHARED_POOL_SIZE will increase the SGA size.
prompt
prompt Library Cache Misses indicate that the Shared Pool is not big
prompt enough to hold the shared SQL area for all concurrently open cursors.
prompt If there are never any misses (PINS = 0), you may get a small increase
prompt in performance by setting CURSOR_SPACE_FOR_TIME = TRUE which prevents
prompt ORACLE from deallocating a shared SQL area while an application cursor
prompt associated with it is open.
prompt
prompt ------------------------------------------------------------------------

column xn1 format a50
column xn2 format a50
column xn3 format a50
column xv1 new_value xxv1 noprint
column xv2 new_value xxv2 noprint
column xv3 new_value xxv3 noprint
column d1 format a50
column d2 format a50
prompt HIT RATIO:
prompt
prompt Values Hit Ratio is calculated against:
prompt
select lpad(a.name,20,' ')||'  =  '||b.value xn1, b.value xv1
from
  v$statname a, v$sysstat b
where
  a.statistic# = b.statistic#
  and b. statistic# = 37
/
select lpad(a.name,20,' ')||'  =  '||b.value xn2, b.value xv2
from
  v$statname a, v$sysstat b
where
  a.statistic# = b.statistic#
  and b. statistic# = 38
/
select lpad(a.name,20,' ')||'  =  '||b.value xn3, b.value xv3
from
  v$statname a, v$sysstat b
where
  a.statistic# = b.statistic#
  and b. statistic# = 39
/
set pages 60
select 'Logical reads = db block gets + consistent gets ',
lpad('Logical Reads = ',24,' ')||to_char(&xxv1+&xxv2) d1
from dual
/
select 'Hit Ratio = (logical reads - physical reads) / logical reads',
lpad('Hit Ratio = ',24,' ')||
round( (((&xxv2+&xxv1) - &xxv3) / (&xxv2+&xxv1))*100,2 )||'%' d2
from dual
/
prompt If the hit ratio is less than 60%-70%, increase the initialization
prompt parameter DB_BLOCK_BUFFERS.  ** NOTE:  Increasing this parameter will
prompt increase the SGA size.
prompt
prompt ------------------------------------------------------------------------

col name format a30
col gets format 9,999,999
col waits format 9,999,999
prompt ROLLBACK CONTENTION STATISTICS:
prompt

prompt GETS - # of gets on the rollback segment header
prompt WAITS - # of waits for the rollback segment header

set head on;
select name, waits, gets
from v$rollstat, v$rollname
where v$rollstat.usn = v$rollname.usn
/
set head off
select 'The average of waits/gets is '||
  round((sum(waits) / sum(gets)) * 100,2)||'%'
from v$rollstat
/

prompt
prompt If the ratio of waits to gets is more than 1% or 2%, consider
prompt creating more rollback segments
prompt
prompt Another way to gauge rollback contention is:
prompt

column xn1 format 999999999
column xm1 format 999999999
column xv1 new_value xxv1 noprint
set head on
select class, count
from v$waitstat
where class in ('system undo header','system undo block','undo header',
  'undo block')
/
set head off
-- acredito ser esse o SQL correto
SELECT 'Total requests = '||SUM(value) xn1, SUM(value) xv1
FROM v$sysstat  WHERE name IN ('db block gets', 'consistent gets')
/
--Esse SQL original do script estava com erro. Foi substituido pelo SQL acima.
--Alterado em 25/09/98
--select 'Total requests = '||sum(count) xn1, sum(count) xv1
--from v$waitstat
select 'Total waits    = '||sum(count) xm1 from v$waitstat
/
select 'Contention for system undo header = '||
decode(&xxv1,0,0,(round(count/&xxv1,4)) * 100)||'%'
from v$waitstat
where class = 'system undo header'
/
select 'Contention for system undo block = '||
decode(&xxv1,0,0,(round(count/&xxv1,4)) * 100)||'%'
from v$waitstat
where class = 'system undo block'
/
select 'Contention for undo header = '||
decode(&xxv1,0,0,(round(count/&xxv1,4)) * 100)||'%'
from v$waitstat
where class = 'undo header'
/
select 'Contention for undo block = '||
decode(&xxv1,0,0,(round(count/&xxv1,4)) * 100)||'%'
from v$waitstat
where class = 'undo block'
/
select 'Contention for freelist = '||
decode(&xxv1,0,0,(round(count/&xxv1,4)) * 100)||'%'
from v$waitstat
where class = 'free list'
/
prompt
prompt If the percentage for an area is more than 1% or 2%, consider
prompt creating more rollback segments.  Note:  This value is usually very small
prompt and has been rounded to 4 places.
prompt
prompt ------------------------------------------------------------------------

prompt REDO CONTENTION STATISTICS:
prompt
prompt The following shows how often user processes had to wait for space in
prompt the redo log buffer:

select name||' = '||value||&cr
from v$sysstat
where name = 'redo log space requests'
/
prompt
prompt This value should be near 0.  If this value increments consistently,
prompt processes have had to wait for space in the redo buffer.  If this
prompt condition exists over time, increase the size of LOG_BUFFER in the
prompt init.ora file in increments of 5% until the value nears 0.
prompt ** NOTE: increasing the LOG_BUFFER value will increase total SGA size.
prompt
prompt ------------------------------------------------------------------------


col name format a15
col gets format 99999999
col misses format 99999999
col immediate_gets heading 'IMMED GETS' format 99999999
col immediate_misses heading 'IMMED MISS' format 99999999
col sleeps format 9999999
prompt LATCH CONTENTION:
prompt
prompt GETS - # of successful willing-to-wait requests for a latch
prompt MISSES - # of times an initial willing-to-wait request was unsuccessful
prompt IMMEDIATE_GETS - # of successful immediate requests for each latch
prompt IMMEDIATE_MISSES = # of unsuccessful immediate requests for each latch
prompt SLEEPS - # of times a process waited and requests a latch after an initial
prompt          willing-to-wait request
prompt
prompt If the latch requested with a willing-to-wait request is not
prompt available, the requesting process waits a short time and requests again.
prompt If the latch requested with an immediate request is not available,
prompt the requesting process does not wait, but continues processing
prompt

set head on;
select name, gets, misses, immediate_gets, immediate_misses, sleeps
from v$latch
where name in ('redo allocation','redo copy')
/
set head off
select 'Ratio of MISSES to GETS: '||round((sum(misses)/sum(gets) * 100),2)||'%'
from v$latch
where name in ('redo allocation','redo copy')
/
select 'Ratio of IMMEDIATE_MISSES to IMMEDIATE_GETS: '||
decode(sum(immediate_misses+immediate_gets),0,0,
round((sum(immediate_misses)/sum(immediate_misses+immediate_gets) * 100),2))
||'%'
from v$latch
where name in ('redo allocation','redo copy')
/

prompt
prompt If either ratio exceeds 1%, performance will be affected.
prompt
prompt Decreasing the size of LOG_SMALL_ENTRY_MAX_SIZE reduces the number of
prompt processes copying information on the redo allocation latch.
prompt
prompt Increasing the size of LOG_SIMULTANEOUS_COPIES will reduce contention for
prompt redo copy latches.

rem
rem This shows the library cache reloads
rem
prompt
prompt ------------------------------------------------------------------------

rem
rem Presented at ECO'94 by Michelle Becci
rem

prompt
prompt Look at gethitratio and pinhit ratio
prompt
prompt GETHITRATIO is number of GETHTS/GETS
prompt PINHIT RATIO is number of PINHITS/PINS - number close to 1 indicates
prompt that most objects requested for pinning have been cached
prompt

set head on
column namespace format a20 heading 'NAME'
column gets format 999999999 heading 'GETS'
column gethits format 999999999 heading 'GETHITS'
column gethitratio format 999.99 heading 'GET HIT|RATIO'
column pins format 999999999 heading 'PINHITS'
column pinhitratio format 999.99 heading 'PIN HIT|RATIO'
select namespace, gets, gethits, gethitratio, pins, pinhitratio
from v$librarycache
/
prompt
prompt ------------------------------------------------------------------------

rem
rem
rem This looks at the sga area breakdown
rem
set head on
prompt THE SGA AREA ALLOCATION:
prompt
prompt
prompt This shows the allocation of SGA storage.  Examine this before and
prompt after making changes in the INIT.ORA file which will impact the SGA.
prompt
rem
col name format a40
select name, bytes
  from v$sgastat
/
prompt
prompt ------------------------------------------------------------------------

prompt This looks at overall i/o activity against individual files within a
prompt tablespace.  Add up the numbers by disk and look for a mismatch across
prompt disks in terms of I/O.
prompt
prompt If activity on the files is unbalanced, move files around to balance
prompt the load.  Should see an approximately even set of numbers across files.
prompt

set pagesize 100;
set space 1
column pbr format 999999999 heading 'Physical|Blk Read'
column pbw format 9999999 heading 'Physical|Blks Wrtn'
column pyr format 9999999 heading 'Physical|Reads'
column readtim format 9999999 heading 'Read|Time'
column name format a40 heading 'DataFile Name'
column writetim format 9999999 heading 'Write|Time'
ttitle center 'Tablespace Report' skip 2
compute sum of f.phyblkrd, f.phyblkwrt on report
rem
select fs.name name,f.phyblkrd pbr,f.phyblkwrt pbw,f.readtim,
f.writetim
from v$filestat f, v$dbfile fs
where f.file# = fs.file#
order by fs.name
/
prompt
prompt ------------------------------------------------------------------------

rem
rem Presented at ECO'94 by Michelle Becci - with modifications by M. Theriault
rem

prompt GENERATING WAIT STATISTICS:
prompt
prompt This will show wait stats for certain kernel instances.  This may show
prompt the need for additional rbs, wait lists, db_buffers
prompt

ttitle center 'Wait Statistics for the Instance' skip 2
column class heading 'Class Type'
column count format 999,999,999 heading 'Times Waited'
column time heading 'Total Times' format 999,999,999
select class, count, time
from v$waitstat
where count > 0
order by class
/
prompt
prompt Look at the wait statistics generated above (if any). They will
prompt tell you where there is contention in the system.  There will
prompt usually be some contention in any system - but if the ratio of
prompt waits for a particular operation starts to rise, you may need to
prompt add additional resource, such as more database buffers, log buffers,
prompt or rollback segments
prompt
prompt ------------------------------------------------------------------------

prompt ROLLBACK STATISTICS:
prompt

ttitle off;
column extents format 9999 heading 'Extents'
column rssize format 999,999,999 heading 'Size in|Bytes'
column optsize format 999,999,999 heading 'Optimal|Size'
column hwmsize format 9,999,999,999 heading 'High Water|Mark'
column shrinks format 9,999,999 heading 'Number of|Shrinks'
column extends format 9,999,999 heading 'Number of|Extends'
column aveactive format 9,999,999,999 heading 'Average size|Active Extents'
column rownum noprint
select rssize, optsize, hwmsize, shrinks, extends, aveactive
from v$rollstat
order by rownum
/
rem
prompt
prompt ------------------------------------------------------------------------

break on report
compute sum of gets waits writes on report
ttitle center 'Rollback Statistics' skip 2
select rownum, extents, rssize, xacts, gets, waits, writes
from v$rollstat
order by rownum
/
ttitle off
set heading off
ttitle off
prompt
prompt ------------------------------------------------------------------------

rem
rem Presented at ECO'94 by Michelle Becci - with modifications by M. Theriault
rem

prompt
prompt SORT AREA SIZE VALUES:
prompt
prompt To make best use of sort memory, the initial extent of your Users
prompt sort-work Tablespace should be sufficient to hold at least one sort
prompt run from memory to reduce dynamic space allocation.  If you are getting
prompt a high ratio of disk sorts as opposed to memory sorts, setting
prompt sort_area_retained_size = 0 in init.ora will force the sort area to be
prompt released immediately after a sort finishes.
prompt
column value format 99,999,999,999
select 'INIT.ORA sort_area_size: '||value
from v$parameter where name like 'sort_area_size';
select a.name, value
from v$statname a, v$sysstat b
where a.statistic# = b.statistic#
and a.name in ('sorts (disk)','sorts (memory)','sorts (rows)')
/
prompt
prompt ------------------------------------------------------------------------

set heading on
set space 2
prompt
prompt This looks at Tablespace Sizing - Total bytes and free bytes
prompt

Create or replace view vw_dba_datafiles (tablespace_name, Total_Bytes) as
   select tablespace_name, sum(bytes)
   from dba_data_files
   group by tablespace_name
/
ttitle center 'Tablespace Sizing Information' Skip 2
set heading on
set space 2
column sbytes format 99,999,999,999,999 heading 'Total Bytes'
column fbytes format 9,999,999,999,999 heading 'Free Bytes'
column kount format 9,999 heading 'Free|Chunks'
compute sum of sbytes on report
compute sum of fbytes on report
break on report
select a.tablespace_name, a.Total_bytes sbytes, sum(b.bytes) fbytes,
   count(*) kount
from vw_dba_datafiles a, dba_free_space b
where a.tablespace_name = b.tablespace_name
group by a.tablespace_name, a.total_bytes
order by a.tablespace_name
/
Drop view vw_dba_datafiles
/

prompt
prompt A large number of Free Chunks indicates that the tablespace may need
prompt to be defragmented and compressed.
prompt
prompt ------------------------------------------------------------------------

set heading off
ttitle off
column value format 999,999,999,999
select 'Total Physical Reads', value
from v$sysstat
where statistic# = 39
/
prompt
prompt If you can significantly reduce physical reads by adding incremental
prompt data buffers...do it.  To determine whether adding data buffers will
prompt help, set db_block_lru_statistics = TRUE and
prompt db_block_lru_extended_statistics = TRUE in the init.ora parameters.
prompt You can determine how many extra hits you would get from memory as
prompt opposed to physical I/O from disk.  **NOTE:  Turning these on will
prompt impact performance.  One shift of statistics gathering should be enough
prompt to get the required information.
prompt

set heading on
clear computes
ttitle off
prompt
prompt ------------------------------------------------------------------------

prompt CHECKING FOR FRAGMENTED DATABASE OBJECTS:
prompt
prompt Fragmentation report - If number of extents is approaching Max extents,
prompt it is time to defragment the table.
prompt
column owner noprint new_value owner_var
column segment_name format a30 heading 'Object Name'
column segment_type format a9 heading 'Table/Indx'
column sum(bytes) format 9,999,999,999 heading 'Bytes Used'
column count(*) format 999 heading 'No.'
break on owner skip page 2
ttitle center 'Table Fragmentation Report' skip 2 -
  left 'creator: ' owner_var skip 2
select  a.owner, segment_name, segment_type, sum(bytes), max_extents, count(*)
from    dba_extents a, dba_tables b
where   a.owner = b.owner and
        a.owner not in ('SYS','SYSTEM') and
        segment_name = b.table_name
having count(*) > 1
group by a.owner, segment_name, segment_type, max_extents
order by a.owner, segment_name, segment_type, max_extents
/
ttitle center 'Index Fragmentation Report' skip 2 -
  left 'creator: ' owner_var skip 2
select  a.owner, segment_name, segment_type, sum(bytes), max_extents, count(*)
from    dba_extents a, dba_indexes b
where   a.owner = b.owner and
        a.owner not in ('SYS','SYSTEM') and
        segment_name = index_name
having count(*) > 1
group by a.owner, segment_name, segment_type, max_extents
order by a.owner, segment_name, segment_type, max_extents
/

prompt
prompt ------------------------------------------------------------------------

spool off
@d:\dba\initx
