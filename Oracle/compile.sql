select owner, object_type, count(*) num_obj_inv from dba_objects where status='INVALID' 
/* and owner not in ('OLAPSYS','SYS','SYSTEM','SYSMAN') */
group by rollup(owner, object_type) order by owner, object_type;

begin
 sys.utl_recomp.recomp_serial();
end;
/

select owner, object_type, count(*) num_obj_inv from dba_objects where status='INVALID' 
/* and owner not in ('OLAPSYS','SYS','SYSTEM','SYSMAN') */
group by rollup(owner, object_type) order by owner, object_type;


