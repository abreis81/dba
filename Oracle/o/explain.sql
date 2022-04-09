REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;


col operation   format A40
col options     format A15
col object_name format A25
set echo on
explain plan for
 SELECT RPAD(NVL(TO_CHAR(A.DDAT_SOLIC,'dd/mm/yyyy'),' '),11,' ') DATA
,LPAD(NVL(TO_CHAR(A.NNUM_CART),' '),17,' ') CARTAO,
LPAD(NVL(TO_CHAR(A.VTP_DEBIT),' '),2,' ') || '  -  '  || RPAD(NVL(C.VDES_DEBIT,' '),25,' ')  MOTIVO
,LPAD(NVL(TO_CHAR(A.NCOD_PLAN),0),10,'0') PLANILHA
,RPAD(NVL(TO_CHAR(B.NCOD_COMPL),0),2,'0') OCORRENCIA
,NVL(TO_CHAR(B.NVLR_ORIG),'0') VALORITENS
,NVL(TO_CHAR(A.NVLR_PLAN),'0') VALORPLAN
,A.DDAT_SOLIC DT   
FROM TBEDGE_DEBITO_INDEV A
,TBEDGE_DETALHE_PLAN B
,TBEDGE_TP_DEBITO C  
WHERE A.NCOD_PLAN = B.NCOD_PLAN 
AND A.NCOD_MIDIA = B.NCOD_MIDIA 
AND C.NCOD_TP = A.VTP_DEBIT 
AND A.DDAT_SOLIC >= TO_DATE(:b1,'dd/mm/yyyy')  
AND A.DDAT_SOLIC <= TO_DATE(:b2,'dd/mm/yyyy')  
AND TO_CHAR(A.DHOR_SOLIC,'hh24:mi:ss') >= :b3  
AND TO_CHAR(A.DHOR_SOLIC,'hh24:mi:ss') <= :b4  
AND C.VDES_DEBIT = NVL(:b5,C.VDES_DEBIT)  
AND A.VSTA_DEBIT =NVL(:b6,A.VSTA_DEBIT) 
ORDER BY A.VTP_DEBIT,DT,A.NCOD_PLAN

/
set echo off 
spool explain.lis
Select   lpad( ' ', 2*( level - 1 ) )||operation||'  '||
         decode(id, 0, 'Cost = '||position ) "OPERATION",
         options,
         object_name,
	 OPTIMIZER
  from   plan_table
 start with  id = 0
 connect by prior id = parent_id;
spool off

