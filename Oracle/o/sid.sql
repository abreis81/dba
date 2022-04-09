alter session set nls_date_format='dd/mm/yyyy hh24:mi';

select sid, a.username, osuser, module, logon_time from v$session a, v$process b where a.paddr=b.addr
and b.spid=&pid;