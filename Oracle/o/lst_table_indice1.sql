set pagesize 900
--
column num format '9999999'
column dis format '9999999'
column perc format '990.0'
--
break on owner skip 1 on table_name skip 1
--
  select substr(a.owner,1,5)       owner
        ,substr(a.table_name,1,20) table_name
        ,substr(b.index_name,1,20) index_name
        ,substr(b.uniqueness,1,3)  type
        ,substr(b.status,1,3)      sta
        ,a.num_rows                num
        ,b.distinct_keys           dis
        ,b.distinct_keys/decode(a.num_rows,0,1,a.num_rows)*100 perc 
    from sys.dba_tables a
        ,sys.dba_indexes b
   where a.owner not like 'SYS%'
     and a.owner='&own'
     and b.owner=a.owner
     and b.table_name=a.table_name
order by 1, 8, 6 desc
/
