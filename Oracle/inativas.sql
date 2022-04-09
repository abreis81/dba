---- Sessoes olhar inatividade

Select p.spid, p.addr, s.sid, s.serial#, s.username, s.osuser, s.status, s.server, s.logon_time, 
s.sql_hash_value, TO_CHAR (s.last_call_et / 3600, '009.99') inatividade, s.last_call_et,
s.machine, s.program, p.pga_used_mem, p.pga_alloc_mem, p.pga_freeable_mem, pga_max_mem, sql.sql_text
From v$session s, v$process p, v$sql sql
Where s.username is not null
And s.paddr = p.addr (+)
And s.sql_address = sql.address
Order by s.last_call_et desc

--- pegar query

Select sql.address, sql.sql_text, sql.sharable_mem, sql.persistent_mem, sql.sorts, sql.parse_calls, 
sql.fetches, sql.executions, sql.loads, sql.disk_reads, sql.buffer_gets, sql.hash_value, sql.plan_hash_value, 
sql.cpu_time, sql.elapsed_time, sql.last_load_time, p.pga_used_mem, p.pga_alloc_mem, s.username, s.osuser, 
p.pid, s.serial#, s.server, s.status
From v$process p, v$session s, v$sql sql
Where p.spid = (22416)
And s.paddr = p.addr (+)
And s.sql_address = sql.address (+)


---tipo de operação
Select p.hash_value, operation, options, object_name name, trunc (bytes / 1048576) "input(MB)", trunc(last_memory_used / 1024) last_mem, 
trunc(estimated_optimal_size/1024) opt_mem, trunc (estimated_onepass_size/1024) onepass_mem, decode(optimal_executions, null, '-', 
optimal_executions || '/' || onepass_executions || '/' || multipasses_executions) "O/1/M"
From v$sql_plan p, v$sql_workarea w
Where p.address = w.address (+)
And p.hash_value = w.hash_value (+)
And p.id = w.operation_id (+)
And p.address = '00000003F710ACF8'

-- query completa
Select sql_text from v$sqltext where address = '00000003EF4DA5C0' order by piece
