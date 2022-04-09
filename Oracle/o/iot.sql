/*

   IOT - index organized tables

   uma tabela organizada como um indice significa que nao existe nenhum segmento de dados
   associado a tabela, pelo que os dados da tabela estao armazenados no indice da sua
   chave primaria. quer dizer que a tabela eh o indice. sempre que possivel devem ser
   evitados transbordos numa index organized table

*/

os IOTs possuem as seguintes caracteristicas:
---------------------------------------------
1-estao sempre ordenados pela chave primaria, por isso e desnecessario tentar ordenar as pesquisas pelas colunas que compoem a primary key
2-nao possuem rowid em oracle 8.x onde cada linha eh univocamente identificada pela chave primaria. no oracle 8i existe um novo identificador o UROWID
3-nao podem ser particiondas, excepto em oracle 8i
4-nao permite mais nenhum indice em oracle 8.x alem da chave primaria. em oracle 8i pode
5-a constraint  que implementa a IOT nao pode ser desativada 
6-nao sao permitidas restricoes do tipo UNIQUE, a explica eh devido esta constraint criar um indice unico e como nao sao permitido mais indices alem da chave primaria. em oracle 8i esta limitacao desapareceu
7-as IOTs nao podem fazer parte de um cluster
8-a IOT nao pode ter coluna do tipo LONG apesar de ser possivel colunas do tipo LOB ou object types
9-cada operacao de update sobre a chave primaria ou delete implica uma reconstrucao do respectivo indice


create table requisicao
( cod_livro        number
 ,cod_socio        number
 ,data_req         date
 ,obs              varchar2(1000)
 ,constraints pk_requisicao primary key (cod_livro,cod_socio ))
 ORGANIZATION INDEX
 tablespace ts_indice
 pctthreshold 30                -- indica qual o percentual maximo do bloco que uma linha pode ocupar e admite valores de 0 a 50. 30% significa que apos este percentual sera feito um transbordo
 including obs                  -- indica a coluna onde ocorrera o transbordo, se nao for indicado o oracle assume por default que transbordara todas as colunas que nao estiver contida na chave primaria
 overflow tablespace ts_dados;  -- ao ocorrer o transbordo sera criado um segmento do tipo tabela que possui um nome gerado pelo oracle server com o formato SYS_IOT_OVER_<numero> e eh colocado no tablespace indicado pela clausula OVERFLOW


 .os IOTs

 select table_name
       ,iot_type
   from dba_tables
  where table_name = 'REQUISICAO';


 .simultaneamente na vista DBA_INDEXES podera ser consultada o restante da informacao IOT

 select index_name
       ,pct_threshold     -- percentual de ocupacao do bloco IOT
       ,include_column    -- indica o numero da coluna a partir de onde sera feito o transbordo
   from dba_indexes
  where table_name = 'REQUISICAO';


  . apos o transbordo pode ser verificado o novo segmento que o oracle server cria SYS_IOT_OVER_<numero>

  select table_name
        ,iot_name
        ,iot_type
    from dba_tables
   where iot_name is not null;
