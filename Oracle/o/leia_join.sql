/*

  metodos de join

*/

MERGE JOIN / SORT JOIN = eh a implementacao mais simples de uma operacao de join, uma vez que ordena ( SORT JOIN ) as duas tabelas separadamente e depois junta as linhas. ( muito demorada )
NESTED LOOPS           = quando existe um indice envolvido na condicao de juncao eh usada esta implementacao. a palavra loop denota que existe um processo iterativo: para cada linha da primeira tabela vao ser pesquisadas as linhas da segunda tabela. para tal deve existir um indice para segunda tabela, o optimizador encarrega-se de colocar como segunda tabela aquela que tiver o indice da condicao. a primeira tabela sera lida como FTS pois e a que nao tem indice.
HASH JOIN              = os join sao feito conforme estao dispostos as entidas na clausula FROM.  JOIN(A,B,C) fará a juncao de AxB e o resultado será comparado a C
                         select /*+ORDERED */ .....  as tabelas menores deverao ser mencionadas antes.

OPTIMIZAR UM NESTED LOOPS
-------------------------

1-criar um indice na tabela maior e deixar o FTS para a tabela mais pequena
2-o optimizador baseado em regras vair fazer por predefinicao um FTS a ultima tabela
  que for especificada na clausula FROM portando para evitar esta via, devem ser geradas
  estatisticas com o comando ANALYZE de modo a ser usado o optimizador baseado em custos
3-quando existem tres tabelas a tendencia de NESTED LOOPS e utilizar o resultado do primeiro
  join como conjunto alvo de FTS, para aceder por indice a tabela restante. ter em atencao
  os tamanhos envolvidos nestes casos.


HASH JOIN
---------

eh o metodo que encontra a sua maior utilizacao em sistemas OLTP e cuja utilizacao esta
condicionada por dois parametros de inicializacao que devem ter os seguintes valores:

      HASH_JOIN_ENABLE = TRUE
      OPTIMIZER_MODE   = ALL_ROWS ou CHOOSE

