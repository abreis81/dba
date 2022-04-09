COLUMN PROCNAME FORMAT A10
COLUMN PACKAGENAME FORMAT A25
COLUMN ENQ_TID FORMAT A18
set heading off
spool c:\rel_pk.txt
SELECT 'EXECUTE SP_SHOW_CALL_ORIGINAL('||''''||ENQ_TID||''''||','||STEP_NO||')'
       FROM system.def$_aqerror A
WHERE substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30)='TBEDGE_CARTAO$RP';
spool off;
set heading on;
