set pagesize 66
set echo off
clear break
clear compute
column seg           format '999'
column mbytes        format '9,990.00'
column minit         format '9,990.00'
column knext         format '99,990.00'
--
clear screen
--
ttitle center "Relacao de Segmentos Cheios" Skip 2
--
  select substr(s.segment_name,1,25)   segment
        ,substr(s.segment_type,1,3)    type
        ,substr(s.owner,1,5)           owner
        ,substr(s.tablespace_name,1,8) tablespa
        ,s.extents                     seg
        ,s.bytes/1024/1024             mbytes
        ,s.initial_extent/1024/1024    minit
        ,s.next_extent/1024/1024       knext
    from sys.dba_segments s
   where not exists (select 1 
                       from sys.dba_free_space f
                      where f.tablespace_name  = s.tablespace_name 
                        and f.bytes           >= s.next_extent )
order by s.next_extent
        ,s.segment_name
        ,s.owner
/
set echo on
ttitle off

