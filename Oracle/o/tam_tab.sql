column owner 		format a10 heading "Owner"
column table_name       format a30      heading "Table"
column num_rows         format 99,999,999  HEADING "Rows"
column blocos_kb           format 999,999,999  heading "Blocks(Kb)" 
spool c:\levantamento\tabelas.txt
--
  select owner 
	,table_name
        ,num_rows 
        ,(blocks*8192)/1024 blocos_kb
    from dba_tables    
    where tablespace_name like('TBS%')
order by owner,table_name
/
spool off;