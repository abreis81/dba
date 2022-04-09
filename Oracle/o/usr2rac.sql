alter session set nls_date_format='DD/MM/YY HH24:MI';

SET PAGES 150
set lines 200
COL SQL_TEXT FORMAT A60
COL OSUSER FORMAT A20
col sid format 9999
col program format a20
set lines 250
select osuser
      ,a.username
      ,a.INST_ID	
      ,a.sid
      ,serial# 
      ,status
      ,LOGON_TIME
      ,d.db_block_gets
      ,e.Consistent_gets 
      ,f.physical_reads  
      ,g.db_block_changes
      ,h.physical_writes 
from gv$session a                                                     
, (select inst_id, sid, value db_block_gets from gv$sesstat where statistic#=38) d
, (select inst_id, sid, value Consistent_gets from gv$sesstat where statistic#=39) e
, (select inst_id, sid, value physical_reads   from gv$sesstat where statistic#=40) f
, (select inst_id, sid, value db_block_changes from gv$sesstat where statistic#=41) g
, (select inst_id, sid, value physical_writes  from gv$sesstat where statistic#=44) h
 where status='ACTIVE'
   and d.INST_ID = a.INST_ID	
   and d.sid=a.sid
   and e.INST_ID = a.INST_ID
   and e.sid=a.sid
   and f.INST_ID = a.INST_ID
   and f.sid=a.sid
   and g.INST_ID = a.INST_ID
   and g.sid=a.sid
   and h.INST_ID = a.INST_ID
   and h.sid=a.sid 
   and a.username is not null                                
/          
                             