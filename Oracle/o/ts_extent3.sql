/*
  script:   ts_extent.sql
  objetivo: segmento cujo proximo extent será maior que o espaco contiguo disponivel na tablespace
  autor:    Josivan
  data:     
*/

set termout on
set feedback on
set pages 1000
set lines 200

col next_extent format 9999,999
col extents     format 9999,999
col livre       format 9999,999

  select 'alter'||' '||a.segment_type||' '||owner||'.'||a.segment_name||' storage (next 25M);'
    from dba_segments a
        ,(select tablespace_name 
                ,max(bytes) bytes
            from dba_free_space
        group by tablespace_name) s
   where s.tablespace_name(+) = a.tablespace_name
     and (a.next_extent) > s.bytes
order by a.tablespace_name
        ,a.segment_name
/

ttitle off

