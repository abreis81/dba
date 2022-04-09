create or replace trigger seu.TRG_SEUAAM_CRIASEQ_I
before insert on seu.seuaam REFERENCING OLD AS OLD NEW AS NEW
for each row
declare
	str varchar2(4000);
begin
	str :='SEQUENCE SEQ_SEUADL_PROCESSO_'||:new.SAAM_CODIGO||' minvalue 0 start with 1 increment by 1 nocache';
	execute immediate str;
exception when others then
	raise_application_error(-20999,'Erro ao criar a sequence SEQ_SEUADL_PROCESSO_'||:new.SAAM_CODIGO||' '||sqlerrm);
end;
/