REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;


col operation   format A30
col options     format A15
col object_name format A25
col OPTIMIZER format a10
set echo on
explain plan for
SELECT T.RESULTADO   FROM ALCOA.TAG_MEDIA_DIARIA T  
WHERE T.CODIGO_TAG = '52ATQ01X'  AND TRUNC(T.DATA) = TRUNC(sysdate)
/

set echo off 
spool c:\temp\plano.txt
Select   lpad( ' ', 2*( level - 1 ) )||operation||'  '||
         decode(id, 0, 'Cost = '||position ) "OPERATION",
         options,
         object_name,
	 OPTIMIZER,
	 CARDINALITY,
	 BYTES,
	 COST
  from   plan_table
 start with  id = 0
 connect by prior id = parent_id;
spool off
--SP_RT_CONTRL_GERAC_INTERF_STG

