set pagesize 66
--
column ttmb     format '9990.00'
column itmb     format '9990.00'
--
break on table_name on ttmb on ttbs skip 1
--
  select substr(a.table_name,1,15)     table_name
        ,b.bytes/1024/1024             ttmb
        ,substr(b.tablespace_name,1,7) ttbs
        ,substr(c.index_name,1,15)     index_name
        ,d.bytes/1024/1024             itmb
        ,substr(d.tablespace_name,1,7) itbs
    from sys.dba_tables  a
        ,sys.dba_segments b
        ,sys.dba_indexes c
        ,sys.dba_segments d
   where a.owner      like upper('&own')
     and a.table_name like upper('&tab')
     and b.owner            = a.owner
     and b.segment_name     = a.table_name
     and c.owner        (+) = b.owner
     and c.table_name   (+) = b.segment_name
     and d.owner        (+) = c.owner
     and d.segment_name (+) = c.index_name
order by a.table_name
        ,c.index_name
/
