/*
  script:   verrollpend.sql
  objetivo: 
  autor:    Josivan
  data:     
*/

select local_tran_id,state, advice,db_user
from dba_2pc_pending
/
select 'rollback force '||''''||local_tran_id||''''||';'
from dba_2pc_pending 
/
select local_tran_id,in_out,database,interface
from dba_2pc_neighbors
/
select 'rollback force '||''''||local_tran_id||''''||';'
from dba_2pc_neighbors
/
