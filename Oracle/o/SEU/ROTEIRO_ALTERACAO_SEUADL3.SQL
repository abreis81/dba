select 'create sequence seu.'||sequence_name||'_1 start with '||last_number||' increment by 1 minvalue 0 maxvalue 999999999 nocache nocycle;'
from dba_sequences where SEQUENCE_owner='SEU' 
AND SEQUENCE_NAME in ('SEQ_SEUADL_REGISTRO','SEQ_SEUADL_PAGINA','SEQ_SEUADL_IDLOTELIVRO');

select 'grant select on seu.'||sequence_name||'_1 to r_seu_all;'
from dba_sequences where SEQUENCE_owner='SEU' 
AND SEQUENCE_NAME in ('SEQ_SEUADL_REGISTRO','SEQ_SEUADL_PAGINA','SEQ_SEUADL_IDLOTELIVRO');

declare
	cursor c1 is select distinct saam_idempresa from seu.seuaam where saam_idempresa<>1;
	str varchar2(1000);
begin
	for rc1 in c1 loop
		execute immediate 'create sequence seu.SEQ_SEUADL_REGISTRO_'||rc1.saam_idempresa||' start with 1 increment by 1 minvalue 0 maxvalue 999999999 nocache nocycle';
		execute immediate 'grant select on seu.SEQ_SEUADL_REGISTRO_'||rc1.saam_idempresa||' to r_seu_all';
		execute immediate 'create sequence seu.SEQ_SEUADL_PAGINA_'||rc1.saam_idempresa||' start with 1 increment by 1 minvalue 0 maxvalue 500 nocache cycle';
		execute immediate 'grant select on seu.SEQ_SEUADL_PAGINA_'||rc1.saam_idempresa||' to r_seu_all';
		execute immediate 'create sequence seu.SEQ_SEUADL_IDLOTELIVRO_'||rc1.saam_idempresa||' start with 1 increment by 1 minvalue 0 maxvalue 999999999 nocache nocycle';
		execute immediate 'grant select on seu.SEQ_SEUADL_IDLOTELIVRO_'||rc1.saam_idempresa||' to r_seu_all';
	end loop;
end;
/
		






