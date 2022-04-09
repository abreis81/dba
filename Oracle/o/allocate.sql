/*

  alocacao de extents para o segemento tipo:    TABLE, INDEX ou CLUSTER

  este comando ira allocate um extent no tamanho especificado, o DBA devera
  ficar atento pois fazendo esta operacao retirar o oracle server o custo de fazer
  no momento que o mesmo reclamar espaco no segmento.

*/

alter table trans_abast
allocate extent 
( size 50m datafile '/db/oradata/glpp/data/d01glpp.dbf' );

