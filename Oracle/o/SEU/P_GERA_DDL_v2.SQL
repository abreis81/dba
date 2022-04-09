CREATE OR REPLACE PROCEDURE SEU.P_GERA_DDL (tab in varchar2)
IS

	ddl_tabela varchar2(4000);
	ddl_indice varchar2(4000);
	ddl_trigger varchar2(4000);
	ddl_sequence1 varchar2(4000);
	ddl_sequence2 varchar2(4000);
	str varchar2(1000);
	--type v_indice is table of varchar2(4000) index by binary_integer;
	--ddl_indice v_indice;
	num number :=1;
	
BEGIN
  DELETE APLIC.DDL_INDICE;
  DELETE APLIC.DDL_TABELA;
  DELETE APLIC.DDL_SEQUENCE;
  DELETE APLIC.DDL_TRIGGER;
	SELECT DBMS_METADATA.GET_DDL('TABLE',UPPER(tab),'SEU') into ddl_tabela FROM DUAL;
	INSERT INTO APLIC.ddl_tabela values ('SEU',UPPER(tab),ddl_tabela);
	SELECT DBMS_METADATA.GET_DDL('TABLE',UPPER(tab)||'_LOG','SEU') into ddl_tabela FROM DUAL;
	INSERT INTO APLIC.ddl_tabela values ('SEU',UPPER(tab)||'_LOG',ddl_tabela);
	FOR RC1 IN (SELECT INDEX_NAME FROM USER_INDEXES WHERE TABLE_NAME=UPPER(tab))
	LOOP
		SELECT DBMS_METADATA.GET_DDL('INDEX',rc1.index_name,'SEU') INTO ddl_indice FROM DUAL;
		INSERT INTO APLIC.DDL_INDICE VALUES ('SEU',UPPER(tab),rc1.index_name,ddl_indice); 
	END LOOP;
	FOR RC2 IN (SELECT SEQUENCE_NAME FROM USER_SEQUENCES WHERE SEQUENCE_NAME LIKE UPPER('%'||tab||'%'))
	LOOP
		SELECT DBMS_METADATA.GET_DDL('SEQUENCE',rc2.SEQUENCE_NAME,'SEU') INTO ddl_sequence1 FROM DUAL;
		SELECT REGEXP_REPLACE(ddl_sequence1,'START WITH [0-9]++','START WITH 1') INTO ddl_sequence2 from dual;
		INSERT INTO APLIC.DDL_SEQUENCE VALUES ('SEU',UPPER(tab),rc2.sequence_name,ddl_sequence2); 
	END LOOP;
	FOR RC3 IN (SELECT TRIGGER_NAME FROM USER_TRIGGERS WHERE TABLE_NAME=UPPER(tab))
	LOOP
		SELECT REPLACE(DBMS_METADATA.GET_DDL('TRIGGER',rc3.TRIGGER_NAME,'SEU'),'ALTER TRIGGER "SEU"."'||RC3.TRIGGER_NAME||'" ENABLE','')
		INTO ddl_trigger FROM DUAL;
		INSERT INTO APLIC.DDL_TRIGGER VALUES ('SEU',UPPER(tab),rc3.trigger_name,ddl_trigger); 
	END LOOP;
	COMMIT;
END;
/
	
			   