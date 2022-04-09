-- Run this script in SQL*Plus.

-- don't print headers or other crap
set heading off;
set echo off;
set pagesize 0;      

-- don't truncate the line output
-- trim the extra space from linesize when spooling
set long 99999;      
set linesize 32767;  
set trimspool on;    

-- don't truncate this specific column's output
col object_ddl format A62000;

SELECT dbms_metadata.get_ddl(object_type, object_name, owner) || ';' AS object_ddl
from dba_objects
where owner in 
(
'ATT'--,'AMADEUS','SCAM','INT','INT_4819','CARGA_NL','INT_BEN','INT_REAL','OWN_ATTAMD','SYS_ATTAMD'
)
and object_type='FUNCTION'
and object_name not in( 
select object_name
from dba_objects@tisstst.world
where owner in 
(
'ATT'--,'AMADEUS','SCAM','INT','INT_4819','CARGA_NL','INT_BEN','INT_REAL','OWN_ATTAMD','SYS_ATTAMD'
)
and object_type='FUNCTION'
);

spool off;