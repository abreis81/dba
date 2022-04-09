COLUMN PROCNAME FORMAT A10
COLUMN PACKAGENAME FORMAT A21
COLUMN ENQ_TID FORMAT A22
SELECT TO_CHAR(a.ENQ_TIME,'DD/MM/YYYY HH24:MI:SS') "DATA_HORA_TRANSACAO",
       a.STEP_NO,                 
       a.ENQ_TID,
       substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30) packagename,
       substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30) procname,
       substr(b.error_msg,1,15)
       FROM system.def$_aqerror A,
	    system.def$_error b
WHERE substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30)='TBEDGE_GC_FILACAMP$RP'
AND a.enq_tid=b.enq_tid
and TO_CHAR(a.ENQ_TIME,'DD/MM/YYYY HH24:MI:SS') > '27/08/2001 11:00:00'
/


