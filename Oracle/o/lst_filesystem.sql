set pagesize 90
--
break on tot on tablespace_name
--
column tablespace_name format a10
column data_file format a40
column file_system format a12
column mbytes format '999,990.00'
compute sum on tot of mbytes
--
 select 'tot' tot
        ,tablespace_name
        ,substr(file_name,1,40) data_file
        ,bytes/1024/1024 mbytes
        ,substr(file_name,1,instr(file_name,'/',2)) file_system
    from sys.dba_data_files
order by 2,substr(file_name,instr(file_name,'/',-1),length(file_name))
/
