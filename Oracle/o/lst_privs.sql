set pages 0
--
break on owner on table_name skip 1 on grantee
--
column owner      format a10
column table_name format a30
column grantee    format a20
column privilege  format a10
--
spool seprivs
--
  select p.owner
        ,p.table_name
        ,p.grantee
        ,p.privilege
        ,p.grantable
    from sys.dba_tab_privs p
   where p.owner       like upper('&own')
     and p.table_name  like upper('&tab')
     and p.grantee     like upper('&gra')
order by p.table_name
        ,p.grantee
        ,p.privilege
/
spool off
