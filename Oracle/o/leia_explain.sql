/*

  explicacao de planos

*/

TABLE ACCESS FULL (FTS)            = acesso full a tabela ( full table scan) leitura de todos os blocos constituintes do objeto
TABLE ACCESS BY ROWID <nome_table> = permite um acesso direto a localizacao da linha, eh o acesso mais rapido existente
TABLE ACCESS CLUSTER <nome_table>  = com base num valor especifico da chave do cluster sao percorridos os blocos do segmento que sustenta o indice do cluster e comparados com o valor que la se encontra, no sentido de obter o ROWID.
TABLE ACCESS HASH <nome_table>     = o acesso por hash-key eh feito sobre cluster do tipo hash. o valor da chave do cluster presente na condicao e aplicado a funcao de hash no sentido de obter a hash-key com a qual vao ser percorridos todos os blocos do segmento que suporta o hash-cluster. todas as tabelas que compoem o hash-cluster e que contem o mesmo valor para o hash-key estao guardadas no mesmo bloco e resultado da funcao de hash vai ser comparado com o cabecalho de cada bloco.
INDEX UNIQUE SCAN <nome_indice>    = se for um indice unico, o acesso apenas se compoe de uma procura do ROWID. quando o acesso ao indice unico eh originado por uma condicao sem o operador igual o que vai gera no plano o acesso composto por duas frases: pesquisa do valor e depois pesquisa do ROWID que identifica no plano como INDEX RANGE SCAN <nome_indice>
FULL SCAN                          = acesso full dos blocos que compoem um indice
FAST FULL SCAN                     = acesso ao indice
