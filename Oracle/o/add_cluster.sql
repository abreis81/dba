/*

  os CLUSTERS sao uma forma alternativa de armazenar duas ou mais tabelas dentro do mesmo
  segmento e consequentemente dentro dos mesmos blocos de dados. as tabelas precisam apenas
  possuir uma ou mais colunas em comum, naquilo que vai constituir a CLUSTER KEY.

  CLUSTER INDEXADO - o acesso eh feito atraves de um indice construidos com base nos valores da chave do cluster
  HASH CLUSTER     - o acesso eh feito com base num HASH CLUSTER nao eh feito por um indice.
                     no lugar do indice eh usada uma funcao que com base no valor da chave
                     devolve a posicao onde respectivo grupo se encontra. esta funcao chama-se
                     HASHING.


  DBA_CLUSTERS                 - todos os clusters criados
  DBA_CLU_COLUMNS              - todas as colunas que compoem a chave do cluster
  DBA_CLUSTER_HASH_EXPRESSIONS - texto com as funcoes da hashing 

*/

1- criacao do cluster indicando qual eh o nome e o tipo da chave
2- criacao do indice do cluster ( so para cluster indexados )
3- criacao das tabelas que vao compor o cluster

CLUSTER INDEXADOS
-----------------

item 1
------
create cluster socio_req
(cod_socio  number(9))
 pctfree 15
 size 1000
 storage( initial 1m 
             next 1m
       maxextents 140
      pctincrease 0 )
tablespace dados;

item 2
------
create index socio_req_cluster
on cluster socio_req
tablespace indice
storage( pctincrease 0 );



HASH CLUSTER
------------

item 1
------
create cluster socio_req_h
(cod_socio   number(9))
hash is cod_socio/(cod_socio+10) hashkeys 501
pctfree 15
size 1000
 storage( initial 1m 
             next 1m
       maxextents 140
      pctincrease 0 )
tablespace dados;




item 3 vale para cluster indexado ou hash
-----------------------------------------

create table socio
(codigo   number(9)
..... )
cluster socio_req(codigo);

create table requisicao
(cod_socio number(9)
.... )
cluster socio_req(cod_socio);


