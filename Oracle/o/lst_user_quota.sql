/*
  script:   lst_user.sql
  objetivo: listar o espaco disponivel por usuario
  autor:    Josivan
  data:     
*/

clear screen
--
set line 80
set echo off
set feedback off
--
column tablespace_name format a15
column bytes           format 999,999,999,999
--
break on username on tablespace_name on bytes 
break on report
--
compute sum of bytes on report
--
ttitle center "Relatorio User x Space" skip 2
--
  select username
        ,tablespace_name
        ,bytes
    from dba_ts_quotas
   where bytes<>0
order by username
        ,tablespace_name
        ,bytes
/
set feedback on
set echo on
ttitle off


