CREATE OR REPLACE PROCEDURE P_IMP_SCHEMA3 (OWN IN VARCHAR2)
IS

STR VARCHAR2(1000);

	PROCEDURE IMPDP (OWN_NAME IN VARCHAR2, TIPO IN VARCHAR2)
	IS
	  ind NUMBER;              -- Loop index
	  h1 NUMBER;               -- Data Pump job handle
	  h2 NUMBER;               -- Data Pump job handle
	  percent_done NUMBER;     -- Percentage of job complete
	  job_state VARCHAR2(30);  -- To keep track of job state
	  le ku$_LogEntry;         -- For WIP and error messages
	  js ku$_JobStatus;        -- The job status from get_status
	  jd ku$_JobDesc;          -- The job description from get_status
	  sts ku$_Status;          -- The status object returned by get_status
	  output clob;
	BEGIN
	  
	  IF tipo = 'DADOS' then
	  	h1 := DBMS_DATAPUMP.OPEN('IMPORT','TABLE','DB','REFRESH_'||OWN_NAME);
	
	  	dbms_datapump.metadata_filter(h1,'SCHEMA_EXPR','IN ('||''''||OWN_NAME||''''||')');
    	dbms_datapump.metadata_filter(h1,'NAME_EXPR','NOT LIKE ''%LOG%''');
    	dbms_datapump.metadata_filter(h1,'NAME_EXPR','NOT IN (''SEUAAF'',''SEUAAG'',''SEUAAH'',''SEUAAJ'',''SEUAAB'',''SEUAAC'',''SEUACL'',''SEUACM'',''SEUACN'',''SEUAAD'',''SEUADZ'',''SEUAAE'')');
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
	  END IF;
	  
	  IF tipo = 'SEQUENCES' then
	  	h2 := DBMS_DATAPUMP.OPEN('IMPORT','SCHEMA','DB','REFRESH_SEQ_'||OWN_NAME);
	  	dbms_datapump.metadata_filter(h2,'SCHEMA_EXPR','IN ('||''''||OWN_NAME||''''||')');
	  	dbms_datapump.metadata_filter(h2,'INCLUDE_PATH_EXPR','IN (''SEQUENCE'')');
	  	
	  	DBMS_DATAPUMP.START_JOB(h2);
	
	 
	 		percent_done := 0;
	  	job_state := 'UNDEFINED';
	  	while (job_state != 'COMPLETED') and (job_state != 'STOPPED') loop
	    	dbms_datapump.get_status(h2,
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
	  	dbms_datapump.detach(h2);
	  	insert into dbarodrigob.impdp_log values (SYS_CONTEXT('USERENV','OS_USER')
	  																				  ,SYS_CONTEXT('USERENV','SESSION_USER')
	  																				  ,SYS_CONTEXT('USERENV','TERMINAL')
	  																				  ,output);
	  	commit;
	  END IF;
	END;
	
	PROCEDURE SENDMAIL (Recipiente in varchar2, Enviar in varchar2,erro in varchar2)
	is
	
	Hostmail Varchar2(40);
	Conexao UTL_SMTP.CONNECTION;
	Mensagem Varchar2(500);
	Msg Varchar2(500);
	PHI Number;
	att1 varchar2(150);
	l_document VARCHAR2(32000) := '';
	crlf VARCHAR2( 2 ):= CHR( 13 ) || CHR( 10 );
	
	Begin
	msg := 'From:'||Recipiente|| crlf
	||'Subject: Erro no processo de atualizacao do SEU Homol.' || crlf
	||'To: '||enviar || crlf
	||'' || crlf
	||' Ocorreu erro na importacao: '||erro||'. Verificar o Log de importacao do SEU na DB2 em DBARODRIGOB.IMPDP_LOG ';
	Hostmail := '10.160.0.215';
	Mensagem := msg;
	Conexao := Utl_Smtp.Open_Connection (Hostmail,25);
	Utl_Smtp.Helo (Conexao, Hostmail);
	Utl_Smtp.Mail (Conexao, recipiente);
	Utl_Smtp.Rcpt (Conexao, enviar);
	Utl_Smtp.Data (Conexao, Mensagem);
	Utl_Smtp.Quit (Conexao);
	End;

BEGIN
  STR := 'TRUNCATE TABLE DBARODRIGOB.IMPDP_LOG';
  EXECUTE IMMEDIATE STR;
  
	IF OWN <> 'SEU' THEN
	  DBMS_OUTPUT.PUT_LINE('O schema '||OWN||' nao e permitido, somente SEU ');
	ELSE
		FOR RC1 IN (SELECT SEQUENCE_NAME 
								FROM DBA_SEQUENCES a WHERE SEQUENCE_OWNER=OWN AND SEQUENCE_NAME NOT IN 
								('SEQ_SEUAAF_INSERT','SEQ_SEUAAG_INSERT','SEQ_SEUAAH_INSERT','SEQ_SEUAAJ_INSERT','SEQ_SEUAAB_INSERT','SEQ_SEUAAC_INSERT','SEQ_SEUACL_INSERT','SEQ_SEUACM_INSERT','SEQ_SEUACN_INSERT','SEQ_SEUAAD_INSERT','SEQ_SEUADZ_INSERT','SEQ_SEUAAE_INSERT',
								'SEQ_SEUAAF_CODIGO','SEQ_SEUAAG_CODIGO','SEQ_SEUAAH_CODIGO','SEQ_SEUAAJ_CODIGO','SEQ_SEUAAB_CODIGO','SEQ_SEUAAC_CODIGO','SEQ_SEUACL_CODIGO','SEQ_SEUACM_CODIGO','SEQ_SEUACN_CODIGO','SEQ_SEUAAD_CODIGO','SEQ_SEUADZ_CODIGO','SEQ_SEUAAE_CODIGO',
								'SEQ_SEUAAF_IDROTINA','SEQ_SEUAAG_IDROTINA','SEQ_SEUAAH_IDROTINA','SEQ_SEUAAJ_IDROTINA','SEQ_SEUAAB_IDROTINA','SEQ_SEUAAC_IDROTINA','SEQ_SEUACL_IDROTINA','SEQ_SEUACM_IDROTINA','SEQ_SEUACN_IDROTINA','SEQ_SEUAAD_IDROTINA','SEQ_SEUADZ_IDROTINA','SEQ_SEUAAE_IDROTINA')
								and exists (select 'x' from dba_sequences@db b where b.sequence_owner=a.sequence_owner and b.sequence_name=a.sequence_name)) LOOP
			STR := 'DROP SEQUENCE '||OWN||'.'||RC1.SEQUENCE_NAME;
			EXECUTE IMMEDIATE STR;
		END LOOP;
		
		FOR RC2 IN (SELECT TABLE_NAME, CONSTRAINT_NAME 
								FROM DBA_CONSTRAINTS WHERE OWNER=OWN AND CONSTRAINT_TYPE='R') LOOP
			STR := 'ALTER TABLE '||OWN||'.'||RC2.TABLE_NAME||' DROP CONSTRAINT '||RC2.CONSTRAINT_NAME;
			EXECUTE IMMEDIATE STR;
		END LOOP;
		STR := 'ALTER USER SYS DEFAULT TABLESPACE USERS';
		EXECUTE IMMEDIATE STR;
		BEGIN
			IMPDP(OWN,'DADOS');
			IMPDP(OWN,'SEQUENCES');
		EXCEPTION WHEN OTHERS THEN
			SENDMAIL('rodrigob@uninove.br','rodrigob@uninove.br',sqlerrm);
		END;
		EXECUTE IMMEDIATE 'ALTER TABLE "SEU"."SEUAAG" ADD CONSTRAINT "FK_SEUAAG_SEUAAF" FOREIGN KEY ("SAAG_IDMENU") REFERENCES "SEU"."SEUAAF" ("SAAF_IDMENU") ENABLE';
		EXECUTE IMMEDIATE 'ALTER TABLE "SEU"."SEUAAE" ADD CONSTRAINT "FK_SEUAAE_SEUADZ" FOREIGN KEY ("SAAE_IDUSUARIO", "SAAE_IDEMPRESA") REFERENCES "SEU"."SEUADZ" ("SADZ_IDUSUARIO", "SADZ_IDEMPRESA") ENABLE';
		EXECUTE IMMEDIATE 'ALTER TABLE "SEU"."SEUAAE" ADD CONSTRAINT "FK_SEUAAE_SEUAAA" FOREIGN KEY ("SAAE_IDEMPRESA") REFERENCES "SEU"."SEUAAA" ("SAAA_IDEMPRESA") ENABLE';
		EXECUTE IMMEDIATE 'ALTER TABLE "SEU"."SEUAAC" ADD CONSTRAINT "FK_SEUAAC_SEUAAB" FOREIGN KEY ("SAAC_TABELA") REFERENCES "SEU"."SEUAAB" ("SAAB_TABELA") ENABLE';
		EXECUTE IMMEDIATE 'ALTER TABLE "SEU"."SEUADZ" ADD CONSTRAINT "FK_SEUADZ_SEUAAA" FOREIGN KEY ("SADZ_IDEMPRESA") REFERENCES "SEU"."SEUAAA" ("SAAA_IDEMPRESA") ENABLE';
		STR := 'ALTER USER SYS DEFAULT TABLESPACE SYSTEM';
		EXECUTE IMMEDIATE STR;
	END IF;
	P_UTL_RECOMP;
END;
/