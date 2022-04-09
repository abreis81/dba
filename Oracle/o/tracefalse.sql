def sid=&1
def serial=&2
exec sys.dbms_system.set_sql_trace_in_session(&sid,&serial,false);
