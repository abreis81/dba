/*

  add_database.sql
  josivan

  US7ASCII       ( default oracle )
  WE8ISO8859P1   ( compativel com portugues )
  
*/


ORA_NLS33=/orades/app/oracle/product/8.0.6/ocommon/nls/admin/data
ORA_NLS=/orades/app/oracle/product/8.0.6/ocommon/nls/admin/data

Obs: se a variavel acima nao estiver setada e for criada ou levantada uma base de dados
com conjunto de caracteres diferente do default ( US7ASCII ) os mesmos nao serao reconhecidos.

CHARACTER SET => conjunto de caracteres utilizado na base de dados
NATIONAL CHARACTER SET  => especifica o conjunto de caracteres nacionais usados para armazenar
                           dados na colunas definidas como NCHAR, NCLOB e NVARCHAR2. se nao
                           especificado o conjunto de caracters utilizado ser o especificado
                           em CHARACTER SET.

-----------------------------------------------------------------------------------------------

os parametros :

MAXLOGMEMBERS
MAXLOGFILES
MAXDATAFILES
MAXLOGHISTORY
MAXINSTANCES

podem ser alteradas recriando o CONTROLFILE da base de dados

-----------------------------------------------------------------------------------------------

Limite de datafiles ( MAXDATAFILES, DB_FILES )

obs: uma tentativa de adicionar um novo datafile cujo numero seja superior a MAXDATAFILES
     mas inferior a DB_FILES faz com que o arquivo de controle se expanda automaticamente
     de forma a comporta os novos datafiles.


-----------------------------------------------------------------------------------------------

PROCEDIMENTO PARA CRIAR UMA BASE

1-cd $ORACLE_HOME/dbs
2-copia o init.ora para a nova instance ( cp init.ora initBRADESCO.ora ) e ajustar os parametros
3-iniciar o banco em mode NOMOUNT

  SPOOL INSTANCE.TXT
  STARTUP NOMOUNT 
  CREATE DATABASE BRADESCO
  ..

4-rodar os scripts

  cd $ORACLE_HOME/rdbms/admin
  @catalog.sql
  @catproc.sql
  @utlxplain.sql
  @catrep.sql

5-iniciar

  STARTUP

