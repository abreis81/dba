select -- 'alter system kill session '''||sid||','||s.serial#||''';'
       s.status,
      
       s.logon_time,       s.LAST_CALL_ET,
       p.pga_used_mem, -- p.pga_alloc_mem, p.pga_freeable_mem,p.pga_max_mem,
       P.spid, S.SID,S.SERIAL#, upper(substr(S.OSUSER,1,15)) OSUSER ,
       S.MACHINE MACHINE,
       S.USERNAME NAME,STATUS, 
       S.PROGRAM ,
       P.spid,
       s.logon_time,
       S.SQL_ADDRESS,  S.SQL_HASH_VALUE, s.sql_id,S.*
--        p.pga_used_mem, p.pga_alloc_mem, p.pga_freeable_mem,p.pga_max_mem ,       
from V$SESSION S, V$PROCESS P
where (UPPER(S.PROGRAM) not LIKE 'ORACLE%'  or s.program is null)  And
S.paddr  = P.addr
and STATUS in ('ACTIVE','KILLED') 
--and s.username='SCAM'
--AND S.PROGRAM='recebimento.exe'
-- and upper(s.osuser) like '%F02219%'
--and s.sid=1027
-- aND s.LAST_CALL_ET > 100000 -- 2400
-- order by p.pga_used_mem desc -- s.LAST_CALL_ET
-- s.logon_time 
