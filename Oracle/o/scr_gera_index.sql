DECLARE 

CURSOR C_INDEX IS
  SELECT *
    FROM DBA_INDEXES
   WHERE OWNER='TLMK'
	ORDER BY OWNER
		,TABLE_NAME
		,INDEX_NAME;

 CURSOR C_COLS( PE_TABELA   VARCHAR2
               ,PE_INDEX    VARCHAR2 ) IS
   SELECT *
     FROM DBA_IND_COLUMNS
    WHERE TABLE_NAME=PE_TABELA
      AND INDEX_NAME=PE_INDEX
 ORDER BY INDEX_OWNER
	 ,TABLE_NAME
         ,INDEX_NAME
         ,COLUMN_POSITION;


v_colunas    VARCHAR2(300);

BEGIN

  FOR RC_INDEX IN C_INDEX LOOP

      v_colunas := '';
      DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('DROP INDEX '||RC_INDEX.OWNER||'.'||RC_INDEX.INDEX_NAME||';');
      FOR RC_COLS IN C_COLS( RC_INDEX.TABLE_NAME, RC_INDEX.INDEX_NAME ) LOOP

          IF RC_COLS.COLUMN_POSITION = 1 THEN         
             v_colunas := RC_COLS.COLUMN_NAME;
          ELSE
             v_colunas := v_colunas ||','||RC_COLS.COLUMN_NAME;
          END IF;

      END LOOP;

      DBMS_OUTPUT.PUT_LINE('CREATE INDEX '||RC_INDEX.OWNER||'.'||RC_INDEX.INDEX_NAME||' ON '
         ||RC_INDEX.OWNER||'.'||RC_INDEX.TABLE_NAME||'('||v_colunas||')'
         ||' PCTFREE '||RC_INDEX.PCT_FREE
         ||' TABLESPACE '||RC_INDEX.TABLESPACE_NAME
         ||' STORAGE( INITIAL '||RC_INDEX.INITIAL_EXTENT
         ||' NEXT '||RC_INDEX.NEXT_EXTENT
         ||' MINEXTENTS '||RC_INDEX.MIN_EXTENTS
         ||' PCTINCREASE '||RC_INDEX.PCT_INCREASE
         ||' MAXEXTENTS unlimited )'
         ||' NOLOGGING; ');


  END LOOP;

END;
/
