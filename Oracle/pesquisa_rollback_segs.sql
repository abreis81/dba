select	rs.segment_name,
	rs.tablespace_name,
	s.extents,
	rs.max_extents,
	rs.status 
from 	dba_segments s,
	dba_rollback_segs rs
where 	s.segment_name = rs.segment_name
and	s.owner = rs.owner 
and	rs.segment_name = 'R02';

--******************************************

ALTER ROLLBACK SEGMENT R02 shrink;
ALTER ROLLBACK SEGMENT R02 storage (maxextents 500);