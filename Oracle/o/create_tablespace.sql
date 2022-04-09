/*
  script:   create_tablespace.sql
  objetivo: criar tablespaces
  autor:    Rogerio
  data:     12/06/2001
*/



create tablespace ts_guide
   datafile '/appsdes/oracle/oradata/orarep/ts_guide_dt_01.dbf' size 100m
   autoextend on 
default storage (initial 500k
                 minextents 20
                 next 500k
                 pctincrease 1 )
/

