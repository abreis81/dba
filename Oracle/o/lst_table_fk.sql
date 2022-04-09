set pages 66
--
set linesize 80
--
column r_owner format a11
column r_table_name format a27
--
  select c.owner           r_owner 
        ,c.table_name      r_table_name 
        ,c.constraint_name r_constraint_name
        ,c.status          r_status
    from sys.dba_tables a
        ,sys.dba_constraints b
        ,sys.dba_constraints c
   where a.owner              like upper ('&own')
     and a.table_name         like upper ('&tab')
     and b.owner                 = a.owner
     and b.table_name            = a.table_name
     and b.constraint_type       = 'P'
     and c.r_constraint_name (+) = b.constraint_name
     and c.constraint_type   (+) = 'R'
order by c.owner
        ,c.table_name
        ,c.constraint_name
/
