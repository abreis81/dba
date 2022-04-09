rem
rem Rollback shrink
rem
rem Biju Thomas
rem
rem 
set feedback off pages 0 lines 80 echo off trims on
spool c:\tmp\rbshrink.sql
select 'alter rollback segment '|| SEGMENT_NAME || ' shrink;'
from   dba_rollback_segs
where  status = 'ONLINE' and SEGMENT_NAME<>'SYSTEM'
/
spool off
set feedback on pages 24 echo on
@c:\tmp\rbshrink.sql
clear columns
set feedback on pages 24 echo off
prompt 

