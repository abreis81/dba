set linesize 160
set pagesize 66
col c1 for a15
col c1 heading "OS User"
col c2 for a16
col c2 heading "Oracle User"
col b1 for a10
col b1 heading "Unix PID"
col b2 for 9999 justify left
col b2 heading "ORA SID"
col b3 for 999999 justify left
col b3 heading "SERIAL#"
col sql_text for a65
col logon_time format a20
set space 1
break on b1 nodup on c1 nodup on c2 nodup on b2 nodup on b3 skip 3
  select c.spid b1, b.osuser c1, b.username c2, b.sid b2,
  b.serial# b3, a.sql_text,b.status
  --,to_char(b.logon_time, 'DD-MON-YYYY HH24:MI:SS') logon_time
    from v$sqltext a, v$session b, v$process c
     where a.address    = b.sql_address
     and b.status     = 'ACTIVE'
     and b.paddr      = c.addr
     and a.hash_value = b.sql_hash_value
     and b.username is not null
order by c.spid,a.hash_value,a.piece
/
