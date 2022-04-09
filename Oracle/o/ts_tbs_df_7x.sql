rem 
rem  nome        : ts_tbs_df.sql
rem  objetivo    : Tablespace x Filesystem x datafiles 
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem                * Atencao : sys.filext$ (AUTOEXTEND)
rem 

rem
rem     Configurar Relatorio
rem
--
col p_temp1 new_value                 p_data      noprint
col p_temp2 new_value                 p_traco     noprint
col p_temp3 new_value                 p_database  noprint
col p_temp4 new_value                 p_spool     noprint
col p_temp5 new_value                 p_block     noprint
--
var p_fmt_data varchar2(100)
var p_dir_spool varchar2(100)
exec :p_fmt_data  := 'YYYY-MM-DD'
exec :p_dir_spool := 'd:/zrevisado'
--
define p_sql       = ts_tbs_df
define p_titulo    = 'Tablespace x Filesystem x Datafiles'
define p_tam_linha = 100
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
--
set termout off
--
select '&&p_dir_spool.&&p_sql.'||'.'||lower(name) p_temp4
      ,lower(name)                                p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')              p_temp1
      ,rpad('*', &&p_tam_linha,'*')               p_temp2	
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
prompt 

rem
rem	Solicitacao de parametros
rem
accept p_linhas  prompt "Nr. de linhas..  ? [0] "
accept p_so      prompt "Unix...........  ? [S] "
accept p_termout prompt "Termout (on/off) ? [ ] "

rem
rem	Configurar SQL*PLUS
rem
set pages &&p_linhas.
set lines &&p_tam_linha.
set verify off
set feedback off
set termout &&p_termout.

rem spool &&p_spool.

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
break on tablespace_name skip 1 on report

rem
rem     Compute - Query 2
rem
compute sum of mb mb_free colmax colinc on tablespace_name report 

rem
rem	Definicao de colunas - Query 2
rem
col tablespace_name format a10       heading "Tablespace"
col filesystem      format a30       heading "Filesystem" 
col file_name       format a15       heading "Arquivo"
col mb              format 9,999     heading "Total|Mbytes"
col mb_free         format 9,999     heading "Livre|Mbytes"
col colmax          format 9,999     heading "MaxSize|Mbytes"
col colinc          format 9,999     heading "Next|Mbytes"

rem
rem	Query 2
rem
select a.tablespace_name
      ,substr(file_name,1,instr(file_name,decode('&p_so','N','\','n','\','/'),-1)) filesystem 
      ,substr(file_name,instr(file_name,decode('&p_so','N','\','n','\','/'),-1)+1) file_name 
      ,a.bytes/1024/1024               mb
      ,c.bytes/1024/1024               mb_free
      ,(maxextend*&&p_block)/1024/1024 colmax
      ,(inc*&&p_block)/1024/1024       colinc
  from sm$ts_avail a
      ,sys.filext$ b
      ,sys.sm$ts_free c
 where a.file_id = file# (+)
   and a.tablespace_name = c.tablespace_name (+)
 union
 select 'REDO LOG' tablespace_name
        ,substr(member,1,instr(member,decode('&p_so','N','\','n','\','/'),-1)) filesystem
        ,substr(member,instr(member,decode('&p_so','N','\','n','\','/'),-1)+1) file_name
        ,b.bytes/1024/1024 mb
        ,0 mb_free
        ,0 colmax
        ,0 colinc
    from v$logfile a
        ,v$log b
   where a.group# = b.group#
order by tablespace_name
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
