rem 
rem  nome        : utl_comp.sql
rem  objetivo    : Criar script para compilar objetos
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem

rem
rem     Configurar Relatorio
rem
col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint
--
define p_sql       = utl_comp
define p_titulo    = 'Criar script para compilar objetos'
define p_tam_linha = 1000
define p_linhas    = 0
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
--
set termout off
--
select '&&p_dir_spool.&&p_sql.'||'.'||lower(name)  p_temp4
      ,lower(name)                                 p_temp3
      ,to_char(sysdate,'&&p_fmt_data')             p_temp1
      ,rpad('*', 80,'*')                           p_temp2	
  from v$database
/
set termout on

rem
rem	Identificacao do relatorio
rem
clear screen
prompt
prompt Script : &&p_sql.
prompt Titulo : &&p_titulo.
prompt
prompt Spool  : &&p_spool.
prompt Report : &&p_tam_linha. colunas
prompt &&p_traco.
prompt 

rem
rem	Solicitacao de parametros
rem
accept p_owner   prompt "Owner........... ? [%] "
accept p_termout prompt "Termout (on/off) ? [ ] "

rem
rem	Inicio do relatorio
rem
clear screen
prompt Aguarde...

rem
rem	Configurar SQL*PLUS
rem
set pages &&p_linhas. 
set lines &&p_tam_linha.
set verify off
set feedback off
set termout &&p_termout
set trimspool on
spool &&p_spool.

rem
rem	SQL
rem
column linha newline
--
select 'prompt Compilando : &&p_owner..'||object_name||'...' linha
      ,'alter '||decode(object_type,'PACKAGE BODY','PACKAGE'
                                   ,OBJECT_TYPE)||' &&p_owner..'||OBJECT_NAME||' COMPILE '||
       decode(object_type,'PACKAGE BODY','BODY','')|| ' ;' linha
  from dba_objects
 where owner like upper(decode('&&p_owner','','%','&&p_owner'))
   and status = 'INVALID'
/

rem
rem	Fim do relatorio
rem
spool off
clear break
clear columns
clear compute
ttitle off
set termout on
set verify on
set feedback on
set trimspool off

rem *** fim ***

rem
rem  Compilar
rem
prompt
prompt Executando &&p_spool
@&&p_spool
