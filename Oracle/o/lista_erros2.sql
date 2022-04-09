COLUMN PROCNAME FORMAT A10
COLUMN PACKAGENAME FORMAT A25
set linesize 1000
select count(1),
       substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30) packagename,
       substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30) procname
       FROM system.def$_aqerror A
	where to_char(enq_time,'dd/mm/yyyy hh24:mi:ss') > '03/12/2001 10:00:00' 
group by substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30),
substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30)
/