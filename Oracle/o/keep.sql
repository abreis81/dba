column STORED_OBJECT format a30 

select /*+ ordered use_hash(d) use_hash(c) */ 
o.kglnaown||'.'||o.kglnaobj stored_object, 
sum(c.kglhdexc) sql_executions 
from 
sys.x$kglob o, 
sys.x$kglrd d, 
sys.x$kglcursor c 
where 
o.inst_id = userenv('Instance') and 
d.inst_id = userenv('Instance') and 
c.inst_id = userenv('Instance') and 
o.kglobtyp in (7, 8, 9, 11, 12) and 
d.kglhdcdr = o.kglhdadr and 
c.kglhdpar = d.kglrdhdl 
group by 
o.kglnaown, 
o.kglnaobj 
/ 
