REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;

--/*+ index(p PK_PROC) */ 

col operation   format A40
col options     format A15
col object_name format A25
col PARTITION_START format A25
col PARTITION_STOP format A25
set echo on
explain plan for
UPDATE /*+ index( a ix_x21_ficha_finan)  */X21_FICHA_FINANC A 
SET IDENT_CONTA=:b1 WHERE COD_EMPRESA = '001'  
AND LPAD(COD_FUNC,10,'0') = LPAD(:b2,10,'0')  
AND ANO_COMPETENCIA = :b3  AND LPAD(MES_COMPETENCIA,2,'0') = LPAD(:b4,2,'0')  
AND IDENT_VERBA = :b5

/

set echo off 
spool explain.lis
@/oracle/ora9i/rdbms/admin/utlxpls.sql
spool off

