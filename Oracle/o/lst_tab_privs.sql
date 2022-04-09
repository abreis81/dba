set pages 0
--
break on owner on table_name skip 1 on grantee
--
column owner      format a10
column table_name format a30
column grantee    format a20
column privilege  format a10
--
  select t.owner
        ,t.table_name
        ,p.grantee
        ,p.privilege
        ,p.grantable
    from sys.dba_tables t
        ,sys.dba_tab_privs p
   where t.owner       like upper('&own')
     and t.table_name  like upper('&tab')
     and p.grantee     like upper('&gra')
     and p.owner      (+) = t.owner
     and p.table_name (+) = t.table_name
order by t.table_name
        ,p.grantee
        ,p.privilege
/
