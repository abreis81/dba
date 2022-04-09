/*

 particao: o objetivo e motivacao de particionamento eh a divisao em unidades logicas
           menores de tabelas e indices. as operacoes de backup online podem ser feita
           a nivel da particao e sao permitidos locks ao nivel da particao.

*/

 os principais pontos a ter em conta sobre as particoes sao:
 -----------------------------------------------------------
 1-cada tabela pode ser dividida num valor maximo de 64 mil particoes
 2-todas as particoes tem a mesma estrutura logica( coluna e constraints )
 3-cada particao constitui um segmento distinto, com os seus proprios parametros de storage e seus proprios tablespace (opcional)
 4-as particoes sao definidas no momento em que a tabela eh criada com base nos valores de uma ou mais colunas da tabela ( chave de particao )
 5-a separacao das linhas entre as particoes eh feita em run-time no momento da inclusao da linha, com base nos valores que estao a ser inseridos para a chave de particao
 6-a alteracao da arquitetura de particoes possui algumas limitacoes; no entanto permite, adicionar novas particoes, remover particoes individuais, modificar os parametros de storage de uma particao, dividir uma particao em duas e fundir duas particoes numa so


 as principais restricoes as particoes sao:
 ------------------------------------------
 1-nao eh possivel mover um registro de uma particao para outra (modificar o valor das colunas que constituem a chave de particao )
 2-tabelas com colunas do tipo LONG, LONG RAW, tipo LOB ou com OBJECT TYPE nao podem ser particionadas
 3-as tabelas organizadas como indices(IOTs) nao podem ser particiondas


 existem dos metodos de criacao de particoes:
 --------------------------------------------
 UNICOLUNA
 MULTICOLUNA 


 particao UNICOLUNA
 ------------------

 CREATE TABLE REQUISICAO
 ( COD_LIVRO     NUMBER REFERENCES LIVRO(CODIGO)
  ,COD_SOCIO     NUMBER REFERENCES SOCIO(CODIGO)
  ,DATA_REQ      DATE
  ,DATA_EXP      DATE
  ,MES_REQ       NUMBER
  ,constraint    req_pk primary key (cod_livro,cod_socio,data_req))
 PARTITION BY RANGE (MES_REQ)
   ( PARTITION jfm VALUES LESS THAN (4)
      ,TABLESPACE TS_DADOS1
      ,NOLOGGING
    ,PARTITION amj VALUES LESS THAN (7)
      ,TABLESPACE TS_DADOS2
      ,STORAGE( INITIAL 2M PCTINCREASE 0 )

    ,PARTITION jas VALUES LESS THAN (10)
      ,TABLESPACE TS_DADOS3

    ,PARTITION ond VALUES LESS THAN (13)
      ,TABLESPACE TS_DADOS4 );


 particao MULTICOLUNA
 --------------------

 .a primeira coluna da particao seguinte tem sempre de se maior que a primeira coluna da
  particao anterior. dentro do mesmo valor da primeira colua a segunda tem de ter tambem
  os valores em ordem crescente.

 CREATE TABLE REQUISICAO
 ( COD_LIVRO     NUMBER REFERENCES LIVRO(CODIGO)
  ,COD_SOCIO     NUMBER REFERENCES SOCIO(CODIGO)
  ,DATA_REQ      DATE
  ,DATA_EXP      DATE
  ,MES_REQ       NUMBER
  ,constraint    req_pk primary key (cod_livro,cod_socio,data_req))
 PARTITION BY RANGE (COD_LIVRO,COD_SOCIO)
   PARTITION p1 VALUES LESS THAN (10,5)
  ,PARTITION p2 VALUES LESS THAN (10,10)
  ,PARTITION p3 VALUES LESS THAN (20,5)
  ,PARTITION p4 VALUES LESS THAN (30,10) );


 onde esta a linha
 -----------------

 .as particoes sao objetos da base de dados e tem informacoes na DBA_OBJECTS

 select rpad(object_name,15)     tabela
       ,rpad(subobject_name,10)  particao
       ,object_id
   from dba_objects
  where object_type = 'TABLE PARTITION';



 .com o resultado da coluna object_id fica facil descobrir onde esta cada linha

 select cod_livro
       ,cod_socio
       ,data_req
       ,data_exp
       ,mes_req
       ,decode(dbms_rowid.rowid_object(rowid),n1,'particao jfm'
                                             ,n2,'particao amj'
                                             ,n3,'particao jas'
                                             ,n4,'particao ond') "particao da linha"
   from requisicao;



 .pesquisar as tabela particionadas

 SELECT * FROM requisicao PARTITION (p4);



 .adicionar particoes
 
 ALTER TABLE requisicao
 ADD PARTITION p5
 VALUES LESS THAN (40,10) TABLESPACE ts_dados2;


 .truncar particoes, os indices nao particionados da tabela devem ser construidos depois
  do comando e as restricoes de integridade referencial devem ser desativadas antes da
  execucao; os indices reconstruidos incluem a propria chave primaria e por deve emitir
  o comando

   ALTER TABLE requisicao TRUNCATE PARTITION p2;

   ALTER INDEX pk_requisicao REBUILD;

 
 .eliminar particoes, os indices nao particionados da tabela devem ser construidos depois
  do comando e as restricoes de integridade referencial devem ser desativadas antes da
  execucao; os indices reconstruidos incluem a propria chave primaria e por deve emitir
  o comando

  ALTER TABLE requisicao DROP PARTITION p1;

  ALTER INDEX pk_requisicao REBUILD;



 .dividir a particao

 ALTER TABLE requisicao SPLIT PARTITION ond
 AT (12)
 INTO ( PARTITION out_nov TABLESPACE ts_dados3
       ,PARTITION dez );

 
 .modificacoes permitidas para uma particao

 1) mover uma particao de tablespace

      ALTER TABLE requisicao MOVE PARTITION jfm TABLESPACE ts_dados9;

 2) modificar os parametros de storage

      ALTER TABLE requisicao MODIFY PARTITION amj STORAGE( MAXEXTENTS 100 ) NOLOGGING;

 3) troca de dados com uma tabela nao particionada
  
      ALTER TABLE requisicao EXCHANGE PARTITION jfm WITH TABLE requisicao_tmp;

 4) mudar o nome de uma particao

      ALTER TABLE requisicao RENAME PARTITION ond TO out_nov_dez;
