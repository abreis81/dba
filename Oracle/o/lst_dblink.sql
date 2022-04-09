column owner    format a10
column db_link  format a20
column username format a15
column host     format a30
--
select owner
      ,db_link
      ,username
      ,host
  from sys.dba_db_links;
