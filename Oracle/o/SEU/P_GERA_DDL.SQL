CREATE OR REPLACE PROCEDURE SEU.P_GERA_DDL (tab in varchar2)
IS

	ddl_tabela varchar2(4000);
	ddl_indice varchar2(4000);
	str varchar2(1000);
	--type v_indice is table of varchar2(4000) index by binary_integer;
	--ddl_indice v_indice;
	num number :=1;
	
BEGIN
  DELETE APLIC.DDL_INDICE;
  DELETE APLIC.DDL_TABELA;
	SELECT DBMS_METADATA.GET_DDL('TABLE',UPPER(tab),'SEU') into ddl_tabela FROM DUAL;
	INSERT INTO APLIC.ddl_tabela values ('SEU',UPPER(tab),ddl_tabela);
	
	FOR RC1 IN (SELECT INDEX_NAME FROM USER_INDEXES WHERE TABLE_NAME=UPPER(tab))
	LOOP
	SELECT DBMS_METADATA.GET_DDL('INDEX',rc1.index_name,'SEU') INTO ddl_indice FROM DUAL;
	INSERT INTO APLIC.DDL_INDICE VALUES ('SEU',UPPER(tab),rc1.index_name,ddl_indice); 
	END LOOP;
	COMMIT;
END;
/
	
			   