
SPOOL Q:\Banco_de_Dados\Oracle\NEWTST_COPIA_PROD_20110927\REPLICACAO\REATIVA\99_undo_RECRIAR_LIBERAR_ESPACO_VMPPORTAL.SQL.LOG

--reduce the retnetention to 5 minutes 
ALTER SYSTEM SET UNDO_RETENTION = 5; 

--create a new ts for a temp undo 
CREATE UNDO TABLESPACE undotbs_02 
DATAFILE '/dados/oracle/PPORTAL/oradata/undo0201.dbf' SIZE 101M; 

--set the undo ts to new ts 
ALTER SYSTEM SET UNDO_TABLESPACE = undotbs_02; 

--wait for original undo ts to be freed up (no online segments). 
select segment_name,status,tablespace_name from dba_rollback_segs 
where status='ONLINE' and tablespace_name='UNDOTBS1'; 


--offline old ts 
alter tablespace UNDOTBS1 offline; 

-- drop old ts 
drop tablespace UNDOTBS1 including contents and datafiles; 

--recreate new default ts 
create undo tablespace UNDOTBS1 
datafile '/dados/oracle/PPORTAL/oradata/undotbs01.dbf' size 501m; 

--repoint undo to default again 
ALTER SYSTEM SET UNDO_TABLESPACE = UNDOTBS1; 

--wait for temp undo ts to be freed up (no online segments). 
select segment_name,status,tablespace_name from dba_rollback_segs 
where status='ONLINE' and tablespace_name='UNDOTBS_02'; 

--offline tep undo 
alter tablespace undotbs_02 offline; 

--drop temp undo 
drop tablespace undotbs_02 including contents and datafiles; 

--reset retnetion to normal default (whatever you use in init.ora) 
ALTER SYSTEM SET UNDO_RETENTION = 10800; 


ALTER DATABASE DATAFILE '/dados/oracle/PPORTAL/oradata/undotbs01.dbf' RESIZE 5001M;

 
