set pages 100
--
select bytes/1024/1024 mbytes
  from sys.dba_free_space
 where tablespace_name like upper ('&tbs')
   and bytes/1024/1024>=1
/
