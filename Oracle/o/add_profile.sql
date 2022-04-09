/*
  script:   add_profile.sql
  objetivo: criar uma nova profile
  autor:    Josivan
  data:     
  Bibliotecas:
    DBA_PROFILES                      - todos os perfis do banco
    DBA_USERS  ( parametro profile )  - profile que o usuario esta ligado
    USER_RESOURCE_LIMITS              - todos os limites de recursos e valores
    SYS.RESOURCE_MAP                  - nome de todos os limites
    SYS.RESOURCE_COST                 - peso de cada recurso na composicao do limite parametro: COMPOSIT_LIMIT

  Observacao: ALTERAR O INIT.ORA PARAMETRO PARA: RESOURCE_LIMIT=TRUE   OU
              ALTER SYSTEM RESOURCE_LIMIT=TRUE

  Parametros:

  SESSIONS_PER_USER           - QUANTIDADE DE SESSAO POR USUARIO
  CPU_PER_SESSION             - TEMPO DE CPU POR SESSAO EM CENTESIMOS DE SEGUNDOS
  CPU_PER_CALL                - TEMPO MAXIMO DE CPU QUE UMA INSTRUCAO PODE USAR
  CONNECT_TIME                - TEMPO MAXIMO QUE CADA SESSAO PODE DEMORAR
  IDLE_TIME                   - TEMPO MAXIMO DE INATIVIDADE QUE UMA SESSAO PODE FICAR (MINITUS)
  LOGICAL_READS_PER_SESSION   - NUMERO TOTAL DE BLOCOS LIDOS EM TODA A DURACAO DA SESSAO ( MEMORIA E DISCO )
  LOGICAL_READS_PER_CALL      - NUMERO TOTAL DE BLOCOS DE DADOS LIDOS NUMA INSTRUCAO ( BLOCOS )
  PRIVATE_SGA                 - ESPACO MAXIMO PRIVADO NA SGA QUE UMA SESSAO PODE USAR QDO A CONFIGURACAO FOR MTS
  COMPOSITE_LIMIT             - ATRIBUI UM VALOR MAXIMO PARA UMA COMBINACAO DE PARAMETROS:
                                 EX:

                                  COMPOSIT_LIMIT = (K1*CPU_PER_SESSION) +
                                                   (K2*CONNECT_TIME) +
                                                   (K3*LOGICAL_READS_PER_SESSION) +
                                                   (K4*PRIVATE_SGA);

                                  ALTER RESOURCE COST CPU_PER_SESSION 30
                                                 CONNECT_TIME 2
                                                 LOGICAL_READS_PER_SESSION 1
                                                 PRIVATE_SGA 1;

  VER O ARQUIVO PASSWORDS.SQL


*/


CREATE PROFILE prof_operador
  LIMIT
  SESSIONS_PER_USER           1
  CPU_PER_SESSION             UNLIMITED 
  CPU_PER_CALL                UNLIMITED 
  CONNECT_TIME                20
  IDLE_TIME                   UNLIMITED
  LOGICAL_READS_PER_SESSION   UNLIMITED 
  LOGICAL_READS_PER_CALL      UNLIMITED
  COMPOSITE_LIMIT             UNLIMITED
  PRIVATE_SGA                 UNLIMITED
/


CREATE PROFILE PROF_HELPDESK
       LIMIT 
       SESSIONS_PER_USER              1 
       CPU_PER_SESSION                DEFAULT
       CPU_PER_CALL                   DEFAULT
       CONNECT_TIME                   DEFAULT
       IDLE_TIME                      30
       LOGICAL_READS_PER_SESSION      DEFAULT
       LOGICAL_READS_PER_CALL         DEFAULT
       COMPOSITE_LIMIT                DEFAULT
       PRIVATE_SGA                    DEFAULT
/

DROP PROFILE PROF_HELPDESK CASCADE
/
