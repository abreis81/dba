/*

   informacoes sobre backup 

*/

BACKUP A FRIO
-------------

1-fechar a base de dados de forma NORMAL


LISTENER.ORA
TNSNAMES.ORA
SQLNET.ORA

V$DATAFILE
V$CONTROLFILE
V$LOGFILE

BACKUP A FRIO OFF-LINE
----------------------

1-e possivel fazer um backup a frio com a base de dados levantada 
  colocando a tablespace em offline e procedendo com o backup a frio dos datafiles deste
  tablespace. verificar se nao tem nenhum usuario usando algum objeto da tablespace.


BACKUP A QUENTE - ONLINE
------------------------

1- a base de dados deverá está em modo arquivo ( archive log )
2- acessar o svrmgr e emitir o comando ARCHIVE LOG LIST, anotando o numero do ultimo archive (LSN)
3- alter tablespace ts_dados begin backup
4- copia via sistema operacional todos os datafiles que compoem a tablespace
5- alter tablespace ts_dados end backup
6- acessar o svrmgr ( ARCHIVE LOG LIST ) anotar o numero do LSN ( log sequence number ) atual
7- guardar em backup todos os archives no intervalo gerado, junto ao diretorio dos datafiles
8- fazer copia binaria do controlfile como o comando
   ( alter database backup controlfile to 'd:\db\oradata\ocpe\backup\ctlocpe.ora' )
9- e desaconselhavel que seja feito backup online para mais de um tablespace


BACKUP DO CONTROLFILE
---------------------

-- copia binaria, fiel
alter database backup controlfile to 'e:\db\oradata\glpp\backup\ctl1glpp.ora' reuse;


--
-- este comando gera um script com recriacao do controlfile, o arquivo e gravado
-- no destino do parametro BACKGROUND_DUMP_DEST
-- Este so pode ser utilizado na recuperacao da base de dados se for desde o inicio
-- pois o mesmo nao guarda informacoes como o LSN ( log sequence number ), SCN ( sequence change number )
-- e outros
--
alter database backup controlfile to trace resetlogs


BACKUP LOGICO
-------------

via utilitario EXP


