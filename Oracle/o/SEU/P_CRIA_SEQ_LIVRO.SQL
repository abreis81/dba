CREATE OR REPLACE PROCEDURE SEU.P_CRIA_SEQ_LIVRO(IDEMPRESA IN NUMBER)
IS
	str varchar2(4000);
begin
	begin
		str :='CREATE SEQUENCE SEQ_SEUADL_IDLOTELIVRO_'||IDEMPRESA||' minvalue 0 start with 1 increment by 1 nocache maxvalue 999999999';
		execute immediate str;
		execute immediate 'grant select on SEQ_SEUADL_IDLOTELIVRO_'||IDEMPRESA||' to r_seu_all';
	exception when others then
	raise_application_error(-20999,'Erro ao criar a sequences SEQ_SEUADL_IDLOTELIVRO_'||IDEMPRESA||' '||sqlerrm);
	end;
	begin
		str :='CREATE SEQUENCE SEQ_SEUADL_PAGINA_'||IDEMPRESA||' minvalue 0 start with 1 increment by 1 nocache maxvalue 500 cycle';
		execute immediate str;
		execute immediate 'grant select on SEQ_SEUADL_PAGINA_'||IDEMPRESA||' to r_seu_all';
	exception when others then
	raise_application_error(-20999,'Erro ao criar a sequences SEQ_SEUADL_PAGINA_'||IDEMPRESA||' '||sqlerrm);
	end;
	begin
		str :='CREATE SEQUENCE SEQ_SEUADL_REGISTRO_'||IDEMPRESA||' minvalue 0 start with 1 increment by 1 nocache maxvalue 999999999';
		execute immediate str;
		execute immediate 'grant select on SEQ_SEUADL_REGISTRO_'||IDEMPRESA||' to r_seu_all';
	exception when others then
	raise_application_error(-20999,'Erro ao criar a sequences SEQ_SEUADL_REGISTRO_'||IDEMPRESA||' '||sqlerrm);
	end;
end;
/
