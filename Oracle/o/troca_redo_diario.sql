set pages 1000

alter session set nls_date_format='dd/mm/yyyy';

accept data prompt "Entre com a data(min) formato dd/mm/yyyy: "

select count(*), to_char(first_time,'dd/mm/yyyy') from v$log_history
where trunc(first_time) >= '&&data'
group by to_char(first_time,'dd/mm/yyyy')
/
