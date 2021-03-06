CREATE OR REPLACE FORCE VIEW TRANS_ABAST_BENS_SERVI_RECEB AS
  SELECT IDT_COMPA
        ,IDT_COMPA_POSIC
        ,COD_POSIC_FORNE COD_POSIC
        ,COD_ISSUE_CODE_CARTA
        ,COD_CLIEN
        ,NUM_SEQUE_CARTA
        ,NUM_DUPLI_CARTA
        ,COD_SUB_CONTA
        ,IDC_POSIC_RESTR
        ,COD_PRODU_FROTA
        ,QTD_ABAST_LITRO
        ,VAL_LIQUI_TOTAL
        ,VAL_LIQUI_TOTAL_EURO
        ,VAL_SERVI
        ,VAL_SERVI_EURO
        ,TIP_TRANS
        ,QTD_REGUL
        ,DAT_PROXI_FACTU
        ,DAT_CONTR_PLAFO_CLIEN
        ,COD_TIPO_CLIEN
        ,DAT_TRANS
        ,IDC_CONTR_LISTA_NEGRA
  FROM TRANS_PLAFO_TEMPO
WITH READ ONLY;
-- WITH CHECK OPTION CONSTRAINT "VI_CONSISTE"
