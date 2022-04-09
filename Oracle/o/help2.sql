** Alterar o Tamanho do Extents de uma Tabela **

alter table (user.table) storage(maxextents 200);



** Nome de tabelas para controle de Tabelas **

 DBA_TABLES -> Verifica configuracao das tabelas

 DBA_DATA_FILES -> Verifica configuracao dos datafiles

 DBA_TABLESPACE -> Verifica Configuracao dos Tablespaces

 V$logfile     -> Verifica Configuracao do Control File



** Altera o Tamanho do Datafile **

Alter database datafile 'NOME DO DATAFILE' resize 999M  



** Adicionar um novo datafile a tablespace **

Alter Tablespace "NOME DA TABLESPACE" add datafile "PATH DO DATAFILE" 
size 999M






** Verificar o status do Achive Log.

-- Entrar no svrmgr e executar.

SVRMGR> Archive log list.

*** Alterar o path do Tablespace ***

1- Colocar Tablespace em backup mode.

2- Remover o datafile do Path de Origem para o Path de destino

3- Executar o seguinte comando: 

SVRMGR> Alter Tablespace *NOME DA TABLESPACE
        rename datafile 
        'Path do Datafile Origem'
        to
        'Path do Datafile de destino';

4- Apos haver terminado colocar as Tablespace em 
   ONLINE e SHUTDOWN E STARTUP NO BANCO SE FOR POSSIVEL.

**** Comando para Alterar o status da tablespace 

-> Colocar em online:-)
SVRMGR> alter tablespace *NOME DA TABLESPACE* ONLINE;

-> Colocar em Offline:-)
SVRMGR> alter tablespace *NOME DA TABLESPACE* OFFLINE;






          
*** Colocar o Banco em Archive Mode.

1- Fazer o Startup apenas com Mount.

SVRMGR> startup mount

2- Alterar a condicao do banco para modo Archive.

SVRMGR> alter database archive log;

3- Fazer abertura do Banco.

SVRMGR> Alter database Open;

4- Verificar que o Banco esta com archive mode ligado

SVRMGR> archive log list;

%%Obs: Nao esqueca de colocar no arquivo INIT.ORA as
configuracoes do ARCHIVE MODE, tais como path, tamanho,
etc....





*** Verificar os parametros 

SQL> show parameter trans;

****** Comando Para fechar o logfile.

SQL> Alter system switch logfile;




***********************************************************************
************* Manutencao dos segmentos de Rollback ********************

Verificar quantos extents o segmento ja realizou.

Pre> select extents from dba_segments
  2  where segment_name='CE6PR002';

   EXTENTS
----------
        18

1 linha seleccionada.


Verificar quantos usuarios estao usuando a base.

Pre> select username from v$session;
USERNAME
------------------------------
BR098101
OPS$ORACLE
SYSTEM
BR098101
BR098101

12 linhas seleccionadas.

Verificar os paramentros do banco 

Pre> desc v$parameter
 Nome                            Nulo?    Tipo
 --------------------------------------------
 NUM                                      NUMBER
 NAME                                     VARCHAR2(64)
 TYPE                                     NUMBER
 VALUE                                    VARCHAR2(512)
 ISDEFAULT                                VARCHAR2(9)


Verificar a situacao dos blocos do banco: 

Pre> select name, value from v$parameter
  2  where name like 'db_blo%';

NAME
----------------------------------------------------------------
VALUE
--------------------------------------------------------------------------------
db_block_buffers
9000

db_block_size
4096

db_block_checkpoint_batch
8

db_block_lru_statistics
FALSE

db_block_lru_extended_statistics
0


5 linhas seleccionadas.


Verificar os bytes livres da tablespace: 

Pre> select bytes , count(*) from dba_free_space
  2  where tablespace_name='CE6PR01'
  3  GROUP BY BYTES;

     BYTES   COUNT(*)
---------- ----------
   1142784          1

1 linha seleccionada.

%%% View  que mostra o nome dos segmentos de Roolback

Pre> desc v$rollname
 Nome                            Nulo?    Tipo
 --------------------------------------------
 USN                                      NUMBER
 NAME                            NOT NULL VARCHAR2(30)


%% Descobrir o nome de um objeto dba %% 
%% examplo : rollback.

Pre> select object_name from dba_objects
  2  where object_name like 'V$RO%';

OBJECT_NAME
--------------------------------------------------------------------------------
V$ROLLNAME
V$ROLLSTAT
V$ROWCACHE

3 linhas seleccionadas.

%%% Descobrir os campos da view do segmento

Pre> desc v$rollstat
 Nome                            Nulo?    Tipo
 --------------------------------------------
 USN                                      NUMBER
 EXTENTS                                  NUMBER
 RSSIZE                                   NUMBER
 WRITES                                   NUMBER
 XACTS                                    NUMBER
 GETS                                     NUMBER
 WAITS                                    NUMBER
 OPTSIZE                                  NUMBER
 HWMSIZE                                  NUMBER
 SHRINKS                                  NUMBER
 WRAPS                                    NUMBER
 EXTENDS                                  NUMBER
 AVESHRINK                                NUMBER
 AVEACTIVE                                NUMBER
 STATUS                                   VARCHAR2(15)



%%% Verificar se o segmento de roolback esta com opmail ligado;


Pre> select usn, optsize from v$rollstat;

       USN    OPTSIZE
---------- ----------
         0
         2
         3
         4
         5
         6
         7
         8
         9
        10
        11

11 linhas seleccionadas.


%%%% Verificar qual o tamanho do pre alocado do segmento.


Pre> select usn,hwmsize from v$rollstat;

       USN    HWMSIZE
---------- ----------
         0     180224
         2   35856384
         3   37965824
         4   59060224
         5   35856384
         6   52731904
         7   37965824
         8   37965824
         9  103358464
        10   84373504
        11   37965824

11 linhas seleccionadas.


  1  select b.usn ,a.name from v$rollname a, v$rollstat b
  2* where a.usn=b.usn
Pre> /

       USN NAME
---------- ------------------------------
         0 SYSTEM
         2 CE6PR001
         3 CE6PR002
         4 CE6PR003
         5 CE6PR004
         6 CE6PR005
         7 CE6PR006
         8 CE6PR007
         9 CE6PR008
        10 CE6PR009
        11 CE6PR010

11 linhas seleccionadas.

Pre> alter rollback segment ce6pr008 offline;

Pre> drop rollback segment ce6pr008;

Pre> select bytes, count(*) from dba_free_space
  2  where tablespace_name='CE6PR01'
  3  GROUP BY BYTES;

     BYTES   COUNT(*)
---------- ----------
   1142784          1
   2109440         49

2 linhas seleccionadas.

Pre> CREATE ROLLBACK SEGMENT CE6PR008 TABLESPACE CE6PR01
  2  STORAGE (INITIAL 2M NEXT 2M OPTIMAL 6M);

Segmento de rollback criado.

Pre> ALTER ROLLBACK SEGMENT CE6PR008 ONLINE;

Pre> ALTER ROLLBACK SEGMENT CE6PR009 OFFLINE;

Pre> ALTER ROLLBACK SEGMENT CE6PR005 OFFLINE;

Pre> ALTER ROLLBACK SEGMENT CE6PR003 OFFLINE;

Pre> DROP ROLLBACK SEGMENT CE6PR009;

Pre> DROP ROLLBACK SEGMENT CE6PR005;

Pre> DROP ROLLBACK SEGMENT CE6PR003;


Pre> CREATE ROLLBACK SEGMENT CE6PR003 TABLESPACE CE6PR01
  2  STORAGE (INITIAL 2M NEXT 2M OPTIMAL 6M);

  1  CREATE ROLLBACK SEGMENT CE6PR005
  2  tabLESPACE CE6PR01
  3* STORAGE (INITIAL 2M NEXT 2M OPTIMAL 6M)

  1  CREATE ROLLBACK SEGMENT CE6PR009
  2  tabLESPACE CE6PR01
  3* STORAGE (INITIAL 2M NEXT 2M OPTIMAL 6M)

Pre> alter rollback segment ce6pr009 online;


Pre> alter rollback segment ce6pr005 online;


Pre> alter rollback segment ce6pr003 online;


Pre> select bytes , count(*) from dba_free_space
  2  where tablespace_name='CE6PR01'
  3  group by bytes;

     BYTES   COUNT(*)
---------- ----------
   1142784          1
   2109440        134

2 linhas seleccionadas.


Pre> select bytes, count(*) from dba_free_space
  2  where tablespace_name='CE6PR01'
  3  group by bytes;

     BYTES   COUNT(*)
---------- ----------
   1142784          1
   2109440        134



  1  select sum(bytes) from dba_free_space
  2* where tablespace_name='CE6PR01'
Pre> /

SUM(BYTES)
----------
 283807744


Pre> select usn, optsize from v$rollstat;

       USN    OPTSIZE
---------- ----------
         0
         2
         3
         9    6291456
         5
         6    6291456
         7
         8
         1    6291456
         4    6291456
        11

11 linhas seleccionadas.

Pre> alter rollback segment ce6pr010 offline;


Pre> alter rollback segment ce6pr006 offline;

Pre> drop rollback segment ce6pr010;

Pre> drop rollback segment ce6pr006;


Pre> create rollback segment ce6pr010 tablespace ce6pr01
  2  storage (initial 2M next 2M optimal 6M);

  1  create rollback segment ce6pr006 tablespace ce6pr01
  2* storage (initial 2M next 2M optimal 6M)


Pre> alter rollback segment ce6pr010 online;

Pre> alter rollback segment ce6pr006 online;

Pre> select sum(bytes) from dba_free_space
  2  where tablespace_name='CE6PR01';

SUM(BYTES)
----------
 351309824

        