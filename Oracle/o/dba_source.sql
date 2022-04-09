/*
  script:   procedure_source.sql
  objetivo: Relatorio diario 
  autor:    Josivan
  data:     
*/

--
accept objeto prompt "Entre nome da procedure ou funcao : "
--
set heading off
set pages 1000
set linesize 100
set termout off
set feedback off
set verify off
--
spool r_proc.sql
--
select decode(line,1,'create or replace '||text,text)
  from dba_source
 where name = upper('&objeto')
/
spool off

set heading on
set termout on
set feedback on
set verify on
