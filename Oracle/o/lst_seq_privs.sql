set pages 0
--
break on sequence_name skip 1 on grantee
--
column grantee   format a25
column privilege format a15
--
  select s.sequence_name
        ,p.grantee
        ,p.privilege
        ,p.grantable
    from sys.dba_sequences s
        ,sys.dba_tab_privs p
   where s.sequence_owner like upper ('&own')
     and p.table_name    (+) = s.sequence_name
order by s.sequence_name
        ,p.grantee
        ,p.privilege
/

