-- notas:
1- nao pode ser removido um membro do grupo atual, nem um grupo que ainda nao foi arquivado
2- a exclusao falha se ficar menos de dois membros por grupo
3- a exclusao nao remove os ficheiros fisicamente
4- LSN - log sequence number eh o numero sequencial registrado no control file sempre que eh
   gravado um LOGFILE e para posterir recuperacao da base se for necessario. esto numero eh
   incrementado sempre que o oracle faz um log switches. o LSN mais recente corresponde ao
   grupo de log corrente.
5- se a escrita do LGWR por algum motivo nao consegue ser realizada, entao a base de dados para.
6- adicionar um grupo de LOGFILE quando a frequencia de escrita do LGWR eh maior que a 
   velocidade de escrita do processo ARCH a base de dados terá problemas.
7- adicionar um membro no grupo de logfile para aumentar a resistencia a falhas da base de dados
8- aumentar o tamanho dos LOGFILES quando o processo DBWR nao consegue acabar a escrita dos 
   buffers em memoria. a deteccao deste surge no ALERT.LOG com a mensagem:
   "CHECKPOINT NOT COMPLETE", nao existe uma forma de aumentar um logfile o metodo eh 
   criar um novo grupo maior e excluir o menor.
9- para impedir o registro no redo log basta o objeto ser criado/alterado para NOLOGGING


VIEW
----
V$ARCHIVED_LOG      = ficheiros de log arquivados
V$ARCHIVE_DEST      = destinos possiveis de arquivo de redo log
V$LOG_HISTORY       = historico de archived logs disponiveis para aplicacao em recuperacao da base. a informacao desta view eh escrita pelo SMON para recuperacao automatica
V$DATAFILE_HEADER   = informacao de cabecalho dos datafiles - SCN, informacao de recuperacao, etc
V$BACKUP            = informacao sobre os datafiles que estao envolvidos num backup a quente - nao inclui os datafiles que estao offline
V$RECOVER_FILE      = datafiles que necessita de recuperacao
V$RECOVERY_PROGRESS = informacao sobre o processo de recuperacao

V$LOG               = informacoes sobre log files pai
V$LOGFILE           = informacoes sobre log files filho
V$THREAD            = LSN atribuido mais recentemente


--
-- para aumentar o tamanho dos logfiles, e necessario criar novos grupos com membros maiores e
-- excluir os grupos antigos
--

--
-- forcar a troca de grupo e consequentemente o incremento do LSN ( log sequence number )
--
alter system switch logfile;     ( forca a troca de grupo )
alter system flush shared_pool;  ( reseta a SGA )
alter system checkpoint;         ( grava conteudo nos datafiles );

--
-- adicionando um grupo, isto pode ser necessario devido o LGWR esta sendo mais rapido que ARCH
--
alter database glpp
add logfile group 5
('e:\db\oradata\glpp\system\log5aglpp.ora','e:\db\oradata\glpp\system\log5bglpp.ora') size 2m;
ou
alter database 
add logfile 
('/usr/....','/usr/....) size 1m;

--
-- adicionar um novo membro ao grupo
--
alter database glpp
add logfile member
('e:\db\oradata\glpp\system\log1cglpp.ora','e:\db\oradata\glpp\system\log1dglpp.ora') to group 1,
('e:\db\oradata\glpp\system\log2cglpp.ora','e:\db\oradata\glpp\system\log2dglpp.ora') to group 2;

ou

alter database
add logfile member
'/usr/....' to group 1,
'/usr/....' to group 2;

--
-- remover um grupo de log
--
alter database glpp
drop logfile group 1,group 2;

ou

alter database
drop logfile group 2;


--
-- remover um membro do grupo
--
alter database glpp
drop logfile member
('e:\db\oradata\glpp\system\l31.ora'),
('e:\db\oradata\glpp\system\l32.ora');

ou

alter database
drop logfile member
'/usr/...';



--
-- para mudar um logfile/datafile de disco/nome seguir o procedimento abaixo:
--
1- fechar a instance em modo normal ( shutdown normal/transaction )
2- fazer uma copia do logfile/datafile ( via sistema operacional )
3- iniciar a instance em estado MOUNT
4- alter database rename file 'e:\db\oradata\glpp\system\log1aglpp.ora' to 'f:\db\oradata\glpp\system\log1aglpp.ora';
5- abrir a base de dados
6- fazer shutdown 
7- abrir novamente disponibilizando para os usuarios

--
-- outros
--
alter database add logfile group 4
('/producao/redu2/redoproducao04.log') size 2m;

alter database add logfile group 5
('/producao/redu2/redoproducao05.log') size 2m;

alter database add logfile group 6
('/producao/redu2/redoproducao06.log') size 2m;

alter database rename lofile '/disco1/.../log1glpp.ora'   to   '/disco2/.../log1glpp.ora'

alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;
 


-- LSN mais recente
select max(sequence#) "log sequence number"
from v$log;

ou

select sequence# "log sequence number" from v$thread;


-- qual é o SCN atual
select max(checkpoint_change#) SCN
from v$datafile_header;

-----------------------------------------------------------------------------------------------
obs: o parametro LOG_FILES define o numero maximo atual de grupos de logs que podem
     ser abertos durante a execucao para o banco de dados e nao pode exceder MAXLOGFILES
     definido na criacao da base de dados

o parametro FAST_START_IO_TARGET determina o numero de buffers gravados pelo processo
DBWn, aplicavel na versao 8.1 so para a ENTERPRISE EDITION, quanto menor o valor deste parametro melhor 
o desempenho da recuperacao 

LOG_CHECKPOINT_TO_ALERT=FALSE ( se definido como TRUE as informacoes a cada checkpoint sao gravadas no ALERT.LOG )
LOG_CHECKPOINT_INTERVAL= ( valor em blocos do sistema operacional para um CHECKPOINT )
LOG_CHECKPOINT_TIMEOUT= (valor em segundos em que sera disparado um CHECKPOINT )
LOG_ARCHIVE_START=TRUE ( o arquivamento sera realizado automaticamente )

-----------------------------------------------------------------------------------------------

informacoes do grupo de redo log file on-line: ( STATUS )

UNUSED           = grupo nunca foi gravado 
CURRENT          = grupo de redo log on-line e eh o grupo atual
ACTIVE           = grupo de redo log on-line esta ativo, mas nao eh o grupo atual, pode esta em uso na recuperacao de blocos
CLEARING         = grupo esta sendo recriado como um log vazio apos um ALTER DATABASE CLEAR LOGFILE
CLEARING_CURRENT = indica que um thread fechado esta sendo eliminado do arquivo de log atual. o log permancera nesse estado se ocorrer um error de i/o ao gravar o novo cabecalho do log
INACTIVE         = grupo de redo log on-line nao eh mais necessario para recuperacao da instance.


informacoes sobre membro de um grupo on-line: ( STATUS )

INVALID = membro inacessivel
STALE   = conteudo do arquivo esta incompleto: eh necessaria a adicao de um membro de arquivo de log
DELETED = membro nao eh mais usado
        = espaco em branco indica que o arquivo esta em uso

-----------------------------------------------------------------------------------------------

ALTER DATABASE CLEAR LOGFILE
'/usr/..../log2a.rdo' UNARCHIVED;

o uso desse comando equivale a excluir e criar um arquivo de redo log on-line. quando o arquivo
nao estiver arquivo devera utilizar a clausula UNARCHIVED.

