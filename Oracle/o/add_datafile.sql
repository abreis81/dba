/*

  add_datafile.sql
 

*/

-----------------------------------------------------------------------------------------------

OBS: quando efetuamos a operacao abaixo o datafile não eh excluido, apenas colocado em OFFLINE
para ser desconsiderado em STARTUP posterior e não utilizar o datafile em operacao de alocação
de extents. Futuramente podera existir problemas quando a tablespace necessitar de espaco pois
a mesma irar tentar utilizar o espaço alocado por este datafile e não poderar utiliza-lo. A 
solução para este problema eh manter sempre espaço suficiente para a tablespace nunca reclamar
este espaço alocado pelo datafile que encontra-se em OFFLINE.

ALTER DATABASE
DATAFILE '/ora03/app/oracle/oradata/sta01p/dat/tbs_dat_edge_cliente_13.dbf' OFFLINE DROP;

SHUTDOWN IMMEDIATE;

STARTUP
-----------------------------------------------------------------------------------------------

ALTER TABLESPACE TBS_DAT_EDGE_CLIENTE
ADD DATAFILE '/ora03/app/oracle/oradata/sta01p/dat/tbs_dat_edge_cliente_13.dbf'
SIZE 300M
AUTOEXTEND ON
NEXT 100M;

-----------------------------------------------------------------------------------------------
alter database
datafile '/ora03/app/oracle/oradata/sta01p/dat/tbs_dat_edge_cliente_13.dbf'
resize 200m
autoextend off;

-----------------------------------------------------------------------------------------------
CENARIO: 0.1  Necessidade de move um datafile para outro filesystem ou renomea-lo. Este processo
nao caracteriza propriamente um cenario de falha, mas achei importante documentar.

1-Iniciar a base de dados 

  1.1- export ORACLE_SID=oratst
  1.2- STARTUP 

2-Colocar a tablespace em OFFLINE

  ALTER TABLESPACE TS_DADOS OFFLINE;

3-Copiar o datafile para o novo filesystem ou copiar o datafile com o novo nome

  cp idx_tst01.dbf idx_tst90.dbf;

4-Alter o datafile de filesystem ou renomear

  MOVER
  =====
  ALTER TABLESPACE TS_DADOS 
  RENAME DATAFILE '/appsdes/oracle/oradata/oratst/idx_tst01.dbf' TO
  '/appsdes/oracle/oradata/oratst/idx/idx_tst01.dbf';


  RENOMEAR
  ========
  ALTER TABLESPACE TS_DADOS 
  RENAME DATAFILE '/appsdes/oracle/oradata/oratst/idx_tst01.dbf' TO
  '/appsdes/oracle/oradata/oratst/idx_tst99.dbf';


5-Colocar a tablespace em ONLINE

  ALTER TABLESPACE TS_DADOS ONLINE;


6-Eliminar o datafile anterior se for o caso

  rm -f idx_tst01.dbf

-----------------------------------------------------------------------------------------------
se a base de dados estiver apenas montado ( STARTUP MOUNT EXCLUSIVE ) todas as operacoes
envolvendo datafiles podem ser efetuadas por intermedio do:

ALTER DATABASE ..........


se a base de dados estiver aberta as operacoes envolvendo datafiles podem ser realizadas
por intermedio da tablespace:

ALTER TABLESPACE TS_DADOS OFFLINE;
ALTER TABLESPACE TS_DADOS RENAME DATAFILE <antigo> TO <novo>;

