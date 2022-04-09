/*
  COLOCAR A BASE DE DADOS EM MODO ARCHIVE

  medidas:  colocar a database em modo arquivo
            configurar a instance

VIEW
----
V$ARCHIVED_LOG      = ficheiros de log arquivados
V$ARCHIVE_DEST      = destinos possiveis de arquivo de redo log
V$LOG_HISTORY       = historico de archived logs disponiveis para aplicacao em recuperacao da base. a informacao desta view eh escrita pelo SMON para recuperacao automatica
V$DATAFILE_HEADER   = informacao de cabecalho dos datafiles - SCN, informacao de recuperacao, etc
V$BACKUP            = informacao sobre os datafiles que estao envolvidos num backup a quente - nao inclui os datafiles que estao offline
V$RECOVER_FILE      = datafiles que necessita de recuperacao
V$RECOVERY_PROGRESS = informacao sobre o processo de recuperacao

*/

observações:
1-garantir que os archive logs via processo ARCH serao gravados numa velocidade
  superior ao processo LGWR
2-nunca colocar os archive log no mesmo disco que estao os redo logs devido a 
  contencao de disco.
3-monitorar os archive logs devido ao espaco utilizado
4-ARCHIVE LOG LIST mostra se a base esta em modo archive

-- colocar a base de dados em modo arquivo
1- fechar a base de dados de forma limpa ( shutdown normal/transactional )
2- levantar a instance em estado MOUNT ( startup mount )
3- emitir o comando ALTER DATABASE ARCHIVELOG ( registra no controlfile )
4- fechar a base de dados
5- editar o INIT.ORA

       estatico
       -------- 
       LOG_ARCHIVE_START  = TRUE
       LOG_ARCHIVE_DEST   = E:\DB\ORADATA\GLPP\SYSTEM
       LOG_ARCHIVE_FORMAT = arch%s

6- abrir o base de dados ( startup )
7- se deseja pode duplexar os archives logs, gravando em outro disco/diretorio. 
   Estes parametros deverão ser executados com a base levantada.

       -- gravar copia do archive num outro diretorio
       ALTER SYSTEM SET LOG_ARCHIVE_DUPLEX_DEST = 'F:\DB\ORADATA\GLPP\SYSTEM';

       -- no ORACLE 8i pode gravar os ARCHIVES LOGS em ate 5 diretorios diferentes 
       ALTER SYSTEM SET LOG_ARCHIVE_DEST_5 = 'E:\DB\ORADATA\GLPP\SYSTEM';

       -- garante que a copia sera efetuada sem falhas e no ultimo sera sujeito a falhas
       ALTER SYSTEM SET LOG_ARCHIVE_MIN_SUCCED_DEST = 5;



--
-- archiving manual
--
ALTER SYSTEM ARCHIVE LOG ALL           ( arquivar todos logs marcados para arquivo )
ALTER SYSTEM ARCHIVE LOG SEQUENCE 1413 ( arquivar o log de numero 1413 )
ALTER SYSTEM ARCHIVE LOG NEXT          ( arquivamento do log a mais tempo )
ALTER SYSTEM ARCHIVE LOG CURRENT       ( forcar o arquivamento do grupo de log corrente )
ALTER DATABASE CLEAR UNARCHIVED LOG FILE /u01/....  ( tirar o log file de corrente )




--
-- comando para interromper e iniciar o processo ARCH com a base levantada
--
ALTER SYSTEM ARCHIVE LOG STOP
ALTER SYSTEM ARCHIVE LOG START 
