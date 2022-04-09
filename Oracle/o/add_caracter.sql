/*

  add_caracter.sql
  josivan

*/

o oracle server suporte os conjuntos de caracteres:

1-conjunto de caracteres de byte simples

    7 bits   --> 128 caracteres   ( US7ASCII )       --> estados unidos da america
    8 bits   --> 256 caracteres   ( WE8ISO8859P1, WE8EBCDIC500, WE8DEC ) --> europa ocidental 

2-conjunto de caracteres de largura variavel
3-conjunto de caracteres de largura fixa
4-caracteres unicode ( UTF8, AL24UTFFSS )


parametros:

NLS_LANGUAGE
-idioma para mensagens oracle
-nomes de dia e mes
-simbolos para dc ac am pm
-mecanismo de classificacao padrao

NLS_TERRITORY
-formato da data
-caracter decimal e separador de grupo
-simbolo da moeda local
-simbolo de moeda ISO
-calculo do numero de semana ISO
-dia inicial da semana

