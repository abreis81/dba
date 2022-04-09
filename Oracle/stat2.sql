select /*+ rule */ c.username
     , c.osuser
     , lpad(to_char(c.sid),3) as sid
     , lpad(to_char(c.serial#),6) as serial
     , lpad(p.spid,5) as pid
     , lpad(to_char(sum(decode(s.statistic#, 120, s.value))),8) execute_count
     , lpad(to_char(sum(decode(s.statistic#, 119, s.value))),5) parse_count
     , to_char(sum(decode(s.statistic#, 118, s.value)),'99990') parse_elapsed
     , to_char(sum(decode(s.statistic#,  12, trunc(s.value/100))),'999990') cpu_used
     , to_char(sum(decode(s.statistic#,   8, trunc(s.value/100))),'999990') recursive_cpu_usage
     , round(sum(decode(s.statistic#,  39, s.value))/1000) physical_reads
     , round(sum(decode(s.statistic#,   9, s.value))/1000) logical_reads
     , c.machine
from  v$process p, v$sesstat s, v$session c
where   s.statistic# in (3,8,9,12,39,118,119,120)
and   p.addr = c.paddr
and   c.sid = s.sid
--and   c.sid = &&LOJA
group by c.username, c.osuser, c.machine, c.sid, c.serial#, p.spid,c.program, c.module
order by c.osuser, c.username;
