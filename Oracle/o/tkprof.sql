/*

   TKPROF 

   executar o script UTLTKPRF.SQL que em /orant/rdbms80/admin sob o schema sys 

*/

1-no init.ora colocar o parametro TIMED_STATISTICS=TRUE
2-no init.ora colocar o parametro SQL_TRACE=TRUE ou na sessao que esta rodando a instrucao
  de SQL fazer antes ALTER SESSION SET SQL_TRACE=TRUE
3-rodar o programa ou instrucao SQL
4-a localizacao do ficheiro esta em conformidade com o parametro USER_DUMP_DEST no init.ora
5-rode o TKPROF da seguinte forma:

   TKPROF ORA11277.trc ouput=11277.out explain=/

6-analise o arquivo formatado.

