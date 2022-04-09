undef sid
set pages 1000
COL WAIT_CLASS FORMAT A20
ACCEPT SID PROMPT "Digite o SID: "

select * from
v$session_wait_class
where sid=&&sid
order by time_waited
/

Prompt "Ultimos eventos de wait"

SELECT sid,seq#,event
FROM v$session_wait_history
WHERE sid =&&sid
/