CREATE OR REPLACE PROCEDURE SEU.P_CRIA_SEQ_PROCESSO(CODUND IN VARCHAR2)
IS
	str varchar2(4000);
begin
	str :='CREATE SEQUENCE SEQ_SEUADL_PROCESSO_'||CODUND||' minvalue 0 start with 1 increment by 1 nocache';
	execute immediate str;
exception when others then
	raise_application_error(-20999,'Erro ao criar a sequence SEQ_SEUADL_PROCESSO_'||CODUND||' '||sqlerrm);
end;
/
