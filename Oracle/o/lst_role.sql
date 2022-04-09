rem 
rem  nome        : lst_role.sql
rem  objetivo    : Roles (Objeto e Sistema)
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem 

rem
rem     Configurar Relatorio
rem
--
col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint
--
define p_sql       = lst_role
define p_titulo    = 'Roles (Objeto e Sistema)'
define p_tam_linha = 80
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
--
set termout off
--
select '&&p_dir_spool.&&p_sql.'||'.'||lower(name) p_temp4
      ,lower(name)                                p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')              p_temp1
      ,rpad('*', 80,'*')                          p_temp2
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
accept p_role    prompt "Role............ ? [%] "
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
break on grantee skip 1

rem
rem	Definicao de colunas - Query 1
rem
col grantee			heading "Role"
col password_required	heading "Senha"
col tipo			heading "Tipo"

rem
rem	Query 1
rem
select distinct grantee
      ,b.password_required
      ,'System' tipo
  from dba_sys_privs a
      ,dba_roles b
 where a.grantee = b.role
   and a.grantee like upper(decode('&&p_role','','%','&&p_role'))
 union
select distinct grantee
      ,b.password_required
      ,'Object' tipo
  from dba_tab_privs a
      ,dba_roles b
 where a.grantee = b.role
   and a.grantee like upper(decode('&&p_role','','%','&&p_role'))
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
