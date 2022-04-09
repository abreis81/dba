set echo off
set long 50000 longc 50000
set pages 1000
set lines 150
col username format a15
col osuser format a15
COL cmd format a50
accept proc Prompt "Digite o PID do processo: "

select a.sid SID, a.serial# SERIAL#, a.USERNAME, osuser, sql_text cmd from v$session a, v$process b, v$sqlarea c
where a.sql_address=c.address and a.paddr=b.addr and b.spid=1076
order by 3,4;