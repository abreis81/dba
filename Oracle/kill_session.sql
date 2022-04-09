select 'alter system disconnect session '||''''||SID||','||SERIAL#||''''||' immediate;'
from v$session where username = 'PORTAL_ADM';
/




24287


Clear Columns Computes Breaks
set lines 150 pages 30 arrays 30
col log_time    format a20
col sid         format 9999
col username    format a16
col osuser      format a18 
col serial#     format 99999
col spid        format a7
col lockwait    format 9999999
col machine     format a28
col St		format a2
col CX		format a2
select * from (Select  a.sid, a.serial#, 
               substr(to_char(a.logon_time,' dd-mm-yy hh24:mi:ss'),1,20) log_time,
               a.process, a.osuser, a.username, b.spid,
               substr(a.status,1,1) St, a.lockwait, 
			   decode(a.server,'NONE','',substr(a.server,1,2)) CX, a.machine
from    v$session a, v$process b
where   a.paddr = b.addr and
        a.username is not null
) 
order by 8,6,3