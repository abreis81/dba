/* 
  script:   vershare.sql
  objetivo: 
  autor:    Josivan
  data:     
*/

set pause on
--
  select substr(sql_text,1,45) Comando
        ,substr(module,1,25)   Executavel
    from v$sqlarea
order by FIRST_LOAD_TIME desc
/

set pause off

