alter system set timed_statistics = true;
def sid=&1
def serial=&2
exec SYS.dbms_system.set_sql_trace_in_session(&sid,&serial,true);

