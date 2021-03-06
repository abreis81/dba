alter session set nls_date_format='DD/MM/YY HH24:MI';

SET PAGES 150
set lines 300
COL SQL_TEXT FORMAT A60
COL usuario FORMAT A25
col sid format 9999
col program format a10
COL MACHINE FORMAT A15
set lines 250
select osuser||' '||username usuario
      ,a.sid
      ,serial# 
      ,substr(program,1,10) program
      ,SUBSTR(MACHINE,1,15) MACHINE
      ,LOGON_TIME
      ,b.BLOCK_GETS
      ,b.CONSISTENT_GETS 
      ,b.PHYSICAL_READS 
      ,b.BLOCK_CHANGES
	  ,a.status
from v$session a                                                     
, v$sess_io b
 where  a.sid=b.sid                                                  
   --and a.status='ACTIVE'
   and a.username is not null	   
   order by a.status                       
/