/*
  script:   cal_index.sql
  objetivo: calcular o tamanho do indice
  autor:    Josivan
  data:     
*/

/*------------------------------------------------------------------------------------*/
|| per_cresc        : percentual de crescimento anual projetado                       ||
|| row_count        : total de linhas projetado para o indice                         ||
|| tam_block        : tamanho do bloco da base de dados (2048,4096....)               ||
|| initrans         : quantidade de extents inicial                                   ||
|| percent_free     : pctfree para update e delete                                    ||
|| uniqueness       : ?????                                                           ||
|| number_col_index : numero de colunas no index ( se chave composta )                ||
|| total_col_length : comprimento da linha de dados, somando-se todos os atributos    ||
*/------------------------------------------------------------------------------------*/

select greatest(4, (1+(per_cres/100)) * ((&row_count / (( floor (((&tam_block - 113 - (&initrans * 23)) * 
        (1-(&percent_free/100.))) / ((10+&uniqueness)+&number_col_index+(&total_col_length))))))*2))
  from dual
/
