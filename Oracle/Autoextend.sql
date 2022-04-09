set lines 2000
set pages 200
col file_name format a60

select file_name, autoextensible from dba_data_files;

select 'alter database datafile '''|| file_name || ''' autoextend off;'
from dba_data_files where autoextensible='YES';



select file_name, autoextensible from dba_temp_files;

select 'alter database tempfile '''|| file_name || ''' autoextend off;'
from dba_temp_files where autoextensible='YES';
