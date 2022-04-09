set long 500000
set pages 10000

select  sql_fulltext from v$sqlarea t, (select distinct hash_value from v$sql_plan p
  where p.operation='TABLE ACCESS'
  and p.options='FULL') a
 where t.hash_value=a.hash_value
  and sql_fulltext like '%SEU%'
/