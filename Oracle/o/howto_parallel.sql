/*

  parallel dml

*/

o objetivo primordial da paralelizacao de DML eh o aumento da velocidade na execucao destas
operacoes sobre grandes tabelas. em oracle 8 torna-se possivel paralelizar comandos dml,
precisamente devido a introducao da possibilidade de particionar as tabelas e indices.
no entanto os sistemas que melhor se adaptam ao paralelismo sao aqueles que possuirem mais
processadores, mais discos e cuja divisao de ficheiros tenha sido feita de acordo.

RESTRICAO AO PARALLEL DML
-------------------------
1-nao pode ser usado tabelas que incluam tipo LONG/LOB ou object types
2-as operacoes que envolvam indices bitmap nao podem ser paralelizadas
3-as tabelas nao podem estar armazendas num segmento de cluster
4-nao eh permitido insert nem update paralelizado em tabelas com indices globais
5-os triggers da tabela nao podem estar ativos
6-as transacoes so podem possuir um comando de DML paralelizado e tem de ser o primeiro
7-nao sao permitidos comandos paralelizados de delete em cascata ( em relacao a integridade referencial )


.para efetuar operacoes de DML paralelizadas a nivel da sessao usar os comandos abaixo, porem
 antes ativar estes parametro devem ser confirmadas todas as alteracoes, terminando assim
 qualquer transacao que possa estar ativa.

 ALTER SESSION ENABLE PARALLEL DML;
 ALTER SESSION DISABLE PARALLEL DML;

.depois de ativado o modo de execucao paralela para a sessao, se o primeiro comando na
 transacao for um dos tres tipos abaixo, entao todas as dicas de paralelismo colocadas nos
 comandos seguintes serao ignoradas e o comando executara de modo serial.

 1-comandos DML de execucao serial
 2-lock table
 3-select for update


grau de paralelismo
-------------------

1-grau de paralelismo ao nivel da tabela
2-grau de paralelismo ao nivel do comando


grau de paralelismo ao nivel da tabela
--------------------------------------

create table autor
( codigo    number
 ,nome      varchar2(80)
 ,obs       clob )
 parallel (degree 3);


.alterar o grau de paralelismo

 alter table autor
 parallel (degree 5);


.verificar o grau de paralelismo
--------------------------------
 select table_name
       ,degree
   from dba_tables
  where table_name like 'AUTOR%';


.criando um indice paralelizado
-------------------------------
create index ix_teste01 on tab_teste(cd_codigo)
parallel( degree 10 )
nologging;


grau de paralelismo ao nivel do comando
---------------------------------------

update /* parallel(autor,5) */ autor
   set nome   = 'josivan'
 where codigo = 10;

.a sintax acima pode ser aplicada para: DELETE, INSERT, SELECT


outra forma 
-----------
select /*+FULL(trans_abast)PARALLEL(trans_abast,50)*/ nome,qt_litro from trans_abast

