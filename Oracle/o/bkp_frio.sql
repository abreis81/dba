/*

  procedimento para backup a frio

*/


1- fechar a base de dados de forma limpa ( shutdown normal/transactional )
2- copiar todos os datafiles que compoem a base de dados, para os nomes dos arquivos ver as views:

         - V$DATAFILE    \
         - V$CONTROLFILE  - fazer select nas visoes
         - V$LOGFILE     /
         ---- mais os arquivos:
         - INIT.ORA
         - LISTENER.ORA
         - SQLNET.ORA
         - TNSNAMES.ORA

3- abrir a base de dados para os usuarios


obs: a copia deverá ser feita via sistema operacional:
     
       se UNIX:   TAR ....
       se NT:     COPY ...
