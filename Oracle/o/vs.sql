@@init
set recsep off ver off feed off
set lines 100 pages 40
col sid                 format a3        heading 'SID'
col serial              format a6        heading 'SERIAL'
col pid                 format a5        heading 'PID'
col osuser              format a8        wra
col username            format a10       wra
col execute_count       format a8        heading 'EXEC.|COUNT'          jus l
col parse_count         format a5        heading 'PARSE|COUNT'          jus l
col opened_cursors      format a4        heading 'OPEN|CURS'            jus l
col parse_elapsed       format a6        heading '(Seg)|PARSE|ELAPSE'   jus l
col cpu_used            format a5        heading '(Seg)|CPU|USED'       jus l
col recursive_cpu_usage format a5        heading '(Seg)|CPU|RECUR'      jus l
col physical_reads      format 999990    heading '(Mil)|READS|PHYSIC'   jus l
col logical_reads       format 999990    heading '(Mil)|READS|LOGIC'    jus l
col data new_value data noprint
col hora new_value hora noprint
set term on pause on
select /*+ rule */ c.username
     , c.osuser
     , lpad(to_char(c.sid),3) as sid
     , lpad(to_char(c.serial#),6) as serial
     , lpad(p.spid,5) as pid
     , lpad(to_char(sum(decode(s.statistic#, 120, s.value))),8) execute_count
     , lpad(to_char(sum(decode(s.statistic#, 119, s.value))),5) parse_count
     , to_char(sum(decode(s.statistic#, 118, s.value)),'99990') parse_elapsed
     , to_char(sum(decode(s.statistic#,  12, trunc(s.value/100))),'9990') cpu_used
     , to_char(sum(decode(s.statistic#,   8, trunc(s.value/100))),'9990') recursive_cpu_usage
     , round(sum(decode(s.statistic#,  39, s.value))/1000) physical_reads
     , round(sum(decode(s.statistic#,   9, s.value))/1000) logical_reads
from  v$process p, v$sesstat s, v$session c
where c.username is not null
and   s.statistic# in (3,8,9,12,39,118,119,120)
and   p.addr = c.paddr
and   c.sid = s.sid
group by c.username, c.osuser, c.sid, c.serial#, p.spid
order by c.osuser, c.username
/
@@init
