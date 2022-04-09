set lines 180
set pages 2000

select count(*) as quantidade, username, machine, s.sid 
from v$open_cursor o, v$session s 
where o.sid=s.sid 
group by username, machine, s.sid 
order by 1 desc
;