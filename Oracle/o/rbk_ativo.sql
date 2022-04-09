select a.username, a.osuser,a.status, a.sid, a.serial#, b.name from
v$session a, v$rollname b, v$transaction c
where a.TADDR = c.ADDR
and   b.USN = c.XIDUSN;