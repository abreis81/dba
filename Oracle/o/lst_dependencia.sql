rem 
rem  nome        : lst_dependencia.sql
rem  objetivo    : Listar Dependencias de Objetos
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

define p_sql       = lst_dep
define p_titulo    = 'Listar Dependencias de Objetos'
define p_tam_linha = 95
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
set termout off

select '&&p_dir_spool.&&p_sql.'||'.'||lower(name)  p_temp4
      ,lower(name)                                 p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')               p_temp1
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
accept p_obj     prompt "Objeto.......... ? [%] "
accept p_linhas  prompt "Nr. de linhas... ? [0] "
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
set termout &&p_termout.
spool &&p_spool.

rem
rem	Header e Footer
rem
ttitle left p_traco skip -
       left p_data -
       right format 999 'Pag.: ' sql.pno skip 2 -
       center '&&p_titulo' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off

rem
rem	Quebra de pagina
rem
break on obj on tipo

rem
rem	Definicao de colunas - Query 1
rem
col obj	 format a41 heading "Objeto"
col tipo     format a04 heading "Tipo"
col obj_ref  format a41 heading "Dependencia"
col tipo_ref format a04 heading "Tipo" 

rem
rem	Query 1
rem
  select owner||'.'||name obj
        ,decode(type,'PACKAGE BODY','BODY',substr(type,1,4))                       tipo
        ,referenced_owner||'.'||referenced_name                                    obj_ref
        ,decode(referenced_type,'PACKAGE BODY','BODY',substr(referenced_type,1,4)) tipo_ref
    from dba_dependencies
   where name like upper(decode('&p_obj','','%','&p_obj'))
     and owner like upper(decode('&p_owner','','%','&p_owner'))
order by obj
        ,tipo_ref
        ,obj_ref
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
