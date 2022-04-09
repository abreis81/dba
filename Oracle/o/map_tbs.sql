ACCEPT TBS PROMPT "DIGITE A TABLESPACE: "

SET RECSEP OFF
SET VER OFF
SET LINES 120
SET FEED OFF
SET HEAD OFF
SET SERVEROUTPUT ON SIZE 1000000


DECLARE

STR VARCHAR2(4000);
TAMANHO NUMBER :=0;

CURSOR C_FILE IS SELECT FILE_NAME, FILE_ID, TABLESPACE_NAME FROM DBA_DATA_FILES WHERE TABLESPACE_NAME='&&TBS' ORDER BY FILE_ID;

CURSOR C1(FILE_NUM IN NUMBER) IS
        select decode(substr(segment_name,1,2),'F:',segment_name||'MB','.') BLOCO from (SELECT SEGMENT_NAME, BLOCK_ID, BLOCKS , FILE_ID FROM DBA_EXTENTS WHERE FILE_ID=FILE_NUM
        UNION
        SELECT 'F:'||to_char(trunc(bytes/1024/1024)) SEGMENT_NAME, BLOCK_ID, BLOCKS, FILE_ID FROM DBA_FREE_SPACE WHERE FILE_ID=FILE_NUM)
        ORDER BY BLOCK_ID;

BEGIN
    FOR RC_FILE IN C_FILE LOOP
	DBMS_OUTPUT.PUT_LINE('---');
        DBMS_OUTPUT.PUT_LINE(RC_FILE.TABLESPACE_NAME||' '||RC_FILE.FILE_NAME);
        FOR RC1 IN C1(RC_FILE.FILE_ID) LOOP
            SELECT LENGTH(STR) INTO TAMANHO FROM DUAL;
            IF TAMANHO > 99 THEN 
                DBMS_OUTPUT.PUT_LINE(STR);
                STR:='';
            END IF;
            STR := STR||RC1.BLOCO;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(STR);
    END LOOP;
END;
/

PROMPT 
PROMPT LEGENDA:
PROMPT . -> EXTENTS DE OUTROS OBJETOS
PROMPT F -> EXTENT/ESPACO LIVRE EM MB

set feed on
set ver on
SET HEAD ON

        