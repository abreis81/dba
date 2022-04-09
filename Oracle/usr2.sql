--alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

/*
set lines 180
set pages 200

col username format a15
col machine format a15
col program format a15
col osuser format a13
*/

select osuser, username 
      ,a.sid
      ,serial# 
      ,program
      ,MACHINE
      ,LOGON_TIME
      ,b.BLOCK_GETS
      ,b.CONSISTENT_GETS 
      ,b.PHYSICAL_READS 
      ,b.BLOCK_CHANGES
	  ,a.status
    ,a.LAST_CALL_ET
from Gv$session a                                                     
, Gv$sess_io b
 where  a.sid=b.sid
     and A.INST_ID = B.INST_ID                                                  
   --and a.status='ACTIVE'
   and a.username is not null	   
   order by a.status                       
/
