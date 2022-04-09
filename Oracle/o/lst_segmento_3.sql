set pagesize 66
--
clear break
--
clear compute
--
column type          format a3
column seg           format '999'
column mbytes        format '9,990.0'
column minit         format '9,990.0'
column mnext         format '9,990.0'
--
  select substr(a.segment_type,1,3)    type
        ,substr(a.owner,1,5)           own
        ,substr(a.segment_name,1,30)   segmen
        ,substr(a.tablespace_name,1,7) tablesp
        ,a.extents                     seg
        ,a.bytes/1024/1024             mbytes
        ,a.initial_extent/1024/1024    minit
        ,a.next_extent/1024/1024       mnext
    from sys.dba_segments a
   where a.owner           like upper('&own')
     and a.segment_name    like upper('&tab')
     and a.tablespace_name like upper('&tbs')
     and a.owner       not like upper('sys%')
     and a.extents           >= &ext
     and a.bytes/1024/1024   >= &byt
order by a.bytes desc
/

