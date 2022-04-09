--########################################################################
-- Com o spid já retorna a query
--########################################################################
select   a.sid, 
  a.serial#, 
  a.username, 
  b.spid,
  c.sql_text
from   v$session a, 
  v$process b, 
  v$sqltext c  
where   a.paddr = b.addr
and a.sql_address = c.address
and   spid=22223;

--###############################################################
--Verificar sessão : 
--###############################################################
select 	a.sid, 
	a.serial#, 
	a.username, 
	b.spid, 
  a.MACHINE,
  a.OSUSER,
  a.LAST_CALL_ET,
  a.PROGRAM
from 	v$session a, 
	v$process b  
where 	a.paddr = b.addr
and 	spid=29119;
 
--###############################################################
--Verificar SQL ativo da sessão :
--###############################################################

select 	sql_text 
from 	v$session a, 
	v$sqltext b
where 	a.sql_address = b.address
and 	a.sid = 2182
order by piece;

--###############################################################
--
--###############################################################

select 	sql_text 
from 	v$session a, 
	v$sqltext b
where 	a.sql_address = b.address
and 	a.sid = &s
order by piece;

--###############################################################

set lines 150
select 	s.username,
	s.logon_time,
	s.status,
	p.spid,
	b.sql_text
from 	v$session s,
	v$process p,
	v$sqltext b
where 	s.paddr=p.addr
and	s.sql_address = b.address
and	s.process='2128'
--and 	p.spid=4333782
order by piece;
 


select distinct sid 
       ,pid 
       ,spid 
       ,a.program 
       ,a.machine
       ,a.logon_time
       ,a.username
       ,a.status
from v$session a, v$process b 
where a.serial#=b.serial#
			and a.program <> 'ORACLE.EXE'
order by spid;
