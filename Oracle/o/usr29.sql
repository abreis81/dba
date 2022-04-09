alter session set nls_date_format='DD/MM/YY HH24:MI';

SET PAGES 150
set lines 300
COL SQL_TEXT FORMAT A60
COL OSUSER FORMAT A20
col sid format 9999
col program format a10
set lines 250
select osuser
      ,a.sid
      ,serial# 
      ,substr(program,1,10) program
      ,SUBSTR(MACHINE,1,15) MACHINE
      ,LOGON_TIME
      ,d.db_block_gets
      ,e.Consistent_gets 
      ,f.physical_reads  
      ,g.db_block_changes
      ,h.physical_writes 
from v$session a                                                     
, (select sid, count(1) total from v$open_cursor group by sid) c
, (select sid, value db_block_gets from v$sesstat where statistic#=40) d
, (select sid, value Consistent_gets from v$sesstat where statistic#=41) e
, (select sid, value physical_reads   from v$sesstat where statistic#=42) f
, (select sid, value db_block_changes from v$sesstat where statistic#=43) g
, (select sid, value physical_writes  from v$sesstat where statistic#=46) h
 where  a.sid=c.sid                                                  
   and status='ACTIVE'	
   and d.sid=a.sid
   and e.sid=a.sid
   and f.sid=a.sid
   and g.sid=a.sid
   and h.sid=a.sid 
   and a.username is not null                                
/          
                             