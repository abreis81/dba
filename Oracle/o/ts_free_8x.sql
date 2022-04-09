/*
  SCRIPT:   TS_FREE.SQL
  OBJETIVO: LISTA OS TABLESPACE E O ESPACO DISPONIVEL
  AUTOR:    JOSIVAN
  DATA:     
*/
--
clear screen
--
col a format 9,999.99 heading "Tam|Mbytes" 
col b format 9,999.99 heading "Utilizado|Mbytes" 
col c format 9,999.99 heading "Livre|Mbytes" 
col d format 9,999.99 heading "%|Livre"
--
select a.tablespace_name
      ,(a.bytes/1024/1024) a 
      ,(b.bytes/1024/1024) b
      ,(c.bytes/1024/1024) c
      ,abs(1-(c.bytes/a.bytes)*100) d
  from sys.sm$ts_avail a
      ,sys.sm$ts_used b
      ,sys.sm$ts_free c
 where a.tablespace_name = b.tablespace_name(+)
   and a.tablespace_name = c.tablespace_name(+)
/

