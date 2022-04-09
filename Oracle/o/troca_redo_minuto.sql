set pages 1000

alter session set nls_date_format='dd/mm/yyyy hh24';

accept data prompt "Entre com a data(min) formato dd/mm/yyyy HH24: "

select count(*), to_char(first_time,'dd/mm/yyyy hh24:mi') from v$log_history
where TO_CHAR(first_time,'dd/mm/yyyy HH24') = '&&data'
group by to_char(first_time,'dd/mm/yyyy hh24:mi')
/
