set pagesize 40000
set linesize 120
--
column OS_USERNAME         format a8
column USERNAME            format a10
column TERMINAL            format a10
column LOGON_TIME          format a17
column LOGOFF_TIME         format a8
column "DIFER(Min)"        format 9999.9999
column ACTION_NAME         format a17
--
  select OS_USERNAME
        ,USERNAME
        ,TERMINAL
        ,to_char(TIMESTAMP,'dd/mm/yy hh24:mi:ss') LOGON_TIME
        ,to_char(LOGOFF_TIME,'hh24:mi:ss')        LOGOFF_TIME
        ,(LOGOFF_TIME - TIMESTAMP)*24*60          "DIFER(Min)"
        ,ACTION_NAME
    from sys.dba_audit_session
order by TIMESTAMP
/
