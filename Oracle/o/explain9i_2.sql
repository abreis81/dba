REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;

col operation   format A40
col options     format A15
col object_name format A25
col PARTITION_START format A25
col PARTITION_STOP format A25
set echo on
explain plan for
SELECT   /*+ USE_NL ("A9") */
         MAX ("A4"."SET_OF_BOOKS_ID"), "A6"."CODE_COMBINATION_ID",
         "A6"."SEGMENT1", "A6"."SEGMENT2", "A6"."SEGMENT3", "A6"."SEGMENT4",
         "A6"."SEGMENT5", "A6"."SEGMENT6", "A6"."SEGMENT7",
         MAX ("A1"."TRANSACTION_DATE"), MAX ("A8"."ACCOUNTING_DATE"),
         TRUNC ("A3"."EFFECTIVE_DATE"), "A7"."AE_HEADER_ID",
         "A7"."AE_LINE_ID",
         SUM (DECODE ("A3"."SET_OF_BOOKS_ID",
                      101, NVL ("A7"."ENTERED_DR", 0),0)),
         SUM (DECODE ("A3"."SET_OF_BOOKS_ID",
                      101, NVL ("A7"."ENTERED_CR", 0),0)),
         SUM (DECODE ("A3"."SET_OF_BOOKS_ID",
                      102, NVL ("A7"."ACCOUNTED_DR", 0),0)),
         SUM (DECODE ("A3"."SET_OF_BOOKS_ID",
                      102, NVL ("A7"."ACCOUNTED_CR", 0),0)),
         "A9"."SEGMENT1", "A1"."SOURCE_LINE_ID", "A9"."DESCRIPTION",
         "A10"."USER_NAME", "A1"."TRANSACTION_QUANTITY", "A4"."NAME",
         MAX ("A1"."TRANSACTION_ID"), MAX ("A2"."JE_BATCH_ID"),
         MAX ("A5"."NAME")
    FROM "APPS"."FND_USER" "A10",
         "INV"."MTL_SYSTEM_ITEMS_B" "A9",
         "BOM"."CST_AE_HEADERS" "A8",
         "BOM"."CST_AE_LINES" "A7",
         "GL"."GL_CODE_COMBINATIONS" "A6",
         "GL"."GL_JE_BATCHES" "A5",
         "GL"."GL_JE_HEADERS" "A4",
         "GL"."GL_JE_LINES" "A3",
         "GL"."GL_IMPORT_REFERENCES" "A2",
         "INV"."MTL_MATERIAL_TRANSACTIONS" "A1"
   WHERE "A10"."USER_ID" = "A1"."CREATED_BY"
     AND "A1"."INVENTORY_ITEM_ID" = "A9"."INVENTORY_ITEM_ID"
     AND "A1"."ORGANIZATION_ID" = "A9"."ORGANIZATION_ID"
     AND "A8"."AE_HEADER_ID" = "A7"."AE_HEADER_ID"
     AND "A7"."SOURCE_TABLE" = 'MMT'
     AND "A6"."CODE_COMBINATION_ID" = "A3"."CODE_COMBINATION_ID"
     AND "A7"."CODE_COMBINATION_ID" = "A3"."CODE_COMBINATION_ID"
     AND "A5"."JE_BATCH_ID" = "A2"."JE_BATCH_ID"
     AND "A2"."REFERENCE_1" = TO_CHAR ("A8"."GL_TRANSFER_RUN_ID")
     AND "A4"."JE_HEADER_ID" = "A3"."JE_HEADER_ID"
     AND "A3"."JE_HEADER_ID" = "A2"."JE_HEADER_ID"
     AND "A3"."JE_LINE_NUM" = "A2"."JE_LINE_NUM"
     AND "A2"."REFERENCE_3" = TO_CHAR ("A1"."TRANSACTION_ID")
     AND "A8"."ACCOUNTING_EVENT_ID" = "A1"."TRANSACTION_ID"
     AND "A8"."GL_TRANSFER_FLAG" = 'Y'
     AND "A6"."SEGMENT2" <> '00000'
     AND "A5"."NAME" NOT LIKE '%MRC%'
     AND "A3"."STATUS" = 'P'
     AND "A4"."POSTED_DATE" >= SYSDATE - 5
     AND "A4"."JE_HEADER_ID" = "A2"."JE_HEADER_ID"
GROUP BY "A6"."CODE_COMBINATION_ID",
         "A6"."SEGMENT1",
         "A6"."SEGMENT2",
         "A6"."SEGMENT3",
         "A6"."SEGMENT4",
         "A6"."SEGMENT5",
         "A6"."SEGMENT6",
         "A6"."SEGMENT7",
         "A7"."AE_HEADER_ID",
         "A7"."AE_LINE_ID",
         "A9"."SEGMENT1",
         "A1"."SOURCE_LINE_ID",
         "A9"."DESCRIPTION",
         "A10"."USER_NAME",
         "A1"."TRANSACTION_QUANTITY",
         "A4"."NAME",
         TRUNC ("A3"."EFFECTIVE_DATE")

/

set echo off 
spool explain.lis
select * from table(dbms_xplan.display('PLAN_TABLE',null,'ALL'));
spool off

