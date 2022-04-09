select /*+ index_ffs(A,SYS_C001626) */ count(A.ENQ_TID) from system.def$_aqcall A (STA01P)
/

Select to_char(enq_time,'DD/MON HH24') as Hora, count(*) as Qtd
  from   system.def$_Aqcall
  group  by to_char(enq_time,'DD/MON HH24')
  order  by Hora
/
select A.Sid, B.Serial#,B.Username, B.Status, C.SPID
 from  dba_jobs_running A,
       v$session        B,
       v$process        C
 where A.sid = B.sid
   and B.paddr = C.addr
 ;