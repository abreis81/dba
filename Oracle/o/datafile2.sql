ACCEPT tablespace

select 'ALTER DATABASE DATAFILE '||''''||file_name||''''||' autoextend off;'
from dba_data_files where tablespace_name=UPPER('&tablespace');