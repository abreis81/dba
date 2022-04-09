SELECT DISTINCT TABLE_NAME ,COLUMN_NAME, DATA_TYPE, DATA_LENGTH FROM DBA_TAB_COLUMNS A
                  WHERE DATA_TYPE<>'BLOB' AND COLUMN_NAME NOT LIKE '%NREG%'
                  AND COLUMN_NAME NOT LIKE '%IDUSUARIO%' AND OWNER='SEU' and table_name not like '%LOG%' 
                  and table_name not like '%BKP%' and table_name not in 
                  (select view_name from dba_views where owner='SEU')
                  AND TABLE_NAME LIKE 'SEU%' AND TABLE_NAME NOT LIKE '%TESTE%'
                  AND NOT EXISTS (SELECT 'X' FROM DBA_TAB_COLUMNS B WHERE B.OWNER=A.OWNER
                  AND B.TABLE_NAME=A.TABLE_NAME||'_LOG' AND (B.COLUMN_NAME=A.COLUMN_NAME||'_ANTES' OR
                                        B.COLUMN_NAME=A.COLUMN_NAME||'_DEPOIS'))