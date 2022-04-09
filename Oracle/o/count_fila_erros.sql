OSASCO: 21/06/2001 11:00HS

SELECT COUNT(1),
            substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30) packagename,
            substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30) procname
       FROM system.def$_aqerror A
       GROUP BY substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30),
            substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30)
/
 

COUNT(1) PACKAGENAME                    PROCNAME
--------- ------------------------------ -----------------
        9 TBBRAD_ANIVERSAR$RP            REP_INSERT
      158 TBBRAD_COD_BOLTMP$RP           REP_UPDATE
        1 TBBRAD_LOG_VENDA$RP            REP_INSERT
        9 TBBRAD_PCOM_TMP$RP             REP_UPDATE
        1 TBEDGE_BINA_CLI$RP             REP_UPDATE
       82 TBEDGE_BLQ_ACAD$RP             REP_DELETE
        2 TBEDGE_BLQ_ACAD$RP             REP_INSERT
        3 TBEDGE_CAMPANHA_S$RP           REP_UPDATE
        8 TBEDGE_CLIENTE$RP              REP_INSERT
        3 TBEDGE_COMENTARIO$RP           REP_INSERT
        6 TBEDGE_COMP_CSUM$RP            REP_DELETE
      984 TBEDGE_COMP_CSUM$RP            REP_INSERT
      841 TBEDGE_COMP_CSUM$RP            REP_UPDATE
        2 TBEDGE_COMP_IPTS$RP            REP_DELETE
     1024 TBEDGE_COMP_TRAN$RP            REP_DELETE
     4690 TBEDGE_COMP_TRAN$RP            REP_INSERT
       32 TBEDGE_DADOS_CLI$RP            REP_INSERT
        3 TBEDGE_DADOS_CLI$RP            REP_UPDATE
        2 TBEDGE_DTLIMCHESP$RP           REP_DELETE
        7 TBEDGE_GC_CADCAMP$RP           REP_UPDATE
       53 TBEDGE_GC_FILACAMP$RP          REP_DELETE
     1312 TBEDGE_GC_FILACAMP$RP          REP_UPDATE
      356 TBEDGE_GRAV_ESTAT$RP           REP_INSERT
       16 TBEDGE_HISTORIC$RP             REP_INSERT
       59 TBEDGE_IDPOS$RP                REP_DELETE
        1 TBEDGE_ID_PERSO$RP             REP_DELETE
        1 TBEDGE_ID_PERSO$RP             REP_UPDATE
        1 TBEDGE_OCORCONC$RP             REP_INSERT
        2 TBEDGE_OCORPEND00$RP           REP_DELETE
      141 TBEDGE_OCORPEND00$RP           REP_UPDATE
        4 TBEDGE_PARAMETER$RP            REP_UPDATE
      221 TBEDGE_PRODUTO_ASSO$RP         REP_INSERT
       20 TBEDGE_TELEMRKT$RP             REP_INSERT
        1 TBEDGE_TELEMRKT$RP             REP_UPDATE
     1612 TBEDGE_TRANSACAO$RP            REP_DELETE
     1612 TBEDGE_TRANSACAO$RP            REP_INSERT