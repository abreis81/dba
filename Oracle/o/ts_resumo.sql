/*
  SCRIPT:   TS_RESUMO.SQL
  OBJETIVO: LISTA OS TABLESPACE E O ESPACO DISPONIVEL
  AUTOR:    JOSIVAN
  DATA:     
*/

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
define p_sql       = ts_resumo
define p_titulo    = 'Resumo dos Objetos'
define p_tam_linha = 96
define p_fmt_data  = 'YYYY-MM-DD'
--
set termout off
--
select lower(name)                     p_temp4
      ,lower(name)                     p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')   p_temp1
      ,rpad('*', &&p_tam_linha,'*')    p_temp2	
  from v$database
/
set termout on
--
set pagesize 100
set linesize &p_tam_linha
--
col tablespace_name format a25
col files           format 999
col total           format 99999999
col free            format 99999999
col max_free        format 999999
col max_next        format 999999
col sum_next        format 999999
col extent          format 999999
col n_ind           format 9999
col n_tab           format 9999
--
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
--
  select tablespace_name
        ,count(file_name)            files
        ,SUM(BYTES/1024)             total
        ,FREE
        ,max_free
        ,max_next
        ,sum_next
        ,n_ind
        ,n_tab
        ,extent
    from dba_data_files
        ,(select tablespace_name       ntbs
                ,sum(bytes/1024)       free
                ,max(bytes/1024)       max_free
            from dba_free_space 
        group by tablespace_name)
        ,(select tablespace_name       ftbs
                ,max(next_extent/1024) max_next
                ,sum(extents)          extent
                ,sum(next_extent/1024) sum_next
                ,count(decode(segment_type,'INDEX','*',null)) n_ind
                ,count(decode(segment_type,'TABLE','*',null)) n_tab
            from dba_segments
        group by tablespace_name)
   where tablespace_name  = ntbs (+)
     and tablespace_name  = ftbs (+) 
group by tablespace_name
        ,free
        ,max_free
        ,max_next
        ,sum_next
        ,n_ind
        ,n_tab
        ,extent
/

clear break
clear columns
clear compute
ttitle off
set termout on
set verify on
set feedback on
