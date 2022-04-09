/*
  script:   add_dblink.sql
  objetivo: criar db_link
  autor:    Josivan
  data:     
*/

--
-- db link para conectar-se com o SAP, nao pode ser emitidos comando ddl 
-- sobre objetos referenciados atraves de database link
-- o parametro USING é para definir a string de conexao
create database link db_clientes
  identified by galpsapdba
     connect to galpsapdba
          using GLPPSAP;

create synonym clientes for db_clientes@zvpkna1;

drop database link db_clientes;