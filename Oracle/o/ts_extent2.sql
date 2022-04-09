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

compute sum of next_extent on report;
break on report;

  select 'alter index edge.'||a.segment_name||' storage (next 25M);'
    from dba_segments a
        ,(select tablespace_name 
                ,max(bytes) bytes
            from dba_free_space
        group by tablespace_name) s
   where s.tablespace_name(+) = a.tablespace_name
     and (a.next_extent) > s.bytes
     and a.tablespace_name='IX_PROD'
order by a.tablespace_name
        ,a.segment_name
/

ttitle off

