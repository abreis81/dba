echo "
set lines 150
set pages 0
set heading off
set feedback off
col name for a100
select  '!rm -f '||name name
from    v\$archived_log
where   trunc(COMPLETION_TIME,'DD') < sysdate -2;" | sqlplus -S internal | sqlplus -S internal