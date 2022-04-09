/*

  index

*/

nao sao so as tabelas que podem ser divididas em particoes, os indices tambem permitem
essa divisao. contudo o particionamento dos indices esta estritamente relacionado com 
o tipo de particionamento usado para as tabelas.

quando eh usado a opcao de particoes, os indices passam a dividir-se em:
------------------------------------------------------------------------

1-indices nao particionados
2-indices globais
3-indices locais
4-indices prefixados
5-indices nao prefixados


indices globais vs locais
-------------------------

um indice eh GLOBAL quando nao existe necessariamente uma relacao de equiparticao entre o 
indice e a respectiva tabela particionada; ou seja uma particao pode conter entradas para
linhas que se encontram em distintas particoes da tabela.

create index idx_requisicao_mes_req on requisicao(mes_req)
global
partition by range (mes_req)
  ( partition indpart1 values less than (7)  tablespace ts_indice1    
   ,partition indpart2 values less than (13) tablespace ts_indice2 );

os indices LOCAIS sao criados quando se deseja que exista uma relacao de equiparticionamento
entre o indice e a tabela, de modo a gerar uma B-TREE por cada particao da tabela. este tipo
de indice eh mantido automaticamente pelo oracle server e apresenta performace superior ao 
indice GLOBAL dado que uma operacao de manutencao numa particao da tabela apenas exige uma
reconstrucao da B-Tree correspondente a particao

.o numero de particoes do indice local eh obrigatoriamente igual ao numero de particoes
 da tabela particionada

create index idx_requisicao_mes_req 
on requisicao(mes_req)
local
( partition indpart1 tablespace ts_indices01
 ,partition indpart2 tablespace ts_indices02
    storage( initial 500k )
 ,partition indpart3 tablespace ts_indices03
 ,partition indpart4 tablespace ts_indices04 );


indices prefixados
------------------

um indice prefixado significa que as primeiras colunas do indice sao as mesmas primeiras
colunas da chave de particao da tabela.

chave de particao (colunax)
indice abc_ind(colunay, colunax, colunaz)
indice xpto_ind(colunax, colunaz)
indice zyx_ind(colunax)

zyx_ind e xpto_ind sao prefixado, ao passo que abc_ind eh nao prefixado.

.sempre que possivel deve ser usado um indice local prefixado para tabelas particionadas.
 se a ultima particao da tabela contiver MAXVALUE, substitua por um valor hard-coded muito
 alto, de modo a poder usar indices locais.


indice de chave invertida ( reverse key )
-----------------------------------------

quando a arvore de blocos que implementa o indice eh criada com base em colunas de valores
sequenciais ( tipicamente chaves primarias ), existe um certo desbalanceamento da estrutura
da arvore. para criar uma melhor distribuicao de valores, permitindo balancear a B-Tree o 
oracle 8 inverte a chave do indice. essa inversao apenas toma lugar no momento da criacao
da arvore, em indices muito grande e nao influencia em nada os valores das colunas indexadas

create unique index req_socio
on requisicao(cod_socio) REVERSE
storage( initial 200k
     pctincrease 0 )
tablespace ts_indice;

.a aplicacao dos indices de chave invertida apenas eh permitida com indices do tipo B-TREE

.um indice que nao esta construido deste modo pode ser convertido e vice versa

  ALTER INDEX <nome_indice> REBUILD REVERSE;
  ALTER INDEX <nome_indice> REBUILD NOREVERSE;

