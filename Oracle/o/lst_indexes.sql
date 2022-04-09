rem 
rem  nome        : lst_indexes.sql
rem  objetivo    : tabela x indices
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
define p_sql       = lst_indexes
define p_titulo    = 'Tabela x Indexes'
define p_tam_linha = 95
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
--
set termout off
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
accept p_owner   prompt "Owner........... ? [%] "
accept p_tabela  prompt "Tabela.......... ? [%] "
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
break on table_owner on table_name on index_name

rem
rem	Definicao de colunas - Query 1
rem
column table_owner     format A10       
column table_name      format A27
column index_name      format A27
column column_name     format A21
column column_position format 99 heading 'Pos'
column uniq            format a1  heading 'U'

rem
rem	Query 1
rem
  select c.table_owner
        ,c.table_name
        ,C.index_name
        ,substr(I.uniqueness,1,1) uniq
        ,C.column_name
        ,C.column_position
    from dba_ind_columns C
        ,dba_indexes     I
   where C.table_owner like upper(decode('&&p_Owner','','%','&&p_Owner'))
     and C.table_name  like upper(decode('&&p_Tabela','','%','&&p_Tabela'))
     and C.index_owner = I.owner
     and C.index_name  = I.index_name
order by 1,2,3,6
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
