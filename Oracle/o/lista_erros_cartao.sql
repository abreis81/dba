COLUMN PROCNAME FORMAT A10
COLUMN PACKAGENAME FORMAT A20
COLUMN ENQ_TID FORMAT A22
SELECT TO_CHAR(a.ENQ_TIME,'DD/MM/YYYY HH24:MI:SS') "DATA_HORA_TRANSACAO",
       a.enq_tid,
       substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30) packagename,
       substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30) procname,
       substr(b.error_msg,1,30) Erro
       FROM system.def$_aqerror A,
	    system.def$_error B
WHERE substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30)='TBEDGE_CARTAO$RP' and
      a.enq_tid=b.enq_tid and a.step_no=b.step_no;