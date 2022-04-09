/*
  script:   add_tablespace.sql
  objetivo: criar tablespaces
  autor:    Josivan
  data:     
*/

create tablespace ts_hlp_dados1
       datafile '/producao/cortbl1/ts_hlp_dados1.dbf' size 100m
autoextend on next 20m 
           maxsize 140m
default storage (	initial 500k
               minextents 20
                     next 500k
              pctincrease 1 );



Obs: é recomendado que o PCT_INCREASE da tablespace seja diferente de 0, por exemplo
     1%, isso ativará o servico SMON para fazer automaticamente o COALESCE


-- outros parametros para criar tablespaces
MINIMUM EXTENT          - modo explicito de assegurar um valor padrao para os extents
LOGGING | NOLOGGING     - valor padrao eh LOGGING, indica se determinadas operacoes com objetos
                          da TS irá ser registrada no REDO LOGFILES. NOLOGGING nao registrara nada
PERMANENT | TEMPORARY   - valor padrao eh PERMANENT 
ONLINE | OFFLINE        - valor padrao eh ONLINE

EXTENT MANAGEMENT LOCAL 
UNIFORM SIZE 10M        - tablespace gerenciada localmente ( clausula LOCAL, isto ocorre devido
                          o oracle gravar um bitmap em cada datafile. A clausula UNIFORM SIZE 
                          garante extensoes padroes. )

obs: se for especificado LOCAL nao podera usar DEFAULT STORAGE, MINIMUM_EXTENT ou TEMPORARY

-- ALTERACAO DE TABLESPACES
ALTER TABLESPACE DADOS
ADD DATAFILE '/db/oradata/ocpe/dados/d11ocpe.dbf' size 50m;

ALTER TABLESPACE DADOS
RENAME DATAFILE '/db/oradata/ocpe/dados/d11ocpe.dbf' TO '/db/oradata/ocpe/dados/d12ocpe.dbf'

ALTER TABLESPACE DADOS COALESCE;

ALTER TABLESPACE DADOS BEGIN BACKUP;

ALTER TABLESPACE DADOS END BACKUP;

ALTER TABLESPACE DADOS NOLOGGING | LOGGING

ALTER TABLESPACE TEMP TEMPORARY | PERMANENT

ALTER TABLESPACE DADOS
DEFAULT STORAGE( INITIAL 500K );

ALTER TABLESPACE DADOS
DEFAULT STORAGE( NEXT 500K
           MAXEXTENTS 300 );

ALTER TABLESPACE DADOS READ ONLY | READ WRITE
         
DROP TABLESPACE TS_DADOS INCLUDING CONTENTS;

-----------------------------------------------------------------------------------------------
CENARIO: 0.1  Necessidade de mover um datafile para outro filesystem ou renomea-lo. Este processo
nao caracteriza propriamente um cenario de falha, mas achei importante documentar.

1-Iniciar a base de dados 

  1.1- export ORACLE_SID=oratst
  1.2- STARTUP 

2-Colocar a tablespace em OFFLINE

  ALTER TABLESPACE TS_DADOS OFFLINE;

3-Copiar o datafile para o novo filesystem ou copiar o datafile com o novo nome

  cp idx_tst01.dbf idx_tst90.dbf;

4-Alterar o datafile de filesystem ou renomear

  MOVER
  =====
  ALTER TABLESPACE TS_DADOS 
  RENAME DATAFILE '/appsdes/oracle/oradata/oratst/idx_tst01.dbf' TO
  '/app/oracle/oradata/oratst/idx/idx_tst01.dbf';


  RENOMEAR
  ========
  ALTER TABLESPACE TS_DADOS 
  RENAME DATAFILE '/appsdes/oracle/oradata/oratst/idx_tst01.dbf' TO
  '/appsdes/oracle/oradata/oratst/idx_tst99.dbf';


5-Colocar a tablespace em ONLINE

  ALTER TABLESPACE TS_DADOS ONLINE;


6-Eliminar o datafile anterior se for o caso

  rm -f idx_tst01.dbf


------------------------------------------------------------------------------------------
1-movendo uma tabela nao particionada que pertence a tablespace TS_EDGE para outro tablespace

ALTER TABLE EDGE.TBEDGE_AUTORIZACAO
MOVE TABLESPACE TS_EDGE_DADOS;

2-recriar os indices para evitar o erro ORA-01502
