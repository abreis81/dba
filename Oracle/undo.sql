-- Verificando se existem objectos dentro do TableSpace de UNDO
select v$session.username
      ,substr(v$session.sid,1,8) sid
      ,to_char(spid) spid
      ,to_char(v$session.process) process
      ,substr(r.usn,1,6) usn
      ,substr(nvl(v$session.program,v$session.machine),1,20) program
      ,to_char(v$transaction.used_ublk*8192/1024/1024) used
      ,substr(v$session_wait.event,1,18) EVENTO
      ,round(v$session_wait.seconds_in_wait/(60*60),2) hr
      ,r.status
      ,v$transaction.start_time
from
   v$session,
   v$transaction,
   v$rollstat r,
   v$session_wait,
   v$process
where
   saddr=ses_addr and
   xidusn=r.usn and
   v$session.sid=v$session_wait.sid and
   v$session.paddr=v$process.addr
   --and to_date(start_time,'mm/dd/yy hh24:mi:ss')
;




SELECT S.USERNAME, T.XIDUSN, T.UBAFIL, T.UBABLK, T.USED_UBLK,
RN.NAME AS "SEGMENT", RS.STATUS, RS.EXTENTS, RS.RSSIZE,
RS.HWMSIZE, RS.XACTS, DF.STATUS AS "FILE STATUS",
DF.NAME AS "FILE", TS.NAME AS "TABLESPACE"
FROM V$SESSION S, V$TRANSACTION T, V$ROLLNAME RN, V$ROLLSTAT RS,V$DATAFILE DF, V$TABLESPACE TS
WHERE S.SADDR = T.SES_ADDR
AND T.XIDUSN = RN.USN
AND RN.USN = RS.USN
AND T.UBAFIL = DF.FILE#
AND TS.TS# = DF.TS#;
