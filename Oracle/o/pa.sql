rem -----------------------------------------------------------------------
rem Script : processos_ativos.sql
rem          Mostra processos ativos no banco de dados 
rem -----------------------------------------------------------------------
--
col name       format a6
col username   format a10
col osuser     format a13
col start_time format a17
col status     format a6
--
set pages 40
--
tti 'Processos Ativos'
--
col name format a6
--
  select username
        ,terminal
        ,osuser
        ,t.start_time
        ,r.name
        ,t.used_ublk "ROLLB BLKS"
        ,decode(t.space, 'YES', 'SPACE TX',decode(t.recursive, 'YES', 'RECURSIVE TX',decode(t.noundo, 'YES', 'NO UNDO TX', t.status)       )) status
    from sys.v_$transaction t
        ,sys.v_$rollname r
        ,sys.v_$session s
   where t.xidusn = r.usn
     and t.ses_addr = s.saddr
order by 3
/
tti off
set pages 24
