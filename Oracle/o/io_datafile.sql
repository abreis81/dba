set lines 200
set pagesize 10000
--
col name format a50
col tablespace_name format a15

--
  select c.tablespace_name
        ,name
        ,trunc(c.bytes/1024/1024)     
        ,phyrds          
        ,phywrts          
        ,(phyrds+phywrts)
    from v$datafile a
        ,v$filestat b
        ,dba_data_files c
   where a.file#=b.file#
     and a.file#=c.file_id
order by substr(name,1,23),6 desc,1
/

