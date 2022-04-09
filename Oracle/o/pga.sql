set lines 250
set pages 2000
col name format a40
compute sum of value on report
break on report

select name, sid, value
from v$sesstat a, v$statname b
where a.statistic#=b.statistic#
and a.statistic# = 20
/

select sum(bytes)/1024/1024 Mb from
      (select bytes from v$sgastat
        union
        select value bytes from
             v$sesstat s,
             v$statname n
        where
             n.STATISTIC# = s.STATISTIC# and
             n.name = 'session pga memory'
       );
       
SELECT 
name, 
decode(unit, 'bytes', trunc(value/1024/1024), value) value , 
decode(unit, 'bytes', 'MBytes', unit) unit 
FROM V$PGASTAT; 

