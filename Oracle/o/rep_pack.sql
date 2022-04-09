set pages 10000
select count(1), packagename, procname from defcall
group by packagename, procname
/
