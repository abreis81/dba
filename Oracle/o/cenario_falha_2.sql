
uma base de dados de producao deverá trabalhar sempre em modo archive, este é a unica forma
de garantir a recuperacao de dados em situacoes de falhas.

view envolvidas com a recuperacao de falhas:
V$ARCHIVED_LOG        - ARCHIVED LOG arquivados, incluindo seu path e copia de multiplexagem
                        necessarios na recuperacao da base de dados
V$ARCHIVE_DEST        - destinos possiveis de arquivo de redo logs
V$LOG_HISTORY         - historico de ARCHIVED LOGS disponiveis para aplicacao em recuperacao
V$DATAFILE_HEADER     - cabecalho dos datafiles - SCN, informacao de recuperacao 
                       ( quando o DATAFILE esta em backup o atributo FUZZY='YES', 
                         a sincronizacao obriga que O SCN DEVE SER O MESMO EM DATAFILES, 
                         CONTROLFILES E ONLINE REDO LOG )
V$BACKUP              - datafiles que estao envolvidos num backup a quente ( STATUS='ACTIVE' )
V$RECOVERY_LOG        - relacao dos ARCHIVED LOGS necessarios para recuperacao da base
V$RECOVER_FILE        - datafiles que necessitam de recuperacao
V$RECOVERY_FILE_STATUS- datafiles precisando de recuperacao ( informacao retirada da PGA, apos um ALTER DATABASE RECOVER DATAFILE n )
V$RECOVERY_STATUS     - inicio da recuperacao, LSN necessario e outros ( informacao retirada da PGA, apos um ALTER DATABASE RECOVER DATAFILE n )
V$RECOVERY_PROGRESS   - informacao sobre o processo de recuperacao

-----------------------------------------------------------------------------------------------
OBS: todos os cenarios consideram a base de dados em ARCHIVELOG MODE e recuperação incompleta
-----------------------------------------------------------------------------------------------

CENARIO: A  ( TIME-BASED RECOVERY )
            ( CANCEL-BASED RECOVERY )

recuperacao da base de dados para um ponto no tempo anterior a falha ocorrida:
exemplo: o problema ocorreu as 11:40 e vc so consegue recuperar a base de dados ate as 11:35
         isso geralmente eh aplicado quando uma tabela eh acidentalmente dropada.

1-se a base de dados estiver aberta, baixe imediatamente usando NORMAL ou IMMEDIATE

  shutdown immediate

1.1-faça um backup neste ponto, visto que podemos ter que retornar e começar novamente a 
    recuperacao.

1.2-monte a base de dados

    startup mount;

2-restaure todos os datafiles do ultimo backup backup  

  cp /disk1/backup/*.dbf /disk1/data/

3-restaure todos os ARCHIVED LOGS para a localização ( LOG_ARCHIVE_DEST )

4-recupera a base de dados

  recover database until time '2001-09-19 11:45:00';

  ou

  recover database until cancel;

5-para sincronizar o control files, redo logs e datafiles abra a base com RESETLOGS

  alter database open resetlogs;

6-antes de fazer o backup da base de dados, verifique se a tabela foi recuperada com sucesso

  select * from tbedge_cliente;

  obs: se nenhum linha retornou, a recuperacao falhou. retorne archived logs mais antigos e
       tente novamente.

7-se recuperacao com sucesso, faça um backup full novamente.

8-avise para os usuarios que deverao re-entrar com os dados apos as 11:35

-----------------------------------------------------------------------------------------------

CENARIO: B ( BACKUP CONTROL FILE RECOVERY )

1-acidentalmente ocorre o comando abaixo:

  drop tablespace ts_dados including contents;

2-nao deixe mais ninguem acessar a base de dados

  alter system enable restricted session;

3-durante analise, vc localiza um backup do controlfile da ultima noite.

  select * from v$log;

4-vc procura a hora exata do erro no alert.log

  
5-baixa a base de dados, e volta o backup do controlfile e restaure todos os datafiles.
  quando vc abre a base receber alguns erros visto que o online redo log nao esta 
  sincronizado

  ORA-00314: log 1 of thread 1, expected sequence# doesn't match
  ORA-00312: online log 1 thread 1: '/disk1/data/log1a.rdo'

6-verifique se existe algum datafile em OFFLINE, entao mude para ONLINE

  select * from v$recover_file;

  alter database datafile 4 online;

7-faça a recuperação

  recover database until time '......' using backup controlfile;

  obs: ORA-01152: file 7 was not restored from a sufficiently old backup
       ORA-01110: datafile 7: '/disk1/..../filexx.dbf'

8-sincronize a base de dados

  alter database open resetlogs;

9-faça um select na tabela, para verificar se foi recuperada

10-avise ao usuarios que deverao re-entrar com os dados perdidos apos o horario
   de recuperacao

-----------------------------------------------------------------------------------------------

CENARIO: C ( PERDA DO CORRENTE REDO LOG )

se a base de dados esta aberta mas existe um grupo de log corrupto

1-encontre o grupo de redo com problemas

  select * from v$log;

2-limpe o grupo corrente 

  alter database clear unarchived logfile group 1;

3-a base de dados devera esta operacional

4-se continuar com problema faça um recuperacao incompleta da base de dados

   volte o backup de todos os datafile e o controlfile e aplique todos os
   archived logs

-----------------------------------------------------------------------------------------------

CENARIO: D ( PERDA DO CORRENTE REDO LOG )

1-no start da base de dados, sera notificado com erros do corrente redo log group

  ORA-00313: open failed for members of log group 2 of thread 1
  ORA-00312: online log 2 thread 1: '/disk1/..../log2a.rdo'
  ORA-27037: unable to obtain file status
  SVR4 Error: 2: no such file or directory
  Additional information: 3

2-limpe o grupo em corrupção

  alter database clear unarchived logfile group 2;

3-recuperacao incompleta eh portanto requerida

  select * from v$log;

4-restaure todos os datafiles do seu ultimo backup 

  recover database until cancel;

5-abrir a base sincronizando

  alter database open resetlogs;

6-a base devera estar operacional ou vc talvez precise dropar o grupo de redo log
  e recria-lo

7-faça um backup full

-----------------------------------------------------------------------------------------------
CENARIO: E

recuperando uma base de dados com datafile ( que seja o SYSTEM ) com problema

1-monte a base de dados
  start mount

2-coloque o datafile em offline
  alter database datafile '/.../dados/sta01p/user01.dbf' offline immediate;

3-abrir a base de dados para que os usarios continuem trabalhando com o restante
  
  alter database open;

4-restore uma copia do datafile com problemas

5-recupera a base de dados
 
  recover tablespace ts_user_data;

6-coloque o datafile em ONLINE

  alter tablespace ts_user_data online;

-----------------------------------------------------------------------------------------------
CENARIO: F

recuperando a base de dados, apos perda do controlfile

1-restaure uma copia do controlfile usando :

  alter database backup controlfile to trace;

2-recupere a base de dados usando o backup do controlfile

  recover database using backup controlfile;

3-abrir a base de dados que foi recuperada de forma incompleta

  alter database open resetlogs;

-----------------------------------------------------------------------------------------------
CENARIO: G

pode existir LOCK de aplicacao no ORACLE. isto eh chamado de LOCK DE APLICACAO.
eh criado pela DBMS_LOCK e devemos adotar o procedimento abaixo para resolver:

1-selecionar todas as transacoes com TYPE='UL'
 
  SELECT ADDR,SID, TO_CHAR(ID1) FROM V$LOCK WHERE TYPE='UL';

2-verificar os locks de aplicacao pendentes em DBMS_LOCK_ALLOCATED

  SELECT NAME,TO_CHAR(LOCKID),TO_CHAR(EXPIRATION,'YYYY/MM/DD HH24:MI:SS')
     FROM SYS.DBMS_LOCK_ALLOCATED
     WHERE NAME LIKE '_TBEDGE_BACKSTATUS%';

3-matar o LOCK identificado

  DELETE SYS.DBMS_LOCK_ALLOCATED
 WHERE LOCKID=1090262038;

