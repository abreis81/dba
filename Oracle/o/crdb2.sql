create tablespace dat_prod
datafile '/ora07/app/oracle/oradata/sta03p/dat/dat_prod_01.dbf' size 2000M;

create tablespace ix_prod 
datafile '/ora07/app/oracle/oradata/sta03p/idx/ix_prod_01.dbf' size 1000M;

create tablespace rbs
datafile '/ora07/app/oracle/oradata/sta03p/dat/rbs_01.dbf' size 150M;

create tablespace temp
datafile '/ora07/app/oracle/oradata/sta03p/dat/temp_01.dbf' size 150M;

create tablespace users
datafile '/ora07/app/oracle/oradata/sta03p/dat/users_01.dbf' size 1M;

create public rollback segment rb1 tablespace rbs;
create public rollback segment rb2 tablespace rbs;
create public rollback segment rb3 tablespace rbs;
create public rollback segment rb4 tablespace rbs;
create public rollback segment rb5 tablespace rbs;

alter rollback segment rb1 online;
alter rollback segment rb2 online;
alter rollback segment rb3 online;
alter rollback segment rb4 online;
alter rollback segment rb5 online;
