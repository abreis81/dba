CREATE OR REPLACE PROCEDURE SEU.P_CRIA_INCREMENTO2 (TABELA IN VARCHAR2)
IS

	cursor c1 is select table_name from user_tables where table_name = upper(tabela);
	str varchar2(2000);

BEGIN

	for rc1 in c1 loop
		BEGIN
			STR := 'CREATE SEQUENCE SEU.SEQ_'||rc1.table_name||'_INSERT NOCYCLE NOORDER NOCACHE MAXVALUE 9999999999 MINVALUE 1 INCREMENT BY 1 START WITH 1';
			execute immediate str;
			str := 'grant select on SEU.SEQ_'||rc1.table_name||'_INSERT to r_seu_all';
			execute immediate str;
			
			begin
				str := 'CREATE OR REPLACE TRIGGER SEU.TRG_'||RC1.TABLE_NAME||'_INCR_I BEFORE'||CHR(10)
							 ||'INSERT ON SEU.'||RC1.TABLE_NAME||' REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW '||CHR(10)
							 ||'BEGIN'||CHR(10)
							 ||'SELECT SEQ_'||RC1.TABLE_NAME||'_INSERT.NEXTVAL'||CHR(10)
							 ||'INTO :new.S'||SUBSTR(RC1.TABLE_NAME,4,3)||'_NREG'||CHR(10)
							 ||'FROM DUAL;'||CHR(10)
							 ||'END;';
				EXECUTE IMMEDIATE STR;
			EXCEPTION WHEN OTHERS THEN
					RAISE_APPLICATION_ERROR(-20999,'ERRO AO CRIAR TRIGGER NA TABELA '||RC1.TABLE_NAME||' '||sqlerrm);
			END;
		EXCEPTION WHEN OTHERS THEN
				RAISE_APPLICATION_ERROR(-20999,'ERRO AO CRIAR SEQUENCE NA TABELA '||RC1.TABLE_NAME||' '||sqlerrm);
		END;
	END LOOP;

End;
/