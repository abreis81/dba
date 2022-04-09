/*

  add_logmnr.sql
  josivan

  aplicavel somente para versao 8i

*/

1-especificar UTL_FILE_DIR

2-execute o procedimento DBMS_LOGMNR_D.BUILD para criar o arquivo de dicionario

  EXECUTE DBMS_LOGMNR_D.BUILD('v815dict.ora', 'c:\ora815\admin\v815\log');

3-configurando uma nova lista

  EXECUTE DBMS_LOGMNR.ADD_LOGFILE('/usr/..../log2a.rdo', DBMS_LOGMNR.NEW);

4-adicionar arquivo de redo log

  EXECUTE DBMS_LOGMNR.ADD_LOGFILE('/usr/..../log2a.rdo',DBMS_LOGMNR.ADDFILE);

5-inicializar a lista

  EXECUTE DBMS_LOGMNR.START_LOGMNR( DICTFILENAME=>'c:\ora815\admin\v815\log\v815dict.ora');

6-removendo um arquivo de redo da lista

  EXECUTE DBMS_LOGMNR.REMOVEFILE

7-finalizando a analise

  EXECUTE DBMS_LOGMNR.END_LOGMNR;


obs: log2a.rdo sera gravado no path definido em UTL_FILE_DIR para analise futura.
     analise a view

 V$LOGMNR_CONTENTS
 V$LOGMNR_DICTIONARY
 V$LOGMNR_PARAMETERS


