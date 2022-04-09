PROMPT Entre com a sid
accept sid
select a.spid from v$process a, v$session b
where a.addr=b.paddr and b.sid=&sid
/
 