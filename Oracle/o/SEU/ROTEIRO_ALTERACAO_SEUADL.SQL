drop table seu.SEUADL_old;
create table seu.seuadl_old as select sadl_nreg,SADL_CODUND, SADL_UNIDEST,SADL_CODPEDIDO from seu.seuadl;

alter trigger seu.trg_seuadl_audit_t disable;
alter trigger seu.TRG_SEUADL_INCR_I disable;
alter table seu.seuadl drop constraint pk_seuadl;
drop index seu.pk_seuadl;

update seu.seuadl set SADL_CODUND=null, SADL_UNIDEST=null,SADL_CODPEDIDO=null ;
alter table seu.seuadl modify (SADL_CODUND varchar2(6), SADL_UNIDEST varchar2(6),SADL_CODPEDIDO varchar(16));

update seu.seuadl a set (SADL_CODUND, SADL_UNIDEST, SADL_CODPEDIDO) = (select decode(SADL_CODUND,11,'000133',4,'000131', 9,'000132',lpad(SADL_CODUND,6,'0'))
,decode(trunc(SADL_UNIDEST),'11','000133','4','000131','9','000132',SADL_UNIDEST), SADL_CODPEDIDO from seu.seuadl_old
where sadl_nreg=a.sadl_nreg);


UPDATE seu.SEUADL SET SADL_CODPEDIDO = 'P'||lpad(SADL_CODPEDIDO,15,'0') 
WHERE LENGTH(SADL_CODPEDIDO)<16;

alter table seu.seuadl add constraint pk_seuadl primary key (SADL_CODPEDIDO)
using index tablespace seux;

drop table seu.seuadl_log2;
create table seu.seuadl_log2 as SELECT ROWID RID
, SADL_CODUND_ANTES, SADL_CODUND_DEPOIS 
, SADL_UNIDEST_ANTES, SADL_UNIDEST_DEPOIS
, SADL_CODPEDIDO_ANTES, SADL_CODPEDIDO_DEPOIS
FROM SEU.SEUADL_LOG;

create index seu.ix_seuadl_log2 on seu.seuadl_log2(rid);

update seu.seuadl_log set 
SADL_CODUND_ANTES=null, SADL_CODUND_DEPOIS=null
,SADL_UNIDEST_ANTES=null, SADL_UNIDEST_DEPOIS=null
,SADL_CODPEDIDO_ANTES=null, SADL_CODPEDIDO_DEPOIS=null;

commit;

exec seu.p_altera_log('SEUADL');

update seu.seuadl_log a set (SADL_CODUND_ANTES, SADL_CODUND_DEPOIS 
, SADL_UNIDEST_ANTES, SADL_UNIDEST_DEPOIS
, SADL_CODPEDIDO_ANTES, SADL_CODPEDIDO_DEPOIS) = (select SADL_CODUND_ANTES, SADL_CODUND_DEPOIS 
, SADL_UNIDEST_ANTES, SADL_UNIDEST_DEPOIS
, SADL_CODPEDIDO_ANTES, SADL_CODPEDIDO_DEPOIS from seu.seuadl_log2
where rid = a.rowid);

alter trigger seu.trg_seuaah_audit_t disable;

UPDATE SEU.SEUAAH SET SAAH_INCACTPAD = 'SEU_INC0002.php' 
WHERE SAAH_IDROTINA = '22'
  AND SAAH_IDOPCAO = '1';

 insert into SEU.SEUAAJ
       (SAAJ_FONTE, SAAJ_PASTA, SAAJ_DESC, SAAJ_IDUSUARIO)
     values
       (
        'SEU_INC0002.php', 
        'SEUINCLUDES', 
        'Roda uma procedure de criação de sequence para controle de processo do sistema de diplomas.', 
        ''
        );

alter trigger seu.trg_seuaah_audit_t ENABLE;
alter trigger seu.trg_seuadl_audit_t ENABLE;


select sequence_name, last_number from dba_sequences where sequence_owner='SEU' AND SEQUENCE_NAME LIKE 'SEQ_SEUADL_PROC%';

create sequence SEU.SEQ_SEUADL_PROCESSO_000133 START WITH 1141 MINVALUE 0 INCREMENT BY 1 maxvalue 999999999 NOCACHE;
create sequence SEU.SEQ_SEUADL_PROCESSO_000131 START WITH 243  MINVALUE 0 INCREMENT BY 1 maxvalue 999999999 NOCACHE;
create sequence SEU.SEQ_SEUADL_PROCESSO_000132 START WITH 1169 MINVALUE 0 INCREMENT BY 1 maxvalue 999999999 NOCACHE;

set serveroutput on size 50000
declare 
	cursor c1 is select SAAM_CODIGO from seu.seuaam;
	str varchar2(1000);
begin
	for rc1 in c1 loop
		begin
			str :='create sequence SEU.SEQ_SEUADL_PROCESSO_'||rc1.SAAM_CODIGO||' START WITH 1 MINVALUE 0 INCREMENT BY 1 maxvalue 999999999 NOCACHE';
			execute immediate str;
			str := 'grant select on SEU.SEQ_SEUADL_PROCESSO_'||rc1.SAAM_CODIGO||' to r_seu_all';
			execute immediate str;
		exception when others then 
			dbms_output.put_line('erro na sequence '||rc1.SAAM_CODIGO);
		end;
	end loop;
end;
/

CREATE OR REPLACE TRIGGER "SEU".TRG_SEUADL_INCR_I BEFORE
INSERT ON "SEU"."SEUADL" REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW 
DECLARE
	STR VARCHAR2(1000);
	NREG NUMBER :=0;
	PROC NUMBER :=0;
BEGIN
	STR :='SELECT SEQ_SEUADL_INSERT.NEXTVAL ,SEQ_SEUADL_PROCESSO_'||:new.SADL_CODUND||'.NEXTVAL FROM DUAL';
	EXECUTE IMMEDIATE STR INTO NREG,PROC;
	:NEW.SADL_NREG := NREG;
	:NEW.SADL_PROCESSO := PROC;
END;
/

alter trigger seu.TRG_SEUADL_INCR_I enable;

drop table seu.seuadl_old;
drop table seu.seuadl_log2;

drop table seu.seuadm_old ;
create table seu.seuadm_old as select sadm_nreg,SADM_CODPEDIDO from seu.seuadm;

alter trigger seu.trg_seuadm_audit_t disable;
update seu.seuadm set SADM_CODPEDIDO=null;
commit;

alter table seu.seuadm modify SADM_CODPEDIDO varchar2(16);

create index seu.ix_seuadm_old on seu.seuadm_old (sadm_nreg);

update seu.seuadm a set SADM_CODPEDIDO = (select SADM_CODPEDIDO from seu.seuadm_old where SADM_nreg=a.SADM_nreg);
commit;

UPDATE seu.SEUADM SET SADM_CODPEDIDO = 'P'||lpad(SADM_CODPEDIDO,15,'0') 
WHERE LENGTH(SADM_CODPEDIDO)<16;

create table seu.seuadm_log2 as SELECT ROWID RID, SADM_CODPEDIDO_ANTES, SADM_CODPEDIDO_DEPOIS FROM SEU.SEUADM_LOG;

create index seu.ix_seuadM_log2 on seu.seuadM_log2(rid);

update seu.seuadM_log set SADM_CODPEDIDO_ANTES=null, SADM_CODPEDIDO_DEPOIS=null;

commit;

exec seu.p_altera_log('SEUADM');

update seu.seuadM_log a set (SADM_CODPEDIDO_antes,SADM_CODPEDIDO_depois) = (select SADM_CODPEDIDO_antes,SADM_CODPEDIDO_depois from seu.seuadM_log2
where rid = a.rowid);
commit;

DROP TABLE SEU.SEUADM_OLD;
DROP TABLE SEU.SEUADM_LOG2;