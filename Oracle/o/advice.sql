column size_for_estimate  format 999,999,999,999 heading 'Cache Size (m)' 
column buffers_for_estimate   format 999,999,999 heading 'Buffers' 
column estd_physical_read_factor format 999.90 heading 'Estd Phys|Read Factor' 
column estd_physical_reads       format 999,999,999 heading 'Estd Phys| Reads'  

SELECT size_for_estimate
, buffers_for_estimate      
, estd_physical_read_factor
, estd_physical_reads   
FROM V$DB_CACHE_ADVICE  
WHERE name  = 'DEFAULT'    
AND block_size = (SELECT value FROM V$PARAMETER  WHERE name = 'db_block_size')    
AND advice_status = 'ON'; 