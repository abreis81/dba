/*

  rbk_sessao.sql
  josivan

*/

select s.sid
      ,s.serial#
      ,t.start_time
      ,t.xidusn
      ,s.username
  from v$session s
      ,v$transaction t
      ,v$rollstat r
 where s.saddr = t.ses_addr
   and t.xidusn = r.usn
   and ((r.curext = t.start_uext-1) or ((r.curext = r.extends-1) and t.start_uext=0))
/


