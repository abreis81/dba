--sys.dbms_system.set_sql_trace_in_session(<SID>,<SERIAL#>,true); 

exec sys.dbms_system.set_sql_trace_in_session(47,13554,true); 

exec sys.dbms_system.set_sql_trace_in_session(47,13554,false); 


set lines 125
col machine for a25
select 	username,
	status,
	sid,
	serial#,
	machine
from	v$session
where	sid=47;