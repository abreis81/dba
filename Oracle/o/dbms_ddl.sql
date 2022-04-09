/*
  SCRIPT:   dbms_ddl.sql
  OBJETIVO: calcular estatisticas para os objetos
  AUTOR:    JOSIVAN
  DATA:     2000.02.08   

  parametros: tipo_de_objeto     - table, index, cluster
              owner_do_objeto    - proprietario do objeto
              nome_do_objeto     - nome do objeto
              metodo             - estimate, compute, delete
              linhas             - quantas linhas deve considerar ( normal é 0 )
              percentagem        - quando metodo for estimate, pode usar um percentual
              metodo_opcional    - alem do objeto, pode considerar: FOR TABLE
                                                                    FOR ALL
                                                                    FOR ALL INDEXES
              
  observacao: executar o script DBMSUTIL.SQL sob o esquema sys

*/

declare

  cursor c_tabela is
    select owner
          ,table_name
          ,object_type
      from dba_objects
     where object_type in ( 'TABLE','INDEX','CLUSTER' );

begin

  for rc_tabela in c_tabela loop
      dbms_ddl.analyze_object( rc_tabela.object_type
                              ,rc_tabela.owner
                              ,rc_tabela.table_name
                              ,'ESTIMATE'
                              ,null
                              ,20
                              ,'FOR ALL INDEXES')
  end loop;

end;
/

