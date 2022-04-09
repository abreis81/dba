rem 
rem  nome        : lst_df.sql
rem  objetivo    : Filesystem x datafiles 
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem                * Atencao : sys.filext$ (AUTOEXTEND)
rem 

rem
rem     Configurar Relatorio
rem
col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint
col p_temp5 new_value                   p_block     noprint
--
define p_sql       = lst_df
define p_titulo    = 'Filesystem x Datafiles'
define p_tam_linha = 80
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
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
accept p_linhas  prompt "Nr. de linhas..  ? [0] "
accept p_so      prompt "Unix...........  ? [S] "
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
--set termout &&p_termout.
spool &&p_spool.

rem
rem	Query 1
rem
select value p_temp5
  from v$parameter
 where name = 'db_block_size'
/

rem
rem	Header e Footer - Query 2
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
rem     Quebra de pagina - Query 2
rem
break on filesystem skip 2 on report

rem
rem     Compute - Query 2
rem
compute sum of mb colmax colinc on filesystem report 

rem
rem	Definicao de colunas - Query 2
rem
col filesystem  format a30
col file_name   format a20  heading "Arquivo"
col mb          format 9,999 heading "Total|Mbytes"
col colmax      format 9,999 heading "MaxSize|Mbytes"
col colinc      format 9,999 heading "Next|Mbytes"

rem
rem	Query 2
rem
select substr(file_name,1,instr(file_name,decode('&p_so','N','\','n','\','/'),-1)) filesystem
      ,substr(file_name,instr(file_name,decode('&p_so','N','\','n','\','/'),-1)+1) file_name
      ,bytes/1024/1024                  mb
      ,(maxextend*&&p_block)/1024/1024  colmax
      ,(inc*&&p_block)/1024/1024        colinc
  from dba_data_files a
      ,sys.filext$ b
 where a.file_id = file# (+)
 union
  select substr(member,1,instr(member,decode('&p_so','N','\','n','\','/'),-1)) filesystem
        ,substr(member,instr(member,decode('&p_so','N','\','n','\','/'),-1)+1) file_name
        ,b.bytes/1024/1024 mb
        ,0 colmax
        ,0 colinc
    from v$logfile a
        ,v$log b
   where a.group# = b.group#
order by filesystem
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

