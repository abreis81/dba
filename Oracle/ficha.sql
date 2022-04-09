select a.table_name, a.last_analyzed, a.num_rows
from dba_tables a
where a.table_name in 
('TB_RECEB_PARTICIP',
'TB_COMP_RECEB_PARTICIP',
'TB_PARCELA',
'TB_TIP_EVENTO',
'VERBA',
'TB_PENDENCIA');



--drop index ATT.ID_PARCELA_011
/*
CREATE INDEX "ATT"."ID_PARCELA_011" ON "ATT"."TB_PARCELA" ("DAT_PAGTO")
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
STORAGE(INITIAL 104857600 NEXT 104857600 MINEXTENTS 1 MAXEXTENTS 2147483645
PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "TS_ATT_IX_03" ;
*/


select * 
from dba_tables 
wherE table_name='DAM00';

TELEMAT.DAM00

select a.last_analyzed ,a.* 
from dba_tables a
wherE a.table_name='TB_PARCELA';

select b.last_analyzed ,b.*
from dba_indexes b
where b.table_name='TB_PARCELA';


select * from
dba_objects 
where object_name like '%PARCELA%'
and owner='ATT'
AND OBJECT_TYPE='INDEX'
order by last_ddl_time

drop index att.ID_PARCELA_PROVISORIO;
drop index att.ID_PARCELA_008;
drop index att.ID_PARCELA_006;

select a.* 
from dba_constraints a where a.table_name='TB_PARCELA'


analyze table att.TB_PENDENCIA compute STATISTICS;

analyze table att.TB_PARCELA delete STATISTICS;

analyze index att.ID_PARCELA_PROVISORIO compute STATISTICS;

analyze index att.ID_PARCELA_PROVISORIO delete STATISTICS;



begin
DBMS_STATS.gather_table_stats('ATT', 'TB_PARCELA', estimate_percent => 100);
end;
/

begin
DBMS_STATS.delete_table_stats('aTT', 'TB_PARCELA');
end;
/

BEGIN
 dbms_stats.unlock_table_stats('ATT', 'TB_PARCELA');
END;
/


select *
from dba_objects
where object_name='FCESP_TB_PARCELA_PAGTO'


select count(*) from tb_pendencia;


select last_analyzed 
from dba_tables
order by 1
