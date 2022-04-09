set pages 1000
set lines 150
col datafile format a60
ACCEPT tablespace prompt "Tablespace: "

select 	file_id,
        file_name datafile, 
	bytes/1024 kbytes, 
	autoextensible auto
from dba_data_files 
	where 
	tablespace_name=UPPER('&tablespace');