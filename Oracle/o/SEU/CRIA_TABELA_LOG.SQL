SET SERVEROUTPUT ON SIZE 50000

DECLARE

STR VARCHAR2(4000);
COL_ID NUMBER;

CURSOR C1 IS SELECT TABLE_NAME FROM DBA_TABLES WHERE OWNER='SEU' AND TABLE_NAME NOT LIKE '%LOG%' 
																								AND TABLE_NAME LIKE 'SEU%' AND TABLE_NAME NOT LIKE '%TMP%' and table_name='SEUADH';

CURSOR C2(TABELA IN VARCHAR2) IS SELECT COLUMN_ID,COLUMN_NAME, DATA_TYPE, DATA_LENGTH FROM DBA_TAB_COLUMNS 
																 WHERE TABLE_NAME=TABELA AND DATA_TYPE<>'BLOB' AND COLUMN_NAME NOT LIKE '%NREG%' 
																 AND COLUMN_NAME NOT LIKE '%IDUSUARIO%' AND OWNER='SEU' ORDER BY COLUMN_ID ;

--TABELA VARCHAR2(100);

BEGIN

	FOR RC1 IN C1 LOOP
	  --TABELA := RC1.TABLE_NAME;
	  STR := 'DROP TABLE SEU.'||RC1.TABLE_NAME||'_LOG';
	  BEGIN
	  	EXECUTE IMMEDIATE STR;
	  EXCEPTION WHEN OTHERS THEN
	  	DBMS_OUTPUT.PUT_LINE('Nao existe a tabela SEU.'||RC1.TABLE_NAME||'_LOG');
	  END;
	  SELECT MIN(COLUMN_ID) INTO COL_ID FROM DBA_TAB_COLUMNS WHERE TABLE_NAME=RC1.TABLE_NAME AND OWNER='SEU'
	  																												AND COLUMN_NAME NOT LIKE '%NREG%' 
	  																												AND COLUMN_NAME NOT LIKE '%IDUSUARIO%'  ;
		STR := 'CREATE TABLE SEU.'||RC1.TABLE_NAME||'_LOG ('||chr(10);
		FOR RC2 IN C2(RC1.TABLE_NAME) LOOP
		  IF RC2.COLUMN_ID <> COL_ID THEN
		  	STR := STR||',';
		  END IF;
			IF RC2.DATA_TYPE='VARCHAR2' OR RC2.DATA_TYPE='CHAR' THEN
				STR := STR||RC2.COLUMN_NAME||'_ANTES '||RC2.DATA_TYPE||'('||RC2.DATA_LENGTH||'), '||chr(10)||
				       RC2.COLUMN_NAME||'_DEPOIS '||RC2.DATA_TYPE||'('||RC2.DATA_LENGTH||')'||chr(10);
			ELSE
				STR := STR||RC2.COLUMN_NAME||'_ANTES '||RC2.DATA_TYPE||','||chr(10)||
				       RC2.COLUMN_NAME||'_DEPOIS '||RC2.DATA_TYPE||chr(10);
			END IF;
		END LOOP;
		STR := STR||', S'||SUBSTR(RC1.TABLE_NAME,4,3)||'_NREG INTEGER, OPERACAO CHAR(1), DATA_HORA DATE, IDUSUARIO VARCHAR2(128))'||chr(10);
		STR := STR||' TABLESPACE SEULOG';
		BEGIN
			EXECUTE IMMEDIATE STR;
			--DBMS_OUTPUT.PUT_LINE(STR);
		EXCEPTION WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Erro na tabela '||rc1.table_name||' '||SQLERRM);
		END;
	END LOOP;
END;
/

				