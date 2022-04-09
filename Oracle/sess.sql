--alter system kill session '779,53748' immediate;

/*
Clear Columns Computes Breaks
set lines 150 pages 30 arrays 30
col log_time    format a19
col sid         format 9999
col username    format a16
col osuser      format a20
col serial#     format 99999
col spid        format a8
col lockwait    format 9999999
col St          format a2
col CX          format a2
col machine     format a28
define var1=1
define var2=1
*/

--select 'alter system disconnect session '''||a.sid||','||a.serial#||''' immediate;'
--/*
select * from (Select a.INST_ID,  
              a.LAST_CALL_ET last,
              a.sid, a.serial#,
               substr(to_char(a.logon_time,' dd-mm-yy hh24:mi:ss'),1,20) log_time,
               a.process, a.osuser, a.username, b.spid,
               substr(a.status,1,1) St, a.lockwait lkw,
                           decode(a.server,'NONE','',substr(a.server,1,2)) CX, a.machine
                           , a.program
  --         */           
from    gv$session a, gv$process b
where   a.paddr = b.addr 
        and a.INST_ID = b.INST_ID
        and a.username is not null
--        and a.username like '%CRM%'
--      and osuser like '%02190%'
--       and sid=1935
--        and UPPER(a.machine) like '%048%'
--          and upper(a.program) like '%WORK%'
    --      and a.last_call_et > 500
          
)
--where &&var1 like &&var2
order by 10,11
/

--alter system disconnect session '1397,11141' immediate;
