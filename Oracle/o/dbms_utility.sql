/*
  SCRIPT:   dbms_utility.sql
  OBJETIVO: calcular estatisticas para o schema ou base de dados
  AUTOR:    JOSIVAN
  DATA:     2000.02.08   
            
  observacao: executar o script DBMSUTIL.SQL sob o esquema sys

*/

begin

  dbms_utility.analyze_database( 'ESTIMATE'
                                ,0
                                ,20
                                ,'FOR ALL INDEXES' );

end;
/

begin
  
  dbms_utility.analyze_schema( 'GALPDBA'
                              ,'ESTIMATE'
                              ,0
                              ,20
                              ,'FOR ALL INDEXES' );

end;
/

