accept segname
select COUNT(1), file_id, b.name from dba_extents a, v$datafile b where a.file_id=b.file# and
segment_name=upper('&segname') GROUP BY file_id, b.name
/
