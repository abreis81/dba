CREATE OR REPLACE PROCEDURE BRDBA.SP_MONITORA_REPLICACAO( v_qt_comparar   IN NUMBER
                                                         ,v_caminho_log   IN VARCHAR2
                                                         ,v_caminho_aviso IN VARCHAR2 ) IS

--*********************************************************************************************
--* Esta procedure tem o objetivo de analisar a replicacao e gerar log dos erros e avisos,    *
--* caso necessario para acao das partes envolvidas                                           *
--* Data de Criação        : 19/08/2000                                                       *
--* Alteração              : 19/08/2000                                                       *
--* Alteracao ( Josivan )  : 04/10/2001                                                       *
--*********************************************************************************************

v_qt_encontrado                NUMBER              := 0;
v_flag_replicando              CHAR(1)             := 'S';
v_flag_db_links                CHAR(1)             := 'S';
v_contador_replicacao          NUMBER(3)           := 0;
v_contador_carga_replicacao    NUMBER(3)           := 0;
v_contador_apoio_replicacao    NUMBER(2)           := 0;
v_contador                     NUMBER              := 0;
v_contador_transacao           NUMBER              := 0;
v_qt_invalidos                 NUMBER              := 0;
v_qt_tab_invalidas	       NUMBER		   := 0;
v_qt_ind_invalidos	       NUMBER		   := 0;
v_enq_tid_anterior             VARCHAR2(30);
v_msg_operador		       VARCHAR2(100)       :='';

v_jobs_broken                  NUMBER(1)           := 0;
v_conexoes_repadmin            NUMBER(3)           := 0;
v_texto_sql                    VARCHAR2(4000)      := NULL;

v_nome_arq_log                 VARCHAR2(30)        := 'log_dba_replicacao.log';
v_nome_arq_aviso               VARCHAR2(30)        := 'aviso_replicacao.txt';

v_texto_log                    VARCHAR2(80);
f_log                          UTL_FILE.FILE_TYPE;
f_aviso                        UTL_FILE.FILE_TYPE;

TYPE    tipo_status_dblink     IS TABLE OF CHAR(3)       INDEX BY BINARY_INTEGER;
TYPE    tipo_dblink            IS TABLE OF VARCHAR2(128) INDEX BY BINARY_INTEGER;

lista_status_dblink            tipo_status_dblink;
lista_dblink                   tipo_dblink;
indice_dblink                  INTEGER             := 0;

v_cursor                       INTEGER;
v_return                       INTEGER;
v_comando_sql                  VARCHAR2(200);

CURSOR C_FILA IS
  SELECT /*+ index (A SYS_C002219) +*/ A.ENQ_TID
    FROM SYSTEM.DEF$_AQCALL A
ORDER BY A.ENQ_TIME;

BEGIN

  -- verifico se os antigos registros ainda estao na fila de replicacao
  v_enq_tid_anterior := 'DIFERENTE';
  v_contador_replicacao := 0;
  v_contador := 0;
  v_contador_apoio_replicacao := 0;

  FOR reg_aqcall IN c_fila LOOP
    -- para cada registro de transacao da fila atual verifico se tenho na tabela de transacoes antigas
    IF v_enq_tid_anterior <> reg_aqcall.enq_tid THEN
       BEGIN
         SELECT COUNT(1) INTO v_contador_apoio_replicacao
           FROM TBDBA_TRANSACAO_REPLICACAO
          WHERE ENQ_TID=reg_aqcall.enq_tid;
         v_contador_replicacao := v_contador_replicacao + v_contador_apoio_replicacao;
       EXCEPTION
         WHEN OTHERS THEN
           NULL;
       END;
       v_contador_apoio_replicacao := 0;
       v_enq_tid_anterior := reg_aqcall.enq_tid;
    ELSE
       v_enq_tid_anterior := reg_aqcall.enq_tid;
    END IF;

    -- se contabilizei 100 registros na tabela, entao saio do loop
    -- ou se contabilizei 2000 vezes o loop em busca de novas transacoes, saio do loop
    IF (v_contador_replicacao > 99) OR (v_contador > 1999) THEN
        EXIT;
    END IF;

    v_contador := v_contador + 1;

  END LOOP;

  -- excluo as transacoes antigas para iniciar nova carga dos 100 registros "mais antigos" da fila atual
  DELETE TBDBA_TRANSACAO_REPLICACAO;

  v_contador_carga_replicacao := 0;
  v_contador := 0;
  v_contador_apoio_replicacao := 0;
  v_enq_tid_anterior := 'DIFERENTE';

  -- bloco identico ao de teste
  FOR reg_aqcall IN c_fila LOOP

    IF v_enq_tid_anterior <> reg_aqcall.enq_tid THEN
       v_contador_carga_replicacao := v_contador_carga_replicacao + 1;
       -- nova carga dos 100 registro "mais antigos" para proxima verificacao
       INSERT INTO TBDBA_TRANSACAO_REPLICACAO(ENQ_TID)
       VALUES(reg_aqcall.enq_tid);
       v_enq_tid_anterior := reg_aqcall.enq_tid;
    ELSE 
       v_enq_tid_anterior := reg_aqcall.enq_tid;
    END IF;

    IF (v_contador_carga_replicacao > 99) OR (v_contador > 1999) THEN
       EXIT;
    END IF;

    v_contador := v_contador + 1;

  END LOOP;

  COMMIT;

  -- vejo se posso contar os registros da fila
  IF v_qt_comparar IS NOT NULL THEN
     -- hint index_ffs usando a PK de PRODUCAO
     SELECT /*+ index_ffs (A SYS_C002219) +*/ COUNT(A.ENQ_TID) INTO v_qt_encontrado
       FROM SYSTEM.DEF$_AQCALL A;
  END IF;

  -- verifico se esta replicando ou nao comparando o contador de encontrados iguais na fila
  -- com o contador da tabela de transacao
  IF v_contador_replicacao <> 0 THEN
     -- parece que esta ferrando !
     v_flag_replicando := 'N';
  END IF;

  -- verifica jobs em broken
  SELECT COUNT(1) INTO v_jobs_broken
    FROM DBA_JOBS
   WHERE SCHEMA_USER='REPADMIN'
     AND BROKEN='Y';

  -- verifica se existe objetos invalidos
  SELECT COUNT(1) INTO v_qt_invalidos
    FROM SYS.DBA_OBJECTS
   WHERE STATUS='INVALID';

  -- verifico quantos dblinks existem para replicacao e se os mesmos estao OK
  BEGIN
    FOR reg_dblink IN (SELECT DBLINK FROM SYSTEM.DEF$_DESTINATION) LOOP

      indice_dblink := indice_dblink + 1;

      BEGIN
        lista_dblink (indice_dblink) := reg_dblink.dblink;
        v_comando_sql := 'SELECT COUNT(*) FROM GLOBAL_NAME@'||reg_dblink.dblink;
        v_cursor := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(v_cursor,v_comando_sql,DBMS_SQL.V7);
        v_return := DBMS_SQL.EXECUTE(v_cursor);
        DBMS_SQL.CLOSE_CURSOR(v_cursor);
        lista_status_dblink (indice_dblink) := 'OK';
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            -- problemas com o dblink, deve ter caido o link !
            lista_status_dblink (indice_dblink) := 'NOK';
            v_flag_db_links := 'N';
          END;
      END;

      DBMS_OUTPUT.PUT_LINE ('dblink : '||reg_dblink.dblink||' status : '||lista_status_dblink(indice_dblink));

    END LOOP;
  END;

  -- verifico conexoes do REPADMIN
  SELECT COUNT(1) INTO v_conexoes_repadmin
    FROM V$SESSION
   WHERE USERNAME='REPADMIN'
     AND STATUS='ACTIVE';

  -- verifico indices invalidos
  SELECT COUNT(1) INTO v_qt_ind_invalidos
    FROM DBA_INDEXES
   WHERE STATUS<>'VALID';

  -- verifica se o ambiente esta ok
  IF v_jobs_broken > 0 OR 
     ( v_conexoes_repadmin = 0 and v_qt_encontrado > 100 ) OR 
     v_flag_db_links='N' OR 
     v_qt_invalidos > 0 OR
     v_qt_ind_invalidos > 0 THEN

     v_flag_replicando := 'N';

     --mensagem para o operador

     IF (v_jobs_broken > 0) THEN 
	v_msg_operador:='jobs em broken';
     ELSIF ( v_conexoes_repadmin = 0 and v_qt_encontrado > 100 ) THEN 
	v_msg_operador:='sessoes do repadmin';
     ELSIF (v_flag_db_links='N') THEN 
	v_msg_operador:='problema nos db_links';
     ELSIF (v_qt_invalidos > 0) THEN 
	v_msg_operador:='objeto_invalido na base';
     ELSIF (v_qt_ind_invalidos > 0) THEN
        v_msg_operador:='indice_invalido na base';
     END IF;

  END IF;

  -- gerar arquivo de log e aviso caso nao esteja replicando
  v_texto_log := to_char (sysdate,'dd/mm/yyyy hh24:mi:ss');
  IF v_flag_replicando = 'N' THEN

     BEGIN

       f_aviso := UTL_FILE.FOPEN(v_caminho_aviso , v_nome_arq_aviso , 'W');
       UTL_FILE.PUT_LINE(f_aviso , v_msg_operador);
       UTL_FILE.FCLOSE(f_aviso);

       f_log := UTL_FILE.FOPEN(v_caminho_log , v_nome_arq_log , 'W');
       UTL_FILE.PUT_LINE(f_log , v_texto_log);
       UTL_FILE.PUT_LINE(f_log , 'Segunda verificacao de restart, e ainda continua no restart!');
       UTL_FILE.PUT_LINE(f_log , 'Nao esta replicando, favor ver log abaixo :');

       IF v_qt_comparar IS NOT NULL AND v_qt_encontrado > v_qt_comparar THEN
          UTL_FILE.PUT_LINE(f_log , 'Ultrapassou a quantidade de registros informada !');
          UTL_FILE.PUT_LINE(f_log , 'Quantidade de registros na fila : '||to_char(v_qt_encontrado));
       END IF;
       UTL_FILE.PUT_LINE(f_log ,   'Jobs em broken                  : '||to_char(v_jobs_broken));
       UTL_FILE.PUT_LINE(f_log ,   'Sessoes do REPADMIN ativas      : '||to_char(v_conexoes_repadmin));
       UTL_FILE.PUT_LINE(f_log ,   'Objetos invalidos               : '||to_char(v_qt_invalidos));
       UTL_FILE.PUT_LINE(f_log ,   'Indices invalidos               : '||to_char(v_qt_ind_invalidos));

       FOR i IN 1..indice_dblink LOOP
           IF lista_status_dblink (i) = 'NOK' THEN
              UTL_FILE.PUT_LINE(f_log ,   'Dblink com problemas            : '||substr(lista_dblink (i),1,30));
           END IF;
       END LOOP;

     END;

     -- teste de output das variaveis
     UTL_FILE.PUT_LINE(f_log,' ');
     UTL_FILE.PUT_LINE(f_log,'****** RESUMO DAS VARIAVES ******');
     UTL_FILE.PUT_LINE(f_log,'v_qt_encontrado              : '||TO_CHAR(v_qt_encontrado));
     UTL_FILE.PUT_LINE(f_log,'v_flag_replicando            : '||v_flag_replicando);
     UTL_FILE.PUT_LINE(f_log,'v_contador_replicacao        : '||TO_CHAR(v_contador_replicacao));
     UTL_FILE.PUT_LINE(f_log,'v_contador_apoio_replicacao  : '||TO_CHAR(v_contador_apoio_replicacao));
     UTL_FILE.PUT_LINE(f_log,'v_jobs_broken                : '||TO_CHAR(v_jobs_broken));
     UTL_FILE.PUT_LINE(f_log,'v_conexoes_repadmin          : '||TO_CHAR(v_conexoes_repadmin));
     UTL_FILE.PUT_LINE(f_log,'v_texto_sql                  : '||NVL(SUBSTR(v_texto_sql,1,80),'NENHUM'));
     UTL_FILE.PUT_LINE(f_log,'v_flag_db_links              : '||v_flag_db_links);
     UTL_FILE.PUT_LINE(f_log,'v_qt_invalidos               : '||v_qt_invalidos);

     FOR i IN 1..indice_dblink LOOP
         IF lista_status_dblink (i) = 'NOK' THEN
            UTL_FILE.PUT_LINE(f_log ,   'Dblink com problemas            : '||substr(lista_dblink (i),1,30));
         END IF;
     END LOOP;

     UTL_FILE.FCLOSE(f_log);

  END IF;

END;
/
SHOW ERRORS
