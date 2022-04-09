CREATE OR REPLACE TRIGGER "SIGA".TRG_SE1010_SEUADA_I_U BEFORE
INSERT
OR UPDATE ON "SIGA"."SE1010" REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW DECLARE

    IDEMPRESA NUMBER;
    NUMRA VARCHAR2(15);
    NREG INTEGER;
    AUX NUMBER := 0;

BEGIN
		SELECT COUNT(1) INTO AUX FROM SEUTESTE.SEUAET
         WHERE SAET_NUMRA = TRIM(:NEW.E1_NUMRA);
    IF AUX > 0 THEN
		-- CASO O REGISTRO AINDA SEJA ATIVO
        IF UPDATING AND :NEW.D_E_L_E_T_ = ' ' AND :OLD.D_E_L_E_T_ = :NEW.D_E_L_E_T_ THEN
      -- CONSULTA AS INFORMAÇÕES EMPRESA / RA / NREG
            SELECT SADA_IDEMPRESA, SADA_NUMRA, SADA_NREG 
        INTO IDEMPRESA, NUMRA, NREG
          FROM SEUTESTE.SEUADA
         WHERE SADA_NREG = :OLD.R_E_C_N_O_
           AND SADA_NUMRA = TRIM(:NEW.E1_NUMRA);
      -- EXECUTA O UPDATE DAS INFORMAÇÕES
        UPDATE SEUTESTE.SEUADA 
         SET SADA_PREFIXO   = TRIM(NVL(:NEW.E1_PREFIXO    ,:OLD.E1_PREFIXO     ))
            ,SADA_NUM       = TRIM(NVL(:NEW.E1_NUM              ,:OLD.E1_NUM             ))
            ,SADA_PARCELA   = TRIM(NVL(:NEW.E1_PARCELA    ,:OLD.E1_PARCELA     ))
            ,SADA_TIPO      = TRIM(NVL(:NEW.E1_TIPO           ,:OLD.E1_TIPO            ))
            ,SADA_NATUREZA  = TRIM(NVL(:NEW.E1_NATUREZ    ,:OLD.E1_NATUREZ     ))
            ,SADA_PORTADO   = TRIM(NVL(:NEW.E1_PORTADO    ,:OLD.E1_PORTADO     ))
            ,SADA_AGEDEP    = TRIM(NVL(:NEW.E1_AGEDEP     ,:OLD.E1_AGEDEP      ))
            ,SADA_NUMRA     = TRIM(NVL(TRIM(:NEW.E1_NUMRA),TRIM(:OLD.E1_NUMRA) ))
            ,SADA_LOJA      = TRIM(NVL(:NEW.E1_LOJA           ,:OLD.E1_LOJA            ))
            ,SADA_NOMCLI    = TRIM(NVL(:NEW.E1_NOMCLI     ,:OLD.E1_NOMCLI      ))
            ,SADA_CC        = TRIM(NVL(:NEW.E1_CC             ,:OLD.E1_CC              ))
            ,SADA_EMISSAO   = TRIM(NVL(:NEW.E1_EMISSAO    ,:OLD.E1_EMISSAO     ))
            ,SADA_VENCTO    = TRIM(NVL(:NEW.E1_VENCTO     ,:OLD.E1_VENCTO      ))
            ,SADA_VENCREA   = TRIM(NVL(:NEW.E1_VENCREA    ,:OLD.E1_VENCREA     ))
            ,SADA_VALOR     = TRIM(NVL(:NEW.E1_VALOR        ,:OLD.E1_VALOR           ))
            ,SADA_IRRF      = TRIM(NVL(:NEW.E1_IRRF           ,:OLD.E1_IRRF            ))
            ,SADA_ISS       = TRIM(NVL(:NEW.E1_ISS              ,:OLD.E1_ISS             ))
            ,SADA_NUMBCO    = TRIM(NVL(:NEW.E1_NUMBCO     ,:OLD.E1_NUMBCO      ))
            ,SADA_INDICE    = TRIM(NVL(:NEW.E1_INDICE     ,:OLD.E1_INDICE      ))
            ,SADA_BAIXA     = TRIM(NVL(:NEW.E1_BAIXA        ,:OLD.E1_BAIXA           ))
            ,SADA_NUMBOR    = TRIM(NVL(:NEW.E1_NUMBOR     ,:OLD.E1_NUMBOR      ))
            ,SADA_DATABOR   = TRIM(NVL(:NEW.E1_DATABOR    ,:OLD.E1_DATABOR     ))
            ,SADA_EMIS1     = TRIM(NVL(:NEW.E1_EMIS1        ,:OLD.E1_EMIS1           ))
            ,SADA_HIST      = TRIM(NVL(:NEW.E1_HIST           ,:OLD.E1_HIST            ))
            ,SADA_LA        = TRIM(NVL(:NEW.E1_LA             ,:OLD.E1_LA              ))
            ,SADA_LOTE      = TRIM(NVL(:NEW.E1_LOTE           ,:OLD.E1_LOTE            ))
            ,SADA_MOTIVO    = TRIM(NVL(:NEW.E1_MOTIVO     ,:OLD.E1_MOTIVO      ))
            ,SADA_MOVIMEN   = TRIM(NVL(:NEW.E1_MOVIMEN    ,:OLD.E1_MOVIMEN     ))
            ,SADA_OP        = TRIM(NVL(:NEW.E1_OP             ,:OLD.E1_OP              ))
            ,SADA_SITUACA   = TRIM(NVL(:NEW.E1_SITUACA    ,:OLD.E1_SITUACA     ))
            ,SADA_CONTRAT   = TRIM(NVL(:NEW.E1_CONTRAT    ,:OLD.E1_CONTRAT     ))
            ,SADA_SALDO     = TRIM(NVL(:NEW.E1_SALDO        ,:OLD.E1_SALDO           ))
            ,SADA_SUPERVI   = TRIM(NVL(:NEW.E1_SUPERVI    ,:OLD.E1_SUPERVI     ))
            ,SADA_VEND1     = TRIM(NVL(:NEW.E1_VEND1        ,:OLD.E1_VEND1           ))
            ,SADA_VEND2     = TRIM(NVL(:NEW.E1_VEND2        ,:OLD.E1_VEND2           ))
            ,SADA_VEND3     = TRIM(NVL(:NEW.E1_VEND3        ,:OLD.E1_VEND3           ))
            ,SADA_VEND4     = TRIM(NVL(:NEW.E1_VEND4        ,:OLD.E1_VEND4           ))
            ,SADA_VEND5     = TRIM(NVL(:NEW.E1_VEND5        ,:OLD.E1_VEND5           ))
            ,SADA_COMIS1    = TRIM(NVL(:NEW.E1_COMIS1     ,:OLD.E1_COMIS1      ))
            ,SADA_COMIS2    = TRIM(NVL(:NEW.E1_COMIS2     ,:OLD.E1_COMIS2      ))
            ,SADA_COMIS3    = TRIM(NVL(:NEW.E1_COMIS3     ,:OLD.E1_COMIS3      ))
            ,SADA_COMIS4    = TRIM(NVL(:NEW.E1_COMIS4     ,:OLD.E1_COMIS4      ))
            ,SADA_COMIS5    = TRIM(NVL(:NEW.E1_COMIS5     ,:OLD.E1_COMIS5      ))
            ,SADA_DESCONT   = TRIM(NVL(:NEW.E1_DESCONT    ,:OLD.E1_DESCONT     ))
            ,SADA_MULTA     = TRIM(NVL(:NEW.E1_MULTA        ,:OLD.E1_MULTA           ))
            ,SADA_JUROS     = TRIM(NVL(:NEW.E1_JUROS        ,:OLD.E1_JUROS           ))
            ,SADA_CORREC    = TRIM(NVL(:NEW.E1_CORREC     ,:OLD.E1_CORREC      ))
            ,SADA_VALLIQ    = TRIM(NVL(:NEW.E1_VALLIQ     ,:OLD.E1_VALLIQ      ))
            ,SADA_VENCORI   = TRIM(NVL(:NEW.E1_VENCORI    ,:OLD.E1_VENCORI     ))
            ,SADA_CONTA     = TRIM(NVL(:NEW.E1_CONTA        ,:OLD.E1_CONTA           ))
            ,SADA_VALJUR    = TRIM(NVL(:NEW.E1_VALJUR     ,:OLD.E1_VALJUR      ))
            ,SADA_PORCJUR   = TRIM(NVL(:NEW.E1_PORCJUR    ,:OLD.E1_PORCJUR     ))
            ,SADA_MOEDA     = TRIM(NVL(:NEW.E1_MOEDA        ,:OLD.E1_MOEDA           ))
            ,SADA_BASCOM1   = TRIM(NVL(:NEW.E1_BASCOM1    ,:OLD.E1_BASCOM1     ))
            ,SADA_BASCOM2   = TRIM(NVL(:NEW.E1_BASCOM2    ,:OLD.E1_BASCOM2     ))
            ,SADA_BASCOM3   = TRIM(NVL(:NEW.E1_BASCOM3    ,:OLD.E1_BASCOM3     ))
            ,SADA_BASCOM4   = TRIM(NVL(:NEW.E1_BASCOM4    ,:OLD.E1_BASCOM4     ))
            ,SADA_BASCOM5   = TRIM(NVL(:NEW.E1_BASCOM5    ,:OLD.E1_BASCOM5     ))
            ,SADA_FATPREF   = TRIM(NVL(:NEW.E1_FATPREF    ,:OLD.E1_FATPREF     ))
            ,SADA_FATURA    = TRIM(NVL(:NEW.E1_FATURA     ,:OLD.E1_FATURA      ))
            ,SADA_OK        = TRIM(NVL(:NEW.E1_OK             ,:OLD.E1_OK              ))
            ,SADA_PROJETO   = TRIM(NVL(:NEW.E1_PROJETO    ,:OLD.E1_PROJETO     ))
            ,SADA_CLASCON   = TRIM(NVL(:NEW.E1_CLASCON    ,:OLD.E1_CLASCON     ))
            ,SADA_VALCOM1   = TRIM(NVL(:NEW.E1_VALCOM1    ,:OLD.E1_VALCOM1     ))
            ,SADA_VALCOM2   = TRIM(NVL(:NEW.E1_VALCOM2    ,:OLD.E1_VALCOM2     ))
            ,SADA_VALCOM3   = TRIM(NVL(:NEW.E1_VALCOM3    ,:OLD.E1_VALCOM3     ))
            ,SADA_VALCOM4   = TRIM(NVL(:NEW.E1_VALCOM4    ,:OLD.E1_VALCOM4     ))
            ,SADA_VALCOM5   = TRIM(NVL(:NEW.E1_VALCOM5    ,:OLD.E1_VALCOM5     ))
            ,SADA_OCORREN   = TRIM(NVL(:NEW.E1_OCORREN    ,:OLD.E1_OCORREN     ))
            ,SADA_INSTR1    = TRIM(NVL(:NEW.E1_INSTR1     ,:OLD.E1_INSTR1      ))
            ,SADA_INSTR2    = TRIM(NVL(:NEW.E1_INSTR2     ,:OLD.E1_INSTR2      ))
            ,SADA_PEDIDO    = TRIM(NVL(:NEW.E1_PEDIDO     ,:OLD.E1_PEDIDO      ))
            ,SADA_DTVARIA   = TRIM(NVL(:NEW.E1_DTVARIA    ,:OLD.E1_DTVARIA     ))
            ,SADA_VARURV    = TRIM(NVL(:NEW.E1_VARURV     ,:OLD.E1_VARURV      ))
            ,SADA_VLCRUZ    = TRIM(NVL(:NEW.E1_VLCRUZ     ,:OLD.E1_VLCRUZ      ))
            ,SADA_DTFATUR   = TRIM(NVL(:NEW.E1_DTFATUR    ,:OLD.E1_DTFATUR     ))
            ,SADA_NUMNOTA   = TRIM(NVL(:NEW.E1_NUMNOTA    ,:OLD.E1_NUMNOTA     ))
            ,SADA_SERIE     = TRIM(NVL(:NEW.E1_SERIE        ,:OLD.E1_SERIE           ))
            ,SADA_STATUS    = TRIM(NVL(:NEW.E1_STATUS     ,:OLD.E1_STATUS      ))
            ,SADA_ORIGEM    = TRIM(NVL(:NEW.E1_ORIGEM     ,:OLD.E1_ORIGEM      ))
            ,SADA_IDENTEE   = TRIM(NVL(:NEW.E1_IDENTEE    ,:OLD.E1_IDENTEE     ))
            ,SADA_NUMCART   = TRIM(NVL(:NEW.E1_NUMCART    ,:OLD.E1_NUMCART     ))
            ,SADA_FLUXO     = TRIM(NVL(:NEW.E1_FLUXO        ,:OLD.E1_FLUXO           ))
            ,SADA_DESCFIN   = TRIM(NVL(:NEW.E1_DESCFIN    ,:OLD.E1_DESCFIN     ))
            ,SADA_DIADESC   = TRIM(NVL(:NEW.E1_DIADESC    ,:OLD.E1_DIADESC     ))
            ,SADA_CARTAO    = TRIM(NVL(:NEW.E1_CARTAO     ,:OLD.E1_CARTAO      ))
            ,SADA_CARTVAL   = TRIM(NVL(:NEW.E1_CARTVAL    ,:OLD.E1_CARTVAL     ))
            ,SADA_CARTAUT   = TRIM(NVL(:NEW.E1_CARTAUT    ,:OLD.E1_CARTAUT     ))
            ,SADA_ADM       = TRIM(NVL(:NEW.E1_ADM              ,:OLD.E1_ADM             ))
            ,SADA_VLRREAL   = TRIM(NVL(:NEW.E1_VLRREAL    ,:OLD.E1_VLRREAL     ))
            ,SADA_TRANSF    = TRIM(NVL(:NEW.E1_TRANSF     ,:OLD.E1_TRANSF      ))
            ,SADA_BCOCHQ    = TRIM(NVL(:NEW.E1_BCOCHQ     ,:OLD.E1_BCOCHQ      ))
            ,SADA_AGECHQ    = TRIM(NVL(:NEW.E1_AGECHQ     ,:OLD.E1_AGECHQ      ))
            ,SADA_CTACHQ    = TRIM(NVL(:NEW.E1_CTACHQ     ,:OLD.E1_CTACHQ      ))
            ,SADA_NUMLIQ    = TRIM(NVL(:NEW.E1_NUMLIQ     ,:OLD.E1_NUMLIQ      ))
            ,SADA_FLSERV    = TRIM(NVL(:NEW.E1_FLSERV     ,:OLD.E1_FLSERV      ))
            ,SADA_ORDPAGO   = TRIM(NVL(:NEW.E1_ORDPAGO    ,:OLD.E1_ORDPAGO     ))
            ,SADA_INSS      = TRIM(NVL(:NEW.E1_INSS           ,:OLD.E1_INSS            ))
            ,SADA_NUMTIA    = TRIM(NVL(:NEW.E1_NUMTIA     ,:OLD.E1_NUMTIA      ))
            ,SADA_NNUMERO   = TRIM(NVL(:NEW.E1_NNUMERO    ,:OLD.E1_NNUMERO     ))
            ,SADA_CURSO     = TRIM(NVL(:NEW.E1_CURSO        ,:OLD.E1_CURSO           ))
            ,SADA_DTIMPRE   = TRIM(NVL(:NEW.E1_DTIMPRE    ,:OLD.E1_DTIMPRE     ))
            ,SADA_DTREIMP   = TRIM(NVL(:NEW.E1_DTREIMP    ,:OLD.E1_DTREIMP     ))
            ,SADA_VLBOLSA   = TRIM(NVL(:NEW.E1_VLBOLSA    ,:OLD.E1_VLBOLSA     ))
            ,SADA_CLIENTE   = TRIM(NVL(:NEW.E1_CLIENTE    ,:OLD.E1_CLIENTE     ))
            ,SADA_USERLGI   = TRIM(NVL(:NEW.E1_USERLGI    ,:OLD.E1_USERLGI     ))
            ,SADA_USERLGA   = TRIM(NVL(:NEW.E1_USERLGA    ,:OLD.E1_USERLGA     ))
            ,SADA_NUMREGT   = TRIM(NVL(:NEW.E1_NUMREGT    ,:OLD.E1_NUMREGT     ))
            ,SADA_TIPOBX    = TRIM(NVL(:NEW.E1_TIPOBX     ,:OLD.E1_TIPOBX      ))
            ,SADA_DESCON1   = TRIM(NVL(:NEW.E1_DESCON1    ,:OLD.E1_DESCON1     ))
            ,SADA_DESCON2   = TRIM(NVL(:NEW.E1_DESCON2    ,:OLD.E1_DESCON2     ))
            ,SADA_ANOMESD   = TRIM(NVL(:NEW.E1_ANOMESD    ,:OLD.E1_ANOMESD     ))
            ,SADA_VLACUM    = TRIM(NVL(:NEW.E1_VLACUM     ,:OLD.E1_VLACUM      ))
            ,SADA_NHISTIA   = TRIM(NVL(:NEW.E1_NHISTIA    ,:OLD.E1_NHISTIA     ))
            ,SADA_NHISTSI   = TRIM(NVL(:NEW.E1_NHISTSI    ,:OLD.E1_NHISTSI     ))
            ,SADA_COFINS    = TRIM(NVL(:NEW.E1_COFINS     ,:OLD.E1_COFINS      ))
            ,SADA_CSLL      = TRIM(NVL(:NEW.E1_CSLL           ,:OLD.E1_CSLL            ))
            ,SADA_FILORIG   = TRIM(NVL(:NEW.E1_FILORIG    ,:OLD.E1_FILORIG     ))
            ,SADA_FLAGFAT   = TRIM(NVL(:NEW.E1_FLAGFAT    ,:OLD.E1_FLAGFAT     ))
            ,SADA_PIS       = TRIM(NVL(:NEW.E1_PIS              ,:OLD.E1_PIS             ))
            ,SADA_TIPOFAT   = TRIM(NVL(:NEW.E1_TIPOFAT    ,:OLD.E1_TIPOFAT     ))
            ,SADA_TIPOLIQ   = TRIM(NVL(:NEW.E1_TIPOLIQ    ,:OLD.E1_TIPOLIQ     ))
            ,SADA_MESBASE   = TRIM(NVL(:NEW.E1_MESBASE    ,:OLD.E1_MESBASE     ))
            ,SADA_ANOBASE   = TRIM(NVL(:NEW.E1_ANOBASE    ,:OLD.E1_ANOBASE     ))
            ,SADA_PLNUCOB   = TRIM(NVL(:NEW.E1_PLNUCOB    ,:OLD.E1_PLNUCOB     ))
            ,SADA_CODINT    = TRIM(NVL(:NEW.E1_CODINT     ,:OLD.E1_CODINT      ))
            ,SADA_CODEMP    = TRIM(NVL(:NEW.E1_CODEMP     ,:OLD.E1_CODEMP      ))
            ,SADA_MATRIC    = TRIM(NVL(:NEW.E1_MATRIC     ,:OLD.E1_MATRIC      ))
            ,SADA_ACRESC    = TRIM(NVL(:NEW.E1_ACRESC     ,:OLD.E1_ACRESC      ))
            ,SADA_SDACRES   = TRIM(NVL(:NEW.E1_SDACRES    ,:OLD.E1_SDACRES     ))
            ,SADA_DECRESC   = TRIM(NVL(:NEW.E1_DECRESC    ,:OLD.E1_DECRESC     ))
            ,SADA_SDDECRE   = TRIM(NVL(:NEW.E1_SDDECRE    ,:OLD.E1_SDDECRE     ))
            ,SADA_MULTNAT   = TRIM(NVL(:NEW.E1_MULTNAT    ,:OLD.E1_MULTNAT     ))
            ,SADA_MSFIL     = TRIM(NVL(:NEW.E1_MSFIL        ,:OLD.E1_MSFIL           ))
            ,SADA_MSEMP     = TRIM(NVL(:NEW.E1_MSEMP        ,:OLD.E1_MSEMP           ))
            ,SADA_PROJPMS   = TRIM(NVL(:NEW.E1_PROJPMS    ,:OLD.E1_PROJPMS     ))
            ,SADA_CODVES    = TRIM(NVL(:NEW.E1_CODVES     ,:OLD.E1_CODVES      ))
            ,SADA_CONFERE   = TRIM(NVL(:NEW.E1_CONFERE    ,:OLD.E1_CONFERE     ))
            ,SADA_MODSPB    = TRIM(NVL(:NEW.E1_MODSPB     ,:OLD.E1_MODSPB      ))
            ,SADA_NUMHIST   = TRIM(NVL(:NEW.E1_NUMHIST    ,:OLD.E1_NUMHIST     ))
            ,SADA_CODBAR    = TRIM(NVL(:NEW.E1_CODBAR     ,:OLD.E1_CODBAR      ))
            ,SADA_CODDIG    = TRIM(NVL(:NEW.E1_CODDIG     ,:OLD.E1_CODDIG      ))
            ,SADA_DESCON3   = TRIM(NVL(:NEW.E1_DESCON3    ,:OLD.E1_DESCON3     ))
            ,SADA_DMOTNEG   = TRIM(NVL(:NEW.E1_DMOTNEG    ,:OLD.E1_DMOTNEG     ))
            ,SADA_DTDESC1   = TRIM(NVL(:NEW.E1_DTDESC1    ,:OLD.E1_DTDESC1     ))
            ,SADA_DTDESC2   = TRIM(NVL(:NEW.E1_DTDESC2    ,:OLD.E1_DTDESC2     ))
            ,SADA_DTDESC3   = TRIM(NVL(:NEW.E1_DTDESC3    ,:OLD.E1_DTDESC3     ))
            ,SADA_INSCRIC   = TRIM(NVL(:NEW.E1_INSCRIC    ,:OLD.E1_INSCRIC     ))
            ,SADA_MOTNEG    = TRIM(NVL(:NEW.E1_MOTNEG     ,:OLD.E1_MOTNEG      ))
            ,SADA_NOMEALU   = TRIM(NVL(:NEW.E1_NOMEALU    ,:OLD.E1_NOMEALU     ))
            ,SADA_NRDOC     = TRIM(NVL(:NEW.E1_NRDOC        ,:OLD.E1_NRDOC           ))
            ,SADA_VLFIES    = TRIM(NVL(:NEW.E1_VLFIES     ,:OLD.E1_VLFIES      ))
            ,SADA_VLMULTA   = TRIM(NVL(:NEW.E1_VLMULTA    ,:OLD.E1_VLMULTA     ))
            ,SADA_SABTPIS   = TRIM(NVL(:NEW.E1_SABTPIS    ,:OLD.E1_SABTPIS     ))
            ,SADA_VLREEMB   = TRIM(NVL(:NEW.E1_VLREEMB    ,:OLD.E1_VLREEMB     ))
            ,SADA_DTDESC4   = TRIM(NVL(:NEW.E1_DTDESC4    ,:OLD.E1_DTDESC4     ))
            ,SADA_DESCON4   = TRIM(NVL(:NEW.E1_DESCON4    ,:OLD.E1_DESCON4     ))
        WHERE SADA_IDEMPRESA = IDEMPRESA
              AND SADA_NUMRA = NUMRA
              AND SADA_NREG  = NREG;
    -- CASO O REGISTRO AINDA NÃO SEJA ATIVO
        ELSIF INSERTING OR ( UPDATING AND :NEW.D_E_L_E_T_ = ' ' AND :OLD.D_E_L_E_T_ <> :NEW.D_E_L_E_T_ ) THEN
        SELECT SAET_IDEMPRESA 
        INTO IDEMPRESA
          FROM SEUTESTE.SEUAET
         WHERE SAET_NUMRA = TRIM(:NEW.E1_NUMRA);
        
      	INSERT INTO SEUTESTE.SEUADA (SADA_IDEMPRESA ,SADA_PREFIXO,SADA_NUM,SADA_PARCELA
                                    ,SADA_TIPO,SADA_NATUREZA,SADA_PORTADO,SADA_AGEDEP,SADA_NUMRA,SADA_LOJA,SADA_NOMCLI,SADA_CC
                                    ,SADA_EMISSAO,SADA_VENCTO,SADA_VENCREA,SADA_VALOR,SADA_IRRF,SADA_ISS,SADA_NUMBCO,SADA_INDICE
                                    ,SADA_BAIXA,SADA_NUMBOR,SADA_DATABOR,SADA_EMIS1,SADA_HIST,SADA_LA,SADA_LOTE,SADA_MOTIVO
                                    ,SADA_MOVIMEN,SADA_OP,SADA_SITUACA,SADA_CONTRAT,SADA_SALDO,SADA_SUPERVI,SADA_VEND1,SADA_VEND2
                                    ,SADA_VEND3,SADA_VEND4,SADA_VEND5,SADA_COMIS1,SADA_COMIS2,SADA_COMIS3,SADA_COMIS4,SADA_COMIS5
                                    ,SADA_DESCONT,SADA_MULTA,SADA_JUROS,SADA_CORREC,SADA_VALLIQ,SADA_VENCORI,SADA_CONTA,SADA_VALJUR
                                    ,SADA_PORCJUR,SADA_MOEDA,SADA_BASCOM1,SADA_BASCOM2,SADA_BASCOM3,SADA_BASCOM4,SADA_BASCOM5,SADA_FATPREF
      															,SADA_FATURA,SADA_OK,SADA_PROJETO,SADA_CLASCON,SADA_VALCOM1
                                    ,SADA_VALCOM2,SADA_VALCOM3,SADA_VALCOM4,SADA_VALCOM5
                                    ,SADA_OCORREN,SADA_INSTR1,SADA_INSTR2,SADA_PEDIDO
                                    ,SADA_DTVARIA,SADA_VARURV,SADA_VLCRUZ,SADA_DTFATUR
                                    ,SADA_NUMNOTA,SADA_SERIE,SADA_STATUS,SADA_ORIGEM
                                    ,SADA_IDENTEE,SADA_NUMCART,SADA_FLUXO,SADA_DESCFIN,SADA_DIADESC
                                    ,SADA_CARTAO,SADA_CARTVAL,SADA_CARTAUT,SADA_ADM
                                    ,SADA_VLRREAL,SADA_TRANSF,SADA_BCOCHQ,SADA_AGECHQ
                                    ,SADA_CTACHQ,SADA_NUMLIQ,SADA_FLSERV,SADA_ORDPAGO
                                    ,SADA_INSS,SADA_NUMTIA,SADA_NNUMERO,SADA_CURSO
                                    ,SADA_DTIMPRE,SADA_DTREIMP,SADA_VLBOLSA,SADA_CLIENTE,SADA_USERLGI
                                    ,SADA_USERLGA,SADA_NUMREGT,SADA_TIPOBX,SADA_DESCON1
                                    ,SADA_DESCON2,SADA_ANOMESD,SADA_VLACUM,SADA_NHISTIA
                                    ,SADA_NHISTSI,SADA_COFINS,SADA_CSLL,SADA_FILORIG
                                    ,SADA_FLAGFAT,SADA_PIS,SADA_TIPOFAT,SADA_TIPOLIQ
                                    ,SADA_MESBASE,SADA_ANOBASE,SADA_PLNUCOB,SADA_CODINT,SADA_CODEMP
                                    ,SADA_MATRIC,SADA_ACRESC,SADA_SDACRES,SADA_DECRESC
                                    ,SADA_SDDECRE,SADA_MULTNAT,SADA_MSFIL,SADA_MSEMP
                                    ,SADA_PROJPMS,SADA_CODVES,SADA_CONFERE,SADA_MODSPB
                                    ,SADA_NUMHIST,SADA_CODBAR,SADA_CODDIG,SADA_DESCON3
                                    ,SADA_DMOTNEG,SADA_DTDESC1,SADA_DTDESC2,SADA_DTDESC3
                                    ,SADA_INSCRIC,SADA_MOTNEG,SADA_NOMEALU,SADA_NRDOC,SADA_VLFIES
                                    ,SADA_VLMULTA,SADA_SABTPIS,SADA_VLREEMB,SADA_DTDESC4
                                    ,SADA_DESCON4,SADA_NREG
                                    ) VALUES (
                                     IDEMPRESA
                                    ,TRIM(:NEW.E1_PREFIXO ),TRIM(:NEW.E1_NUM         ),TRIM(:NEW.E1_PARCELA )
	                                  ,TRIM(:NEW.E1_TIPO    ),TRIM(:NEW.E1_NATUREZ ),TRIM(:NEW.E1_PORTADO )
	                                  ,TRIM(:NEW.E1_AGEDEP  ),TRIM(:NEW.E1_NUMRA   ),TRIM(:NEW.E1_LOJA    )
	                                  ,TRIM(:NEW.E1_NOMCLI  ),TRIM(:NEW.E1_CC          ),TRIM(:NEW.E1_EMISSAO )
	                                  ,TRIM(:NEW.E1_VENCTO  ),TRIM(:NEW.E1_VENCREA ),TRIM(:NEW.E1_VALOR   )
	                                  ,TRIM(:NEW.E1_IRRF    ),TRIM(:NEW.E1_ISS         ),TRIM(:NEW.E1_NUMBCO  )
	                                  ,TRIM(:NEW.E1_INDICE  ),TRIM(:NEW.E1_BAIXA   ),TRIM(:NEW.E1_NUMBOR  )
	                                  ,TRIM(:NEW.E1_DATABOR ),TRIM(:NEW.E1_EMIS1   ),TRIM(:NEW.E1_HIST    )
	                                  ,TRIM(:NEW.E1_LA      ),TRIM(:NEW.E1_LOTE    ),TRIM(:NEW.E1_MOTIVO  )
	                                  ,TRIM(:NEW.E1_MOVIMEN ),TRIM(:NEW.E1_OP   ),TRIM(:NEW.E1_SITUACA )
	                                  ,TRIM(:NEW.E1_CONTRAT ),TRIM(:NEW.E1_SALDO   ),TRIM(:NEW.E1_SUPERVI )
	                                  ,TRIM(:NEW.E1_VEND1   ),TRIM(:NEW.E1_VEND2   ),TRIM(:NEW.E1_VEND3   )
	                                  ,TRIM(:NEW.E1_VEND4   ),TRIM(:NEW.E1_VEND5   ),TRIM(:NEW.E1_COMIS1  )
	                                  ,TRIM(:NEW.E1_COMIS2  ),TRIM(:NEW.E1_COMIS3  ),TRIM(:NEW.E1_COMIS4  )
	                                  ,TRIM(:NEW.E1_COMIS5  ),TRIM(:NEW.E1_DESCONT ),TRIM(:NEW.E1_MULTA   )
	                                  ,TRIM(:NEW.E1_JUROS   ),TRIM(:NEW.E1_CORREC  ),TRIM(:NEW.E1_VALLIQ  )
	                                  ,TRIM(:NEW.E1_VENCORI ),TRIM(:NEW.E1_CONTA   ),TRIM(:NEW.E1_VALJUR  )
	                                  ,TRIM(:NEW.E1_PORCJUR ),TRIM(:NEW.E1_MOEDA   ),TRIM(:NEW.E1_BASCOM1 )
	                                  ,TRIM(:NEW.E1_BASCOM2 ),TRIM(:NEW.E1_BASCOM3 ),TRIM(:NEW.E1_BASCOM4 )
	                                  ,TRIM(:NEW.E1_BASCOM5 ),TRIM(:NEW.E1_FATPREF ),TRIM(:NEW.E1_FATURA  )
	                                  ,TRIM(:NEW.E1_OK      ),TRIM(:NEW.E1_PROJETO ),TRIM(:NEW.E1_CLASCON )
	                                  ,TRIM(:NEW.E1_VALCOM1 ),TRIM(:NEW.E1_VALCOM2 ),TRIM(:NEW.E1_VALCOM3 )
	                                  ,TRIM(:NEW.E1_VALCOM4 ),TRIM(:NEW.E1_VALCOM5 ),TRIM(:NEW.E1_OCORREN )
	                                  ,TRIM(:NEW.E1_INSTR1  ),TRIM(:NEW.E1_INSTR2  ),TRIM(:NEW.E1_PEDIDO  )
	                                  ,TRIM(:NEW.E1_DTVARIA ),TRIM(:NEW.E1_VARURV  ),TRIM(:NEW.E1_VLCRUZ  )
	                                  ,TRIM(:NEW.E1_DTFATUR ),TRIM(:NEW.E1_NUMNOTA ),TRIM(:NEW.E1_SERIE   )
	                                  ,TRIM(:NEW.E1_STATUS  ),TRIM(:NEW.E1_ORIGEM  ),TRIM(:NEW.E1_IDENTEE )
	                                  ,TRIM(:NEW.E1_NUMCART ),TRIM(:NEW.E1_FLUXO   ),TRIM(:NEW.E1_DESCFIN )
	                                  ,TRIM(:NEW.E1_DIADESC ),TRIM(:NEW.E1_CARTAO  ),TRIM(:NEW.E1_CARTVAL )
	                                  ,TRIM(:NEW.E1_CARTAUT ),TRIM(:NEW.E1_ADM ),TRIM(:NEW.E1_VLRREAL )
	                                  ,TRIM(:NEW.E1_TRANSF  ),TRIM(:NEW.E1_BCOCHQ  ),TRIM(:NEW.E1_AGECHQ  )
	                                  ,TRIM(:NEW.E1_CTACHQ  ),TRIM(:NEW.E1_NUMLIQ  ),TRIM(:NEW.E1_FLSERV  )
	                                  ,TRIM(:NEW.E1_ORDPAGO ),TRIM(:NEW.E1_INSS    ),TRIM(:NEW.E1_NUMTIA  )
	                                  ,TRIM(:NEW.E1_NNUMERO ),TRIM(:NEW.E1_CURSO   ),TRIM(:NEW.E1_DTIMPRE )
	                                  ,TRIM(:NEW.E1_DTREIMP ),TRIM(:NEW.E1_VLBOLSA ),TRIM(:NEW.E1_CLIENTE )
	                                  ,TRIM(:NEW.E1_USERLGI ),TRIM(:NEW.E1_USERLGA ),TRIM(:NEW.E1_NUMREGT )
	                                  ,TRIM(:NEW.E1_TIPOBX  ),TRIM(:NEW.E1_DESCON1 ),TRIM(:NEW.E1_DESCON2 )
	                                  ,TRIM(:NEW.E1_ANOMESD ),TRIM(:NEW.E1_VLACUM  ),TRIM(:NEW.E1_NHISTIA )
	                                  ,TRIM(:NEW.E1_NHISTSI ),TRIM(:NEW.E1_COFINS  ),TRIM(:NEW.E1_CSLL    )
	                                  ,TRIM(:NEW.E1_FILORIG ),TRIM(:NEW.E1_FLAGFAT ),TRIM(:NEW.E1_PIS         )
	                                  ,TRIM(:NEW.E1_TIPOFAT ),TRIM(:NEW.E1_TIPOLIQ ),TRIM(:NEW.E1_MESBASE )
	                                  ,TRIM(:NEW.E1_ANOBASE ),TRIM(:NEW.E1_PLNUCOB ),TRIM(:NEW.E1_CODINT  )
	                                  ,TRIM(:NEW.E1_CODEMP  ),TRIM(:NEW.E1_MATRIC  ),TRIM(:NEW.E1_ACRESC  )
	                                  ,TRIM(:NEW.E1_SDACRES ),TRIM(:NEW.E1_DECRESC ),TRIM(:NEW.E1_SDDECRE )
	                                  ,TRIM(:NEW.E1_MULTNAT ),TRIM(:NEW.E1_MSFIL   ),TRIM(:NEW.E1_MSEMP   )
	                                  ,TRIM(:NEW.E1_PROJPMS ),TRIM(:NEW.E1_CODVES  ),TRIM(:NEW.E1_CONFERE )
	                                  ,TRIM(:NEW.E1_MODSPB  ),TRIM(:NEW.E1_NUMHIST ),TRIM(:NEW.E1_CODBAR  )
	                                  ,TRIM(:NEW.E1_CODDIG  ),TRIM(:NEW.E1_DESCON3 ),TRIM(:NEW.E1_DMOTNEG )
	                                  ,TRIM(:NEW.E1_DTDESC1 ),TRIM(:NEW.E1_DTDESC2 ),TRIM(:NEW.E1_DTDESC3 )
	                                  ,TRIM(:NEW.E1_INSCRIC ),TRIM(:NEW.E1_MOTNEG  ),TRIM(:NEW.E1_NOMEALU )
	                                  ,TRIM(:NEW.E1_NRDOC   ),TRIM(:NEW.E1_VLFIES  ),TRIM(:NEW.E1_VLMULTA )
	                                  ,TRIM(:NEW.E1_SABTPIS ),TRIM(:NEW.E1_VLREEMB ),TRIM(:NEW.E1_DTDESC4 )
	                                  ,TRIM(:NEW.E1_DESCON4 ),TRIM(:NEW.R_E_C_N_O_));
    -- REGISTRO DELETADO
        ELSE
      -- BUSCA INFORMAÇÕES DA EMPRESA / NUMRA / NREG(RECNO)
          SELECT SADA_IDEMPRESA,SADA_NUMRA, SADA_NREG 
        INTO IDEMPRESA, NUMRA, NREG
          FROM SEUTESTE.SEUADA
         WHERE SADA_NREG = :OLD.R_E_C_N_O_
         AND  SADA_NUMRA = TRIM(:NEW.E1_NUMRA);
      -- DELETA
        DELETE SEUTESTE.SEUADA WHERE SADA_NREG = NREG AND SADA_IDEMPRESA = IDEMPRESA;
        END IF;
		END IF;
END;
/
