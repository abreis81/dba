col file_name format a55
set pages 1000
set lines 200

select tablespace_name
, file_name
, PHYWRTS WRITE
, PHYRDS READ
, (PHYRDS + PHYWRTS) TOTAL_IO
, round(((100*PHYWRTS)/(PHYRDS + PHYWRTS)),2) PCT_WRITE
, round(((100*PHYRDS)/(PHYWRTS + PHYRDS)),2) PCT_READ
, round(WRITETIM/PHYWRTS,2)*10 AVG_WRITE_TIME
, round(READTIM/PHYRDS,2)*10 AVG_READ_TIME
from dba_data_files a
    ,v$filestat b
where a.file_id=b.FILE#
order by substr(file_name,1,30), 5 desc, 3 desc, 8 desc, 9 desc, 4 desc