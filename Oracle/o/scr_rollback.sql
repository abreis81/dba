/*
  script:   scr_rollback.sql
  objetivo: recria o segmento de rollback
  autor:    Josivan
  data:     
*/
--
--spool recria_rbs.lis
--
select distinct 'create rollback segment '||a.segment_name||'tablespace '||a.tablespace_name||
                'storage (initial '||a.initial_extent||' next '||a.next_extent||
                'optimal '||b.optsize||' minextents '||a.min_extents||
                ' maxextents '||a.max_extents||');'
  from dba_rollback_segs a
      ,v$rollstat b
      ,dba_segments c
 where b.extents      = c.extents
   and c.segment_type = 'ROLLBACK'
   and a.segment_id   = b.usn        
   and (a.segment_name like 'R0%' or a.segment_name like 'R1%')
/
--
--spool off
