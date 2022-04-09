/*
  script:   lst_ddl.sql
  objetivo: indica o ultimo comando ddl feito no objeto
  autor:    Josivan
  data:     
*/

col owner       format a10
col object_mame format a30
col object_type format a15
col data format a20
--
spool le_alt.log
--
  select owner
        ,object_name
        ,object_type
        ,to_char(LAST_DDL_TIME,'DD/MM/YYYYHH24:MI:SS') data
    from dba_objects
   where last_ddl_time > '01-SEP-96'
     and owner not in ('SYS','SYSTEM', 'PUBLIC')
order by LAST_DDL_TIME
/
spool off
