SET ARRAYSIZE 1 
SET FEEDBACK off 
SET SERVEROUT on 
SET PAGESIZE 66 
SET NEWPAGE 6 
SET LINESIZE 75 
SET PAUSE off 
SET VERIFY off 
--ACCEPT puser PROMPT 'Enter the schema name: ' 
ACCEPT pexcp PROMPT 'Enter the EXCEPTIONS table name for schema &puser: ' 
PROMPT 'NOTE: This will take some time, please wait...' 
 
SPOOL schema_cons.sql
DECLARE 
	CURSOR cons_cur (v_userid VARCHAR2) IS 
	  SELECT * FROM dba_constraints 
	  WHERE owner = v_userid 
	    AND constraint_type in ('P','U','C','R') 
	  ORDER BY constraint_type; 
	CURSOR col_cur (con_name VARCHAR2, con_owner VARCHAR2) IS 
	  SELECT * FROM dba_cons_columns 
	  WHERE owner = con_owner 
	    AND constraint_name = con_name 
	  ORDER BY position; 
	CURSOR indx_cur (con_name VARCHAR2, ind_own VARCHAR2) IS 
	  SELECT a.* 
	  FROM dba_indexes a, dba_ind_columns b, dba_cons_columns c 
	  WHERE c.constraint_name = con_name 
            AND a.owner = ind_own 
         AND b.index_owner = ind_own 
	    AND c.owner = b.index_owner 
	    AND c.position = 1 
	    AND c.table_name = b.table_name 
	    AND c.column_name = b.column_name 
	    AND b.index_name = a.index_name; 
	CURSOR C_OWNER IS SELECT USERNAME FROM DBA_USERS WHERE USERNAME NOT IN ('SYS','SYSTEM','MTSSYS','XDB','DBA_CPM','BENE');
	col_str	VARCHAR2(200); 
	v_output	VARCHAR2(480);    -- max of 16 cols at 30 chars each 
        v_excp          NUMBER(1) := 0; 
        v_excptab VARCHAR2(60) := NULL; 
	v_delrule	VARCHAR2(4); 
	v_status	VARCHAR2(4); 
	srch_cond	VARCHAR2(1000); 
	v_errcode       NUMBER := 0; 
        v_errmsg        varchar2(50) := ' '; 
BEGIN 
  DBMS_OUTPUT.ENABLE(1000000);         -- Prevents buffer exceeded error 
  BEGIN 
     v_excptab := UPPER('&pexcp'); 
     IF v_excptab IS NOT NULL THEN 
        SELECT 1 
          INTO v_excp 
        FROM dba_objects 
 WHERE owner = UPPER('ABC') 
        AND   object_name = UPPER('&pexcp'); 
    v_excptab := 'EXCEPTIONS INTO '||LOWER('&pexcp'); 
     END IF; 
     EXCEPTION 
     WHEN NO_DATA_FOUND THEN 
     DBMS_OUTPUT.PUT_LINE('Exceptions table does not exist in the schema: '); 
     RAISE NO_DATA_FOUND; 
  END;
  FOR R_OWNER IN C_OWNER LOOP
  FOR c1 IN cons_cur(R_OWNER.USERNAME) LOOP 
   begin 
    srch_cond := substr(c1.search_condition,1,length(c1.search_condition)); 
    -- Dont remove table constraint NOT NULL 
    IF (instr(srch_cond,'NOT NULL') < 1) or 
       (instr(srch_cond,'NOT NULL') IS NULL) THEN 
     BEGIN 
      DBMS_OUTPUT.PUT_LINE('ALTER TABLE '||C1.OWNER||'.'||C1.TABLE_NAME); 
      DBMS_OUTPUT.PUT_LINE('  ADD (CONSTRAINT '||C1.CONSTRAINT_NAME); 
 
      IF c1.constraint_type = 'P' THEN v_output := '    PRIMARY KEY ('; 
      ELSIF c1.constraint_type = 'R' THEN v_output := '    FOREIGN KEY ('; 
    ELSIF c1.constraint_type = 'U' THEN v_output := '    UNIQUE ('; 
      ELSIF c1.constraint_type = 'C' THEN 
         v_output := '    CHECK ('||c1.search_condition||') '||v_excptab; 
      END IF; 
 
      FOR c2 IN col_cur(c1.constraint_name, c1.owner) LOOP 
	IF c2.position = 1 THEN 
	  v_output := v_output||c2.column_name; 
	ELSIF c2.position > 1 THEN 
	  v_output := v_output||', '||c2.column_name; 
	END IF; 
      END LOOP; 
      v_output := v_output||')';  
      DBMS_OUTPUT.PUT_LINE(v_output); 
      IF c1.constraint_type = 'R' THEN 
	v_output := NULL; 
	FOR c3 IN col_cur(c1.r_constraint_name, c1.r_owner) LOOP 
	  IF c3.position = 1 THEN 
	    v_output := '    REFERENCES '||c3.owner||'.'||c3.table_name||'('; 
	    v_output := v_output||c3.column_name; 
	  ELSIF c3.position > 1 THEN 
	    v_output := v_output||', '||c3.column_name; 
	  END IF; 
	END LOOP; 
	v_output := v_output||')'; 
        DBMS_OUTPUT.PUT_LINE(v_output); 
	v_delrule := substr(c1.delete_rule,1,2); 
	IF v_delrule IS NULL THEN v_output := v_excptab ||  ' )'; 
	ELSIF v_delrule = 'NO' THEN v_output :=  v_excptab || ' )'; 
	ELSIF v_delrule = 'CA' THEN v_output := ' ON DELETE CASCADE  
'||v_excptab 
 || ')'; 
	END IF; 
        DBMS_OUTPUT.PUT_LINE(v_output); 
      END IF; 
 
      FOR c4 IN indx_cur(c1.constraint_name, c1.owner) LOOP 
	IF c1.constraint_type in ('P','U') THEN 
          DBMS_OUTPUT.PUT_LINE(' USING INDEX ');   
	  DBMS_OUTPUT.PUT_LINE('   pctfree       '||c4.pct_free); 
	  DBMS_OUTPUT.PUT_LINE('   initrans      '||c4.ini_trans); 
	  DBMS_OUTPUT.PUT_LINE('   maxtrans      '||c4.max_trans); 
	  DBMS_OUTPUT.PUT_LINE('   tablespace    '||c4.tablespace_name); 
	  DBMS_OUTPUT.PUT_LINE(' Storage ('); 
	  DBMS_OUTPUT.PUT_LINE('   initial        '||c4.initial_extent); 
	  DBMS_OUTPUT.PUT_LINE('   next           '||c4.next_extent); 
	  DBMS_OUTPUT.PUT_LINE('   minextents'||c4.min_extents); 
	  DBMS_OUTPUT.PUT_LINE('   maxextents     '||c4.max_extents); 
	  DBMS_OUTPUT.PUT_LINE('   pctincrease    '||c4.pct_increase||') '|| 
v_excptab ||')');  
 
	END IF; 
      END LOOP; 
 
      v_output := NULL; 
      v_status := substr(c1.status,1,1); 
      IF v_status = 'E' THEN  
      v_output := ' REM This constraint '||c1.constraint_name||' was ENABLED'; 
      ELSIF v_status = 'D' THEN  
      v_output :=' REM This constraint '||c1.constraint_name ||' was  
DISABLED';  
      END IF; 
      DBMS_OUTPUT.PUT_LINE('/ '); 
      DBMS_OUTPUT.PUT_LINE(v_output); 
      DBMS_OUTPUT.PUT_LINE('-------------------------------------------- '); 
      DBMS_OUTPUT.PUT_LINE('  '); 
     END; 
   END IF; 
   EXCEPTION 
     WHEN no_data_found THEN 
       DBMS_OUTPUT.PUT_LINE('No Data Found'); 
     WHEN others THEN 
       v_errcode := sqlcode; 
       v_errmsg := SUBSTR(sqlerrm, 1, 50); 
       DBMS_OUTPUT.PUT_LINE('ERROR: '||v_errcode||': ' || v_errmsg); 
    DBMS_OUTPUT.PUT_LINE(c1.constraint_name||' '||c1.constraint_type); 
       DBMS_OUTPUT.PUT_LINE(c1.search_condition); 
   END; 
  END LOOP;
END LOOP;
  NULL; 
END; 
/ 
SPOOL off 
SET PAGESIZE 14 
SET FEEDBACK on 
SET NEWPAGE 0 
SET ARRAYSIZE 20 
SET SERVEROUT off 
SET LINESIZE 79 
SET VERIFY on 
 