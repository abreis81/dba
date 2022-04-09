set verify off
set pages 0
--
accept user prompt "Username [%]: "
--
select a.username
      ,sid
      ,b.sql_text
 from v$session a
     ,v$sqltext_with_newlines b
where a.sql_address=b.address
  and lower(a.osuser) = like nvl(upper('&user'||'%'),'%') 
/
