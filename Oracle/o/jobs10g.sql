set pages 5000
col job_name format a30
set lines 200
COL STATUS FORMAT A10
aCCEPT job prompt "Nome do Job: "

select owner, job_name, status, 
to_char(log_date, 'DD-MON-YYYY HH24:MI') log_date, run_duration 
from dba_scheduler_job_run_details
where trunc(log_date)>=trunc(sysdate)-1
and job_name like upper(nvl('&job','%'))
order by 2 desc ,4;
