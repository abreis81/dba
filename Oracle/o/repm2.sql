set pages 10000;
compute sum of qtde on report;
break on report;
select /* +parallel(system.def$_Aqcall,10)*/ to_char(enq_time,'DD/MM HH24:mi'), count(*) qtde
from system.def$_Aqcall
group by to_char(enq_time,'DD/MM HH24:mi')
order by 1 desc
/
