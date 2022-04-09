SET PAGES 150
SET LONG 500000
COL SQL_TEXT FORMAT A60
COL OSUSER FORMAT A20
col machine format a15
undef sqlid 
col sqlid new_value sqlid
accept sd prompt "Digite a SID: "

set lines 200
select osuser, a.sid, c.total cursors ,status, machine,a.lockwait, ROWS_PROCESSED, b.sql_text from v$session a
, v$sqlarea b                                                       
, (select sid, count(1) total from v$open_cursor group by sid) c    
 where a.sql_address=b.address                                      
   and a.sid=c.sid
   and a.sid=&&sd                                                  	                                            
/                                                             
