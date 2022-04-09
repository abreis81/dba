col NAME format a50
set lines 300
set pages 1000

select c.tablespace_name, b.name, 
a.phyblkrd + a.phyblkwrt total, a.phyrds, 
a.phywrts, a.phyblkrd, a.phyblkwrt,
((a.readtim / decode(a.phyrds, 0, 1, a.phyblkrd)) / 100) avg_rd_time,
((a.writetim / decode(a.phywrts, 0, 1, a.phyblkwrt)) /100) 
avg_wrt_time
from v$filestat a, v$datafile b, sys.dba_data_files c
where b.file# = a.file#
and b.file# = c.file_id
order by tablespace_name
/

