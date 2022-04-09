set lines 200
set pages 1000
col what format a40

alter session set nls_date_format='dd/mm/yyyy hh24:mi';

select job, what, broken, failures, last_date, next_date from USER_jobs;