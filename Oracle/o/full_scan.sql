 set pages 10000
 
 prompt Full Table scans:          
 select  sql_text from v$sqltext t, (select distinct hash_value from v$sql_plan p          
 where p.operation='TABLE ACCESS'            
 and p.options='FULL') a
where t.hash_value=a.hash_value          
 order by t.hash_value, t.piece;     
 
 prompt Fast Full Index scans:          
select  sql_text from v$sqltext t, (select distinct hash_value from v$sql_plan p          
 where p.operation='INDEX'            
 and p.options='FULL') a
where t.hash_value=a.hash_value          
 order by t.hash_value, t.piece;