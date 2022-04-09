-- PARA PEGAR O SERVICE NAME E  MODULE.
SELECT sid, serial#,username, client_identifier, service_name, action, module, osuser, machine
FROM V$SESSION
where machine not like 'preprod'

----
EXEC DBMS_MONITOR.serv_mod_act_trace_enable(service_name=>'SYS$USERS', module_name=>'dllhost.exe');

EXEC DBMS_MONITOR.serv_mod_act_trace_DISABLE(service_name=>'SYS$USERS', module_name=>'dllhost.exe');

---
