rem 
rem  nome        : lst_free.sql
rem  objetivo    : Espaco livre, utilizado e total por tablespace 
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem                Criar visao do monitor : catsvrmg.sql
rem 
rem  para definir as variaveis p_fmt_data e p_dir_spool use:
rem
rem  var p_fmt_data  varchar2(2)
rem  var p_dir_spool varchar2(50)
rem  execute :p_fmt_data := 'yyyy-mm-dd'   
rem  execute :p_dir_spool:= 'c:\db\'
rem 
--
col p_temp1 new_value                   p_data       noprint
col p_temp2 new_value                   p_traco      noprint
col p_temp3 new_value                   p_database   noprint
col p_temp4 new_value                   p_spool      noprint
--
define p_sql        = lst_free
define p_titulo     = 'Espaco livre, utilizado e total por tablespace'
define p_tam_linha  = 80
define p_fmt_data   = '&&p_fmt_data'
define p_dir_spool  = &&p_dir_spool
--
set termout off
--
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
accept p_ok prompt "Pressione enter para continuar..."

rem
rem	Inicio do relatorio
rem
clear screen
prompt Aguarde...

rem
rem	Configurar SQL*PLUS
rem
set pages 60
set lines &&p_tam_linha.
set verify off
set feedback off
set termout on
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
rem	Quebra de pagina - Query 1
rem
break on report

rem
rem     Compute - Query 1
rem
compute sum of a b c on report

rem
rem	Definicao de colunas - Query 1
rem
col a format 9,999.99 heading "Tam|Mbytes" 
col b format 9,999.99 heading "Utilizado|Mbytes" 
col c format 9,999.99 heading "Livre|Mbytes" 
col d format 9,999.99 heading "%|Livre"

rem
rem	Query 1
rem
select a.tablespace_name,
       (a.bytes/1024/1024) a, 
       (b.bytes/1024/1024) b,
       (c.bytes/1024/1024) c,
       abs(1-(c.bytes/a.bytes)*100) d
  from sys.sm$ts_avail a
      ,sys.sm$ts_used b
      ,sys.sm$ts_free c
 where a.tablespace_name = b.tablespace_name(+)
   and a.tablespace_name = c.tablespace_name(+)
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
