CREATE OR REPLACE PROCEDURE P_IMP_SCHEMA (OWN IN VARCHAR2)
IS

STR VARCHAR2(1000);

	PROCEDURE IMPDP (OWN_NAME IN VARCHAR2)
	IS
	  ind NUMBER;              -- Loop index
	  h1 NUMBER;               -- Data Pump job handle
	  percent_done NUMBER;     -- Percentage of job complete
	  job_state VARCHAR2(30);  -- To keep track of job state
	  le ku$_LogEntry;         -- For WIP and error messages
	  js ku$_JobStatus;        -- The job status from get_status
	  jd ku$_JobDesc;          -- The job description from get_status
	  sts ku$_Status;          -- The status object returned by get_status
	  output clob;
	BEGIN
	
	  h1 := DBMS_DATAPUMP.OPEN('IMPORT','SCHEMA','DB','REFRESH_'||OWN_NAME);
	
	  dbms_datapump.metadata_filter(h1,'SCHEMA_EXPR','IN ('||''''||OWN_NAME||''''||')');
	  dbms_datapump.metadata_filter(h1,'EXCLUDE_PATH_EXPR','IN (''PROCEDURE'',''FUNCTION'')');

	  DBMS_DATAPUMP.SET_PARAMETER(h1,'TABLE_EXISTS_ACTION','REPLACE');
	

	  DBMS_DATAPUMP.START_JOB(h1);
	
	 
	 percent_done := 0;
	  job_state := 'UNDEFINED';
	  while (job_state != 'COMPLETED') and (job_state != 'STOPPED') loop
	    dbms_datapump.get_status(h1,
	           dbms_datapump.ku$_status_job_error +
	           dbms_datapump.ku$_status_job_status +
	           dbms_datapump.ku$_status_wip,-1,job_state,sts);
	    js := sts.job_status;
	
	-- If the percentage done changed, display the new value.
	
	     if js.percent_done != percent_done
	    then
	      dbms_output.put_line('*** Job percent done = ' ||
	                           to_char(js.percent_done));
	      percent_done := js.percent_done;
	    end if;
	
	-- If any work-in-progress (WIP) or Error messages were received for the job,
	-- display them.
	
	       if (bitand(sts.mask,dbms_datapump.ku$_status_wip) != 0)
	    then
	      le := sts.wip;
	    else
	      if (bitand(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
	      then
	        le := sts.error;
	      else
	        le := null;
	      end if;
	    end if;
	    if le is not null
	    then
	      ind := le.FIRST;
	      while ind is not null loop
	        dbms_output.put_line(le(ind).LogText);
	        output := output||chr(10)||le(ind).LogText;
	        ind := le.NEXT(ind);
	      end loop;
	    end if;
	  end loop;
	
	-- Indicate that the job finished and gracefully detach from it. 
	
	  dbms_output.put_line('Job has completed');
	  dbms_output.put_line('Final job state = ' || job_state);
	  dbms_datapump.detach(h1);
	  insert into dbarodrigob.impdp_log values (SYS_CONTEXT('USERENV','OS_USER')
	  																				  ,SYS_CONTEXT('USERENV','SESSION_USER')
	  																				  ,SYS_CONTEXT('USERENV','TERMINAL')
	  																				  ,output);
	  commit;
	END;

BEGIN

	IF OWN <> 'SEU' OR OWN <> 'SEUMIG' THEN
	  DBMS_OUTPUT.PUT_LINE('O schema '||OWN||' nao e permitido, somente SEU ou SEUMIG');
	ELSE
		--FOR RC1 IN (SELECT SEQUENCE_NAME 
		--						FROM DBA_SEQUENCES WHERE SEQUENCE_OWNER=OWN) LOOP
		--	STR := 'DROP SEQUENCE '||OWN||'.'||RC1.SEQUENCE_NAME;
		--	EXECUTE IMMEDIATE STR;
		--END LOOP;
		--
		--FOR RC2 IN (SELECT TABLE_NAME, CONSTRAINT_NAME 
		--						FROM DBA_CONSTRAINTS WHERE OWNER=OWN AND CONSTRAINT_TYPE='R') LOOP
		--	STR := 'ALTER TABLE '||OWN||'.'||RC2.TABLE_NAME||' DROP CONSTRAINT '||RC2.CONSTRAINT_NAME;
		--	EXECUTE IMMEDIATE STR;
		-- END LOOP;
		-- STR := 'ALTER USER SYS DEFAULT TABLESPACE USERS';
		-- EXECUTE IMMEDIATE STR;
		-- IMPDP(OWN);
		-- STR := 'ALTER USER SYS DEFAULT TABLESPACE SYSTEM';
		-- EXECUTE IMMEDIATE STR;
		null;
	END IF;
END;
/