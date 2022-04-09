set heading off;
prompt Digite a sid
accept n_sid;
prompt Digite o serial#
accept n_serial;
select a.sql_text from v$sqltext a, v$session b
where a.address=b.sql_address and a.hash_value=b.sql_hash_value
and b.sid=&n_sid and b.serial#=&n_serial
order by piece
/