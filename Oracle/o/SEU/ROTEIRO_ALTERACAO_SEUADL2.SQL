set serveroutput on size 50000

revoke select,insert,update,delete on seu.seuadl from r_seu_all;
revoke select on SEU.SEQ_SEUADL_REGISTRO FROM R_SEU_ALL;

create table seu.seuadl_bkp20070518 as select * from seu.seuadl;
create table seu.seuadl_old as select sadl_nreg, sadl_registro from seu.seuadl;
select count(1) from seu.seuadl_old;

alter trigger seu.trg_seuadl_audit_t disable;

update seu.seuadl set sadl_registro=null;

commit;

alter table seu.seuadl modify sadl_registro varchar2(50);

update seu.seuadl a set sadl_registro = (select sadl_registro from seu.seuadl_old
where sadl_nreg = a.sadl_nreg);

commit;

create table seu.seuadl_log2 as SELECT ROWID RID, SADL_REGISTRO_ANTES, SADL_REGISTRO_DEPOIS FROM SEU.SEUADL_LOG;

create index seu.ix_seuadl_log2 on seu.seuadl_log2(rid);

update seu.seuadl_log set SADL_REGISTRO_ANTES=null, SADL_REGISTRO_DEPOIS=null;

commit;

exec seu.p_altera_log('SEUADL');

update seu.seuadl_log a set (sadl_registro_antes,sadl_registro_depois) = (select sadl_registro_antes,sadl_registro_depois from seu.seuadl_log2
where rid = a.rowid);

commit;

alter trigger seu.trg_seuadl_audit_t enable;


grant select,insert,update,delete on seu.seuadl to r_seu_all;
grant select on SEU.SEQ_SEUADL_REGISTRO to R_SEU_ALL;

drop table seu.seuadl_old;
drop table seu.seuadl_log2;
