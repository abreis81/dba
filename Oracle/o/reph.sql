set pagesize 9999
compute sum of Qtd on report
break on report

Select to_char(enq_time,'DD/MON HH24') as Hora, count(*) as Qtd
  from   system.def$_Aqcall
  group  by to_char(enq_time,'DD/MON HH24')
  order  by Hora desc
/
