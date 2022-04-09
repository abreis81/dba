/*

  procedimento para realizacao do backup a quente


*/


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


