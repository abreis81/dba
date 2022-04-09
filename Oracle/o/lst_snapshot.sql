--
set pagesize 66
--
column owner format a5 
column name format a25
column type format a10
column next format a30
column query format a48
--
  select owner
        ,name
        ,type
        ,substr(to_char(last_refresh,'dd/mm/yy hh24:mi:ss'),1,17) last_refresh
        ,substr(to_char(start_with,'dd/mm/yy hh24:mi:ss'),1,17)   start_with
--      ,next
--      ,query
    from sys.dba_snapshots
order by last_refresh;
