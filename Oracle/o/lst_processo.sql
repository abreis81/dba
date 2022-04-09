--
set verify on;
--
select s.username
      ,s.osuser
      ,p.program
      ,s.program
      ,p.spid 
      ,p.terminal
      ,p.background 
  from v$session s
      ,v$process p 
 where s.sid(+) = p.pid
   and p.spid   = &1
/

