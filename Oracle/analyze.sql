
select * from dba_objects where object_name=upper('recviwdaddecanualdeb')



select * from att.recviwdaddecanualdeb

begin
DBMS_STATS.gather_INDEX_stats('OWN_POLI', 'CT_CCUSTO_PK', estimate_percent => 100);
end;
/

begin
DBMS_STATS.delete_table_stats('ATT', 'TB_HIST_PARTIC_PLANO');
end;
/

BEGIN
 dbms_stats.unlock_table_stats('OWN_POLI', 'CT_CONTA_AUXILIAR');
END;
/

SELECT INDEX_NAME, LAST_ANALYZED
FROM DBA_INDEXES
WHERE TABLE_NAME in ('EMPREGADO',
       'PARTICIPANTE_FSS',
       'FCH_FINAN_CONTABIL_FSS',
       'BENEFICIO_PARTIC_FSS',
       'VERBA_FSS');


'CT_RAZAO','CT_PLANO_CONTAS','CT_CCUSTO','CT_CONTA_AUXILIAR'

SELECT OWNER, table_name, stattype_locked 
FROM dba_tab_statistics 
WHERE owner='ATT'
and 
table_name in ('EMPREGADO',
       'PARTICIPANTE_FSS',
       'FCH_FINAN_CONTABIL_FSS',
       'BENEFICIO_PARTIC_FSS',
       'VERBA_FSS');
--('TB_RECEB_PARTICIP','EMPREGADO','REPRES_UNIAO_FSS','TB_PARCELA','TB_PENDENCIA')

tb_receb_particip
empregado
repres_uniao_fss
tb_parcela
tb_pendencia

select * from dba_objects where object_name=
upper('tb_hist_partic_plano')

SELECT owner, object_name, object_type
FROM DBA_OBJECTS
where object_name in ('TB_RECEB_PARTICIP','EMPREGADO','REPRES_UNIAO_FSS','TB_PARCELA','TB_PENDENCIA')
order by object_name

select a.owner, a.table_name, a.last_analyzed, a.num_rows
from dba_tables a
where a.table_name in ('EMPREGADO',
       'PARTICIPANTE_FSS',
       'FCH_FINAN_CONTABIL_FSS',
       'BENEFICIO_PARTIC_FSS',
       'VERBA_FSS');
--('TB_RECEB_PARTICIP','EMPREGADO','REPRES_UNIAO_FSS','TB_PARCELA','TB_PENDENCIA')

select *
from dba_objects where object_name like '%EMPREGADO%'


SELECT sid, serial#,username,           client_identifier, service_name, action, module
       FROM V$SESSION
       
-- olhar traces habilitados       
select * from DBA_ENABLED_TRACES ;


v$session

EXEC DBMS_MONITOR.serv_mod_act_trace_enable(service_name=>'SYS$USERS', module_name=>'dllhost.exe');
EXEC DBMS_MONITOR.serv_mod_act_trace_DISABLE(service_name=>'SYS$USERS', module_name=>'dllhost.exe');
---
EXEC DBMS_MONITOR.serv_mod_act_trace_enable(service_name=>'SYS$USERS', module_name=>'dllhost.exe', action_name=>'running');

EXEC DBMS_MONITOR.serv_mod_act_trace_disable(service_name=>'SYS$USERS', module_name=>'dllhost.exe', action_name=>'running');


--------------------

select *
from CRM.CS_CDTB_LOGBOLETOBANCARIO_LOBO
where lobo_dh_emissao > '02-may-2010'

select * from dba_tables where table_name ='CS_CDTB_LOGBOLETOBANCARIO_LOBO'



-------------------------------- owner com histograma


begin

dbms_stats.gather_schema_stats( 
ownname=> '"OWN_YMF"' , 
cascade=> DBMS_STATS.AUTO_CASCADE, 
estimate_percent=> null, 
degree=> DBMS_STATS.AUTO_DEGREE, 
no_invalidate=> DBMS_STATS.AUTO_INVALIDATE, 
granularity=> 'AUTO', 
method_opt=> 'FOR ALL COLUMNS SIZE AUTO', 
options=> 'GATHER');

end;
