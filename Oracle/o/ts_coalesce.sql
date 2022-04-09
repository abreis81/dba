/*
  script:   ts_coalesce.sql
  objetivo: pegar os blocos contiguos fragmentados e criar extents maiores
  autor:    Josivan
  data:     
*/

set pages 0
--
select 'alter tablespace '||tablespace_name||' coalesce;'
  from dba_tablespaces
/

rem set pages 24
rem @coalesce.lis
rem !rm coalesce.lis

