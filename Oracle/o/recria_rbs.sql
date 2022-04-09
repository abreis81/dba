--
select distinct 'create rollback segment '
                ||a.segment_name
                ||' tablespace '
                ||a.tablespace_name
                ||' storage (initial '
                ||a.initial_extent
                ||' next '
                ||a.next_extent
                ||' optimal '
                ||decode(b.optsize,null,0,b.optsize)
                ||' minextents '
                ||a.min_extents
                ||' maxextents '
                ||a.max_extents||');'
  from dba_rollback_segs a
      ,v$rollstat b
      ,dba_segments c
 where b.extents      = c.extents
   and c.segment_type = 'ROLLBACK'
   and a.segment_id   = b.usn     
   and (a.segment_name like 'RB0%' or a.segment_name like 'RB1%')
/
