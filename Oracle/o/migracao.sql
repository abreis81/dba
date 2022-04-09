/*

  reconstruindo uma tabela para eliminar a migration

*/

1-criar uma tabela nova com um nome diferente e com dados e estrutura da tabela original

  create table cliente_tmp 
  pctfree 5
  storage( initial 500k )
  as select * from cliente;

2-dropar a tabela original

  drop table cliente;

3-modificar o nome da tabela temporaria  ( so oracle 8 )

  alter table cliente_tmp to cliente;

4-recriar as constraints

