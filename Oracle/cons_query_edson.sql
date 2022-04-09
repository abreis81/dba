
select address, S.SQL_ID, piece, sql_text
from v$sqltext s , v$session a
where a.sql_address = s.address
  and a.sql_hash_value = s.hash_value
  and a.sid IN ('115') -- = '132' -- '917' 
order by 1,2, 3
/


------------------------

select *
from v$access
where object='SCTSTPCRIARAUTSCAM'

