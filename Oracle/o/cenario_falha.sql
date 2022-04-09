
uma base de dados de producao deverá trabalhar sempre em modo archive, este é a unica forma
de garantir a recuperacao de dados em situacoes de falhas.

view envolvidas com a recuperacao de falhas:
V$ARCHIVED_LOG        - ficheiro de log arquivado, incluindo copia de multiplexagem
V$ARCHIVE_DEST        - destinos possiveis de arquivo de redo logs
V$LOG_HISTORY         - historico de archived logs disponiveis para aplicacao em recuperacao
V$DATAFILE_HEADER     - cabecalho dos datafiles - SCN, informacao de recuperacao
V$BACKUP              - datafiles que estao envolvidos num backup a quente
V$RECOVER_FILE        - datafiles que necessitam de recuperacao
V$RECOVERY_PROGRESS   - informacao sobre o processo de recuperacao


a recuperacao completa de uma base de dados, apos falha so sera possivel se esta apresentar
as seguintes caracteristicas:
1- a base de dados esta em modo ARCHIVE
2- a falha aconteceu em apenas datafiles
3- existem backups dos datafiles danificados ( copias antigas )
4- estao disponiveis todos os archived logs desde o ultimo backup
5- esta disponivel pelo menos uma copia do controlfile

-----------------------------------------------------------------------------------------------
CENARIO: 0.0

Se a base de dados estiver apenas montado com STARTUP MOUNT todas as operacoes
envolvendo datafiles podem ser efetuadas por intermedio do:

ALTER DATABASE RENAME FILE <antigo> TO <novo>;   ( valido tambem para logfiles ( ver cenario_falha ) )


se a base de dados estiver aberta as operacoes envolvendo datafiles podem ser realizadas
por intermedio da tablespace:

ALTER TABLESPACE TS_DADOS OFFLINE;
ALTER TABLESPACE TS_DADOS RENAME DATAFILE <antigo> TO <novo>;

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

------------------------------------------------------------------------------------------------
CENARIO A: removi um datafile do sistema operacional, sem fazer DROP TABLESPACE na base de dados
e agora a base de dados nao levanta.

1-shutdown immediate
2-startup mount exclusive
3-ALTER DATABASE DATAFILE '/DB/ORADATA/OCPE/DATA/D03OCPE.DBF' OFFLINE DROP;
4-baixar e levantar a base novamente

-----------------------------------------------------------------------------------------------
CENARIO B: necessito alterar um datafile para crescer automaticamente em disco.

1-ALTER DATABASE DATAFILE '/DB/ORADATA/OCPE/DATA/D03OCPE.DBF'
  AUTOEXTEND ON NEXT 5M MAXSIZE 500M;

-----------------------------------------------------------------------------------------------
CENARIO C:  atingi o limite maximo de extents para um determinado segmento ( rollback ou nao ).

1-ALTER TABLESPACE DADOS
  DEFAULT STORAGE( MAXEXTENTS <novo_valor> );
2-observer tambem o valor do NEXT pois, pode estar muito pequeno fazendo com o maxextents
  seja atingido rapidamente.

-----------------------------------------------------------------------------------------------
CENARIO D: os datafiles estao completamente cheios, eh necessario mais espaco para o tablespace.

1-adicionar mais um datafile ( ALTER TABLESPACE DADOS ADD DATAFILE '/X/Y.DBF' SIZE 100M )
2-modificar um dos datafiles para ser autoextend
3-aumentar o tamanho dos datafiles atuais ( ALTER TABLESPACE DADOS DATAFILE '/X/Y.DBF' RESIZE 200M )

------------------------------------------------------------------------------------------------
CENARIO 1:  ( recuperacao de uma base de dados que trabalha em NOARCHIVE )
quando ocorre uma perda de ficheiros, corrupcao ou falha na maquina ou respectivos discos, a 
unica hipotese sera repor o ultimo backup a frio. Quer isto dizer que basta falhar um dos
datafiles, para que todos os outros fiquem inutilizados, apesar de nao terem sidos alvo
de nenhuma falha. Isto porque nao existem archive logs que consigam trazer uma copia antiga 
do datafile afectado para o mesmo nivel temporal que os restantes.

1- fechar a base de dados com SHUTDOWN ABORT ( se é que nao esta já fechada )
2- copiar todos os datafiles, controlfiles, redo logfiles, parameter files (INIT.ORA) e 
   password file para as localizacoes antigas ou para novas localizacoes fisicas. ( sobrepor se for o caso )
3- caso os discos tenham ficado irremediavelmente afetados e as localizacoes antigos
   dos controlfile nao se consigam reproduzir, deve ser editado o INIT.ORA a fim de ser modificado o 
   parametro CONTROL_FILES, para apontar para as novas localizações dos controlfiles.
4- emitir o comando STATUP MOUNT PFILE=<localizado do init.ora>
5- novamente se os discos foram afetados de modo que alguns datafiles ou logfiles nao podem
   ser repostos nas suas localizacoes fisicas originais, devem ser emitidos tantos comandos 
   ALTER DATABASE RENAME FILE <nome_antigo>  TO  <novo_nome>
   quantos forem necessarios.
6- emitir o comando     RECOVER DATABASE UNTIL CANCEL
7- abrir a base de dados, colocando o LSN de volta ao número 1 ( ALTER DATABASE OPEN RESETLOGS )

------------------------------------------------------------------------------------------------

CENARIO 2:  ( recuperacao completa de uma base de dados fechada )

observacao: para o completo sucesso da recuperacao a base tem de estar:
1-a base de dados esta a funcionar em modo arquivo
2-a falha afetou apenas datafiles
3-existem backups dos datafiels afetados
4-estao disponiveis todos os archived logs desde o ultimo backup
5-existe disponivel pelos menos uma copia do controlfile.
6-é necessario repor apenas os ficheiros danificados.

este é o caso em que, ao levantar uma base de dados com o comando STARTUP, o DBA verificou
que um ou mais datafiles estavam danificados, ou que o respectivo disco estava inacessivel, ou
ainda que foi removido um datafile inadvertidamente. Este é o unico metodo disponivel para
recuperar datafiles danificados que pertencam aos tablespaces SYSTEM ou RBS ( ou qualquer outro
tablespace com segmentos de rollback activos ).
1- verificar quais sao os datafiles danificados e repor apenas os backup desse ficheiro
2- levantar a base de dados da seguinte forma:
    STARTUP RESTRICT MOUNT;
3- se eventualmente alguma falha de hardware tiver provocado a necessidade de colocar os backup
   do datafile danificado em outro local fisico, tem de se 'comunicar' essa alteracao ao
   controlfile com o comando ALTER DATABASE RENAME FILE <nome_antigo> TO <novo_nome>
4- verificar o estado dos datafiles a recuperar, registado no dicionario de dados e se estivem
   off-line devem ser alterados para ficar on-line. Se se tratar de datafiles do tablespace
   SYSTEM o estado on-line corresponde a system, e o estado off-line corresponde a sysoff.

        select file#
              ,name
              ,status
          from v$datafile;

   alterar o estado do datafile( a base tem de estar em modo arquivo )
    
   ALTER DATABASE DATAFILE <nome_datafile> online;

5- pegar no valor da coluna FILE# ( codigo_do_datafile ) e usa-lo para emitir um comando
   RECOVER por cada datafile e recuperar com a seguinte sintaxe:(tambem pode ser usado o nome do datafile)

   RECOVER DATAFILE <codigo_do_datafile>;

   este comando vai aplicar os archived logs que achar necessarios, sugerindo um por um os 
   respectivos nomes e permitindo ao DBA fazer uma das quatro hipoteses:

   a)aceitar o nome pressionando RETURN
   b)fornecer um nome ou localizacao alternativa do archived log que o ORACLE SERVER esta 
     necessitando aplicar ao datafile para o recuperar.
   c)instruir o ORACLE SERVER para prosseguir com o processo de recuperacao automaticamente, 
     sem pedir mais nomes de archived logs. Para isto basta escrever AUTO
   d)cancelar o processo de recuperacao escrevendo a palavra CANCEL.

   no final de cada RECOVER (um por datafile) se tudo ocorreu bem, sera emitida a mensagem:
   'MEDIA RECOVERY COMPLETE'

6- depois de emitidos todos os comandos RECOVER necessarios, pode ser aberta a base de dados:
   ALTER DATABASE OPEN;

------------------------------------------------------------------------------------------------

CENARIO 3:  ( recuperacao completa de uma base de dados aberta )
durante o funcionamento da base de dados, podem ocorrer problemas que inutilizem alguns
datafiles. Se o datafile atingido pertencer ao tablespace SYSTEM, ou possuir segmentos de
rollback activos, entao nao pode ser usado este metodo. Quer isto dizer que a recuperacao nao
pode ser feita com a base de dados aberta, uma vez que foram afetadas as estruturas minimas 
para que a base de dados se mantenha aberta. Este cenario aplica-se a casos em que a recuperacao
da base de dados e feita quando esta se encontra aberta (OPEN), precisamente porque nao afetou
os referidos datafiles.
um exemplo tipico da aplicacao deste metodo e quando se remove inadvertidamente um datafile,
por exemplo de dados ou indices, enquanto a abase de dados esta funcionando.
1- colocar imediatemente os datafiles afetados para o estado off-line ( se o ORACLE SERVER nao o fez)
   usando o comando:

        select file#
              ,name
              ,status
          from v$datafile;

   alterar o estado do datafile( a base tem de estar em modo arquivo )
    
   ALTER DATABASE DATAFILE <nome_datafile> offline;

   se for o caso colocar todo o tablespace em offline, uma vez que essa operacao coloca 
   tambem offline todos os respectivos datafiles. 
2- verificar quais sao os datafiles danificados e repor apenas os backup desses arquivos.
3- usar o comando RECOVER para recuperar os datafiles um a um ou, entao, no caso de se tratar
   de um tablespace inteiro, pode ser usado o seguinte comando:

        RECOVER TABLESPACE TS_DADOS;  ( ts_dados, e o nome do tablespace )

    o processo desencadeado pelo comando recover e o da aplicacao dos archived logs aos datafiles
    que ficaram perdidos no tempo, de modo a sincroniza-los com os restantes. Este mecanismo
    de recuperacao é suportado pelo system change number ( SCN ) que indica quais sao os datafiles
    mais velhos e desde quando devem ser aplicados os logs arquivos. O comando RECOVER aplicado
    ao tablespace tambem é possivel mesmo quando todos os datafiles foram danificados.
4- colocar os datafiles ou o tablespace de volta no estado online

------------------------------------------------------------------------------------------------

CENARIO 4: ( recuperacao completa da base de dados aberta sem backup dos ficheiros perdidos,
             mas com todos os archived logs )
quando se perde um ficheiro para o qual, nao existe backup ou o backup nao esta utilizavel,
devem ser executados os seguintes passos:
1- colocar offline o tablespace ao qual pertence o ficheiro perdido, mas com a clausula
   IMMEDIATE de modo a evitar checkpoints num ficheiro que nem seque existe.

   ALTER TABLESPACE TS_DADOS OFFLINE IMMEDIATE;
 
2- criar uma copia vazia do ficheiro perdido, uma vez que nao existe sequer uma copia de backup

   ALTER DATABASE CREATE DATAFILE <nome_da_copia> AS <nome_do_ficheiro_perdido>;

   este comando pressupoe que o novo ficheiro vai ser criado numa localizacao distinta do 
   ficheiro antigo, apaga o ficheiro antigo e cria uma imagem vazia do mesmo tamanho.

3- agora que ja existe um datafile no lugar do recem-desaparecido, MAS COM O MESMO CODIGO DE 
   DE DATAFILE entao o DBA deve ter todos os archived logs criados desde a criacao do ficheiro
   recem-perdido de modo a poder aplica-los no processo de recuperacao:

   RECOVER DATABASE TS_DADOS;

4- quando o processo de recuperacao terminar, deve ser colocado o tablespace novamente online:

   ALTER DATABASE TS_DADOS ONLINE;

------------------------------------------------------------------------------------------------

CENARIO 5:  ( recuperacao incompleta )

recuperacao incompleta é o metodo usado como resultado de falhas como:
a) quando falha uma recuperacao completa porque nao estao disponiveis todos os archived logs que sao necessarios
b) remocao acidental de um objeto (os comando DDL sao irreversiveis transacionalmente ex.DROP TABLE...)
c) quando se perde o controlfile e apenas se possui uma copia binaria
d) e outros

   a recuperacao incompleta pode ser feita de 4 maneiras:

   a) reportando-se a um instante no tempo
   b) recuperar a base de dados ate onde for possivel
   c) reportando-se a um instante determinado pelo SCN
   d) reportando-se a um instante determinado por um backup de um controlfile

procedimento para recuperacao incompleta:
1- reportar a um instante no tempo

   RECOVER DATAFILE UNTIL TIME '2000-03-04:22:01.00';
   
   recuperacao da base de dados de modo a reporta-la para o instante determinado pela data:
   04 de marco de 2000 as vinte e duas horas e um minuto e zero segundos.

2- recuperar a base de dados ate onde for possivel
   
   ALTER DATAFILE UNTIL CANCEL;

   recuperar ate o instante em que nao existir mas archived logs

3- reportar a um instante determinado pelo SCN ( system change number )

   ALTER DATAFILE UNTIL CHANGE 1422;

   recuperar a base de dados ate o archived logs 1422

4- reportando-se a um instante determinado por um backup de um controlfile

   RECOVER DATABASE USING BACKUP CONTROLFILE;

5- o controlfile é quem marca o ritmo e se ele se perde e é colocado no seu lugar uma copia
   antiga, todos os outros ficheiros vao ter de se atrasar tambem. Depois de uma recuperacao
   incompleta, a base de dados tem ser aberta com a opcao RESETLOGS uma vez que o LSN ( log
   sequence number ) do momento em que a base de dados iria ficar recuperada seria sempre
   menor ao LSN que estava vigente no momento da falha. Por isso a base de dados tem de 
   colocar o LSN de volta em 1.

   ALTER DATABASE OPEN RESETLOGS;

------------------------------------------------------------------------------------------------

CENARIO 6: ( processando um backup a quente e de repente a maquina falhou, ou acabou a energia )

este cenario pode provocar arrepios por duas razoes: Primeiro, porque estava a ser feito um
backup a quente, é sinal que a base de dados nao pode ser fechada e agora a falha fez com que a
base ficasse indisponivel. a segunda razao prende-se com a operacao que estava a decorrer no 
momento em que a maquina falhou: um backup a quente. Eis passos a seguir:

1- levantar a base de dados em estado MOUNT
   STARTUP MOUNT
2- consultar a script para saber quais foram os datafiles que estavam em modo backup quando
   a base foi abaixo:

   select file# "numero_do_datafile"
     from v$backup
    where status = 'ACTIVE';

3- fechar o modo backup de cada um desses ficheiros com o seguinte comando:

   ALTER DATABASE DATAFILE <numero_do_datafile> END BACKUP;

4- abrir a base de dados
   
   ALTER DATABASE OPEN;

------------------------------------------------------------------------------------------------

CENARIO 7: ( remocao acidental de um objeto da base de dados )

existe duas formas de recuperar o objeto:
a) fazendo um import do objeto
b) rebobinando a base de dados atraves dos archived logs

rebobinando a base de dados
1- fechar a base de dados assim que for detectada a remocao do objeto
2- levantar a base de dados em estado MOUNT
   STARTUP MOUNT
3- emitir o comando RECOVER com o seguinte formato ( recuperacao incompleta )
   
   RECOVER DATABASE UNTIL TIME '2000-03-05:18:55:30';

   a base sera rebobinada ate o dia cinco de marco de dois mil as dezoite horas e 
   cinquenta e cinco minutos e trinta segundos e será reposta uma versao anterior da
   base de dados quando o objeto removido ainda existia.

4- abrir a base de dados e como se tratou de uma recuperacao incompleta, faze-la com a
   clausula RESETLOGS

   ALTER DATABASE OPEN RESETLOGS;

-----------------------------------------------------------------------------------------------

CENARIO 8: ( perder um logfile corrente )

por nao ter feito uma multiplexagem dos grupos de logs, criando pelo menos dois membros por
grupo, pode-se ver um belo dia sem um dos redo logs, por falha de hardware ou porque o ficheiro
foi inadvertidamente removido. E, para piorar as coisas, esse redo log era onde o LGWR estava
a escrever de momento, ou seja, era o logfile corrente.

1- fechar a base de dados ( com ABORT se necessario )

   SHUTDOWN ABORT;

2- repor as copias de backup de todos os datafiles por cima dos datafiles atuais
3- levantar a base de dados em estado MOUNT
   
   STARTUP MOUNT;

4- consultar o LSN do log perdido com o script:

   select max(sequence#) from v$log;

   ou entao com o comando ARCHIVE LOG LIST dentro do svrmgr

5- emitir o seguinte comando:

   RECOVER DATABASE UNTIL CANCEL;

   se forem feitas sugestoes de logs a aplicar na recuperacao automatica, devem ser aceites
   todas as sugestoes premindo enter ate o momento em que seja sugerido um log com o mesmo LSN
   que aquele que foi perdido, altura em que deve escrever CANCEL

6- abrir a base de dados de modo a reiniciar o LSN

   ALTER DATABASE OPEN RESETLOGS;

7- tornar a fechar a base de dados de modo limpo ( SHUTDOWN NORMAL ) e fazer um backup a frio

8- abrir a base de dados ( STARTUP )   

------------------------------------------------------------------------------------------------

CENARIO 9: ( perder um logfile nao corrente )

a unica diferenca deste cenario para o anterior esta no fato de o log que foi removido, ou que 
ficou inacessivel por falha de hardware, nao ser o log onde o processo LGWR estava a escrever
correntemente. Mais uma vez por nao ter feito uma multiplexagem dos grupos de logs, criando pelo
dois membros por grupo, a base de dados vai ficar inacessivel ate o problema se resolver.

1- fechar a base de dados  ( SHUTDOWN )
2- levantar a base de dados em estadou MOUNT

   STARTUP MOUNT;

3- verificar quantos membros possui cada grupo com a seguinte script

   select group#, count(*) from v$logfile group by group#;

4- verificar qual o grupo de logs com o maior codigo atraves da seguinte script

   select max(group#)
     from v$log;

5- verificar qual o tamanho de cada logfile com o comando

   select bytes/1024 "tamanho em kb"
     from v$log;

6- criar um novo grupo de logs com o mesmo numero de membros que os outros, com um numero
   superior em uma unidade ao grupo com o maior codigo e com o mesmo tamanho. Existe apenas
   um membro por grupo de logs - situacao que deve ser corrigida para pelo menos dois membros
   depois de resolvido este problema.

   ALTER DATABASE ADD LOGFILE GROUP X 
   'E:\DB\ORADATA\GLPP\SYSTEM\CTLXGLPP.ORA' SIZE 2M;

7- remover do controlfile o registro do grupo logs do qual se perdeu os ficheiros - vamos 
   partir do principio que foi o grupo 2

   ALTER DATABASE 
   DROP LOGFILE GROUP 2;

8- abrir a base de dados

   ALTER DATABASE OPEN;

-----------------------------------------------------------------------------------------------

CENARIO 10: ( perda do controlfile, mas com backup binario ou copia a frio )

este cenario retrata a situacao que o controlfile é perdido e tudo o que se tem é uma copia
de backup binaria, do controlfile. No caso de existir uma copia de backup do controlfile de
um backup a frio, podera ser reposta diretamente sem necessidade de recuperacao. E necessario
ter em atencao que essa copia do backup a frio se reporta a um momento da base de dados e todos
os tablespaces e datafiles criados depois disso, nao serao considerados. Deverao ser criados 
novamente os tablespace com a clausula que permite reutilizar os datafiles.

1- fechar a base de dados 
2- repor a copia binaria do controlfile nos mesmos locais e com o mesmo nome que o ficheiro desaparecido
3- levantar a base de dados em estado MOUNT
 
   STARTUP MOUNT;

4- efetuar uma recuperacao incompleta com o comando

   RECOVER DATABASE USING BACKUP CONTROLFILE;

   esta recuperacao necessita dos archived logs

5- finalmente abrir a base de dados a moda de qualquer recuperacao incompleta

   ALTER DATABASE OPEN RESETLOGS;


-----------------------------------------------------------------------------------------------

CENARIO 11: ( perda do controlfile, sem nenhum backup ou com uma script de recriacao )

foi perdido o controlfile, mas nao existe nenhuma copia de backup nem a quente nem a frio.
Nao existe nada. Esta situacao é equivalente a existir apenas a script de recriacao do 
controlfile que é gerada com o comando:

   ALTER DATABASE BACKUP CONTROLFILE TO TRACE;

se existir a referida script gerada com o comando acima, devera ser corrida, o que resolvera
o problema. Se nao existir, deve ser construida um script igual.

1- levantar a base de dados em estado NOMOUNT

   STARTUP NOMOUNT;

2- criar um controlfile com o comando CREATE CONTROLFILE que reflita toda a arquitetura de logs
   e datafiles.

   CREATE CONTROLFILE REUSE DATABASE "GLPP"
   NORESETLOGS ARCHIVELOG
      MAXLOGFILES 32
      MAXLOGMEMBERS 2
      MAXDATAFILES 32
      MAXINSTANCES 16
      MAXLOGHISTORY 1630
  LOGFILE
    GROUP 1 'F:\DB\ORADATA\GLPP\SYSTEM\LOG1GLPP.ORA' SIZE 2M,
    GROUP 2 'F:\DB\ORADATA\GLPP\SYSTEM\LOG2GLPP.ORA' SIZ3 2M
  DATAFILE
    'F:\DB\ORADATA\GLPP\SYSTEM\SYS1GLPP.DBF',
    'D:\DB\ORADATA\GLPP\DATA\DADOS1GLPP.DBF',
    'E:\DB\ORADATA\GLPP\INDEX\IND1GLPP.DBF',
    'E:\DB\ORADATA\GLPP\RBS\RBS1GLPP.DBF',
    'D:\DB\ORADATA\GLPP\TEMP\TEMP1GLPP.DBF';

3- se a base de dados foi fechada de forma abrupta, ou se juntamente com o controlfile foram
   perdidos, alguns datafiles, entao deve ser emitido o seguinte comando ( depois de repor as
   copias de backup do datafiles )

   RECOVER DATABASE;

4- arquivar todos os logs

   ALTER SYSTEM ARCHIVE LOG ALL;

5- abrir a base de dados

   ALTER DATABASE OPEN;

-----------------------------------------------------------------------------------------------
  
CENARIO 12: ( perda datafiles sem segmento de rollback ativos )

perda de um datafile que nao seja pertencente ao tablespace SYSTEM, nem que tenha criados
segmentos de rollback.

1- fechar a base de dados ( usar ABORT se necessario )

   SHUTDOWN ABORT;

2- repor a copia antiga dos datafiles afetados
3- levantar a base de dados em estado MOUNT

   STARTUP MOUNT;

agora existe 3 alternativas possiveis:
--------------------------------------

recuperacao a nivel da base:
RECOVER DATABASE;
ALTER DATABASE OPEN;

recuperacao ao nivel do tablespace:
emitir tantos comandos deste tipo quantos os ficheiros perdidos:
ALTER DATABASE DATAFILE <nome_datafile> offline;
ALTER DATABASE OPEN;

emitir tantos comandos deste tipo quantos os tablespaces afetados pela perda de datafiles:
ALTER TABLESPACE TS_DADOS OFFLINE IMMEDIATE;
RECOVER TS_DADOS;
ALTER TABLESPACE TS_DADOS ONLINE;

recuperacao ao nivel do datafile:
ALTER DATABASE DATAFILE <nome_datafile> offline;
ALTER DATABASE OPEN;

emitir tantos comandos deste tipo quanto os datafiles afetados pela perda:
RECOVER DATAFILE <nome_datafile>;
ALTER DATAFILE <nome_tablespace> online;


-----------------------------------------------------------------------------------------------

CENARIO 13: ( perda de datafiles do tablespace SYSTEM )

perda de datafile que pertenca ao tablespace SYSTEM

1- repor a copia de backup
2- abrir a base de dados em estado MOUNT
3- recuperar ao nivel da base de dados
   RECOVER DATABASE;
4- abrir a base de dados com a clausula RESETLOGS
   ALTER DATABASE OPEN RESETLOGS;

------------------------------------------------------------------------------------------------

CENARIO 14: ( perda de datafiles com segmentos de rollback ativos )

perda de uma datafile que nao pertenca ao tablespace SYSTEM, mas que possua segmentos de 
rollback ativos.

1- repor a copia de backup 
2- abrir a base de dados em estado MOUNT

   STARTUP MOUNT;

3- colocar o datafile em estado offline

   ALTER DATAFILE <nome_datafile> offline;

4- abrir a base de dados em modo RESTRICT

   STARTUP RESTRICT;

5- recuperar ao nivel do tablespace

   RECOVER TABLESPACE TS_DADOS;

6- colocar o datafile em online

   ALTER DATABASE <nome_datafile> online;

7- colocar todos os segmentos de rollback estao com o estado 'NEEDS RECOVERY' em online

   ALTER ROLLBACK SEGMENTE RBS1 ONLINE;

8- fechar a base de dados e fazer um backup a frio
9- abrir a base de dados para os usuarios

-----------------------------------------------------------------------------------------------

COMO RESOLVER O ERRO SNAPSHOT TOO OLD ???

solucao: quando uma query longa inicia a imagem dos dados esta consistente na base de dados.
se por acaso durante a query a tabela for alterada a pesquisa passa a fazer a leitura no
segmento de rollback para onde foi enviada a imagem anterior a alteracao. se ainda durante a 
query a transacao que alterou os dados for confirmada, os dados que estavam no segmento de
rollback permanecem la ate acontecer uma das seguintes operacoes:

1-uma transacao ativa necessita de mais espaco e sobrepoe os seus dados aos dados da query
2-for emitido um comando de SHRINK (SMON ou DBA) e os extents onde estavam os dados foram libertados

quando isto acontece a sessao que lancou a query recebe o erro SNAPSHOT TOO OLD e a query nao 
consegue concluir com exito ( tambem porque nao tem dados para devolver ).
  
   existem duas formas de evitar este erro:

   1-evitar valores OPTIMAL que possam ser pequenos para todas as situacoes
   2- marcar a operacao de leitura para que os blocos afectados nao sejam removidos do segmento de rollback

a primeira recomendaçao pretente evitar que os dados seja expulsos do segmento, devido ao valor
do parametro de storage OPTIMAL permitir um numero desconfortavel de libertaçoes de extents.
a segunda recomendaçao o objetivo é o mesmo evitar que os dados seja alguma vez libertados ou ate
sobrepostos. consegue-se usando o seguinte comando que deve ser o primeiro comando da transacao.

  SET TRANSACTION READ ONLY


