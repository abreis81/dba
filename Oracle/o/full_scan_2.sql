prompt Full table scan feitas por alguma sessao aberta: 

select  sid, username, osuser, p.object_name from v$session t, v$sql_plan p          
 where t.SQL_HASH_VALUE=p.hash_value and p.operation='TABLE ACCESS'            
 and p.options='FULL';
