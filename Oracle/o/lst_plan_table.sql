rem 
rem  nome        : lst_plan_table.sql
rem  objetivo    : Listar Plan Table
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem 

    select lpad(' ',2*(level-1))||operation operation
          ,options
          ,object_name
          ,position
      from plan_table
     start with id = 0 
connect by prior id = parent_id
/

