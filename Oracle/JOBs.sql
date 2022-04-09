--#####################################################################################
--Consulta JOB's

set lines 160
col what for a55
col interval for a25
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
SELECT	job,
	what,
	last_date,
	next_date,
	interval,
	broken
FROM	dba_jobs;

--#####################################################################################
--Alterando a próxima data execução do JOB 343
           
exec dbms_job.next_date(343,to_date('28/10/2007 02:00:00','DD/MM/YYYY HH24:MI:SS'));

--#####################################################################################
--Alterando o intervalo de execução do JOB 343

exec dbms_job.interval(343,'TRUNC(SYSDATE + 7) + 2/24');