select a.tablespace_name tablespace, total, livre
,case when ((15*total)/100) > 250 then round(24900/a.total,2)
  else 15
  end as "CRITICO - 15%"
,case when ((30*total)/100) > 500 then round(49900/a.total,2)
  else 30
end as "WARNING - 30%"
from (select tablespace_name, trunc(sum(bytes/1024/1024)) total from dba_data_files group by tablespace_name) a
,(select tablespace_name, trunc(sum(bytes/1024/1024)) livre from dba_free_space group by tablespace_name) b
where a.tablespace_name=b.tablespace_name
/
			