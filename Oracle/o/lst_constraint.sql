/*
  script:   lst_constraint.sql
  objetivo: contar as constraints
  autor:    Josivan
  data:     
*/

set echo off feed off
col owner format a15
col object_name format a30

  select owner
        ,constraint_type
        ,count(*)         total_const
    from dba_constraints 
   where owner <> 'SYS'
     and owner <> 'SYSTEM' 
group by owner
        ,constraint_type;

  select schema_user
        ,count(*) total_jobs 
    from dba_jobs
group by schema_user;


 select owner
       ,object_type
       ,count(*) tot_obj
   from dba_objects
   where owner <> 'SYS' and owner <> 'SYSTEM'
group by owner, object_type;

  select owner
        ,count(*) tot_snap
    from dba_snapshots
   where owner <> 'SYS' and owner <> 'SYSTEM' 
group by owner;


  select log_owner
        ,count(*) tot_snap_log
    from dba_snapshot_logs
group by log_owner;


select count(*) tot_users 
  from dba_users;


  select owner
        ,object_type
        ,object_name
        ,status
    from dba_objects
   where status = 'INVALID' 
order by 1,2,3;

