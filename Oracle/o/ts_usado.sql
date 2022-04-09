set lines 1000
set pages 1000

create table percent as
  select a.tablespace_name
        ,(a.bytes/1024/1024) a
        ,(b.bytes/1024/1024) b
        ,(c.bytes/1024/1024) c
        ,round((c.bytes/a.bytes)*100) d
    from sys.sm$ts_avail a
        ,sys.sm$ts_used b
        ,sys.sm$ts_free c
   where a.tablespace_name = b.tablespace_name(+)
     and a.tablespace_name = c.tablespace_name(+)
/
--
break on report
--
compute sum of a b c on report
--
col tablespace_name format a35
col a format 999,999.99 heading "Tam|Mbytes"
col b format 999,999.99 heading "Utilizado|Mbytes"
col c format 99,999.99 heading "Livre|Mbytes"
col d format 999.99    heading "%|Livre"
--
ttitle center "Relatorio da Situacao dos Tablespaces" skip 2
--
select tablespace_name
      ,a
      ,b
      ,c
      ,d
      ,decode(d,20,'WARNING'
               ,19,'WARNING'
               ,18,'WARNING'
               ,17,'WARNING'
               ,16,'WARNING'
               ,15,'WARNING'
               ,14,'WARNING'
               ,13,'WARNING'
               ,12,'WARNING'
               ,11,'WARNING'
               ,10,'ALERT'
               , 9,'ALERT'
               , 8,'ALERT'
               , 7,'ALERT'
               , 6,'ALERT'
               , 5,'DANGER' 
               , 4,'DANGER'
               , 3,'DANGER'
               , 2,'DANGER'
               , 1,'DANGER') status
  from percent
/

drop table percent;
