CONNECT SEGDBA@nglpd

grant select on SEGDBA.ECRAN_MODUL to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.ECRAN_SISTE to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.FUNCA_SISTE to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.GRUPO_UTILI_SEGUR to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select, insert, delete, update on SEGDBA.HELP_SISTE TO TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.HIERA_FUNCA_SISTE to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.MODUL_SISTE to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.PARAM_TROCA_SENHA to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.PRIVI_GRUPO_UTILI to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.SISTEMA to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.TIPO_OBJEC_SISTE to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.UTILI_GRUPO_UTILI to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select on SEGDBA.UTILI_PROPR_MODUL to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select,insert,update on SEGDBA.UTILI_SEGUR to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select, insert, update, delete on SEGDBA.SENHA_UTILI_SEGUR To TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant update(DAT_ULTIM_EXIBI_MENSA) on SEGDBA.UTILI_SEGUR to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant update(DES_SENHA_UTILI) on SEGDBA.UTILI_SEGUR to TAPDBA,GALPDBA,GASDBA,TAP,GALP,GASOLEO;
grant select, insert, update, delete on SEGDBA.ECRAN_MODUL to SEG;
grant select, insert, update, delete on SEGDBA.ECRAN_SISTE to SEG;
grant select, insert, update, delete on SEGDBA.FUNCA_SISTE to SEG;
grant select, insert, update, delete on SEGDBA.GRUPO_UTILI_SEGUR to SEG;
grant select, insert, update, delete on SEGDBA.HELP_SISTE to SEG;
grant select, insert, update, delete on SEGDBA.HIERA_FUNCA_SISTE to SEG;
grant select, insert, update, delete on SEGDBA.MODUL_SISTE to SEG;
grant select, insert, update, delete on SEGDBA.PARAM_TROCA_SENHA to SEG;
grant select, insert, update, delete on SEGDBA.PRIVI_GRUPO_UTILI to SEG;
grant select, insert, update, delete on SEGDBA.SENHA_UTILI_SEGUR to SEG;
grant select, insert, update, delete on SEGDBA.SISTEMA to SEG;
grant select, insert, update, delete on SEGDBA.TIPO_OBJEC_SISTE to SEG;
grant select, insert, update, delete on SEGDBA.UTILI_GRUPO_UTILI to SEG;
grant select, insert, update, delete on SEGDBA.UTILI_PROPR_MODUL to SEG;
grant select, insert, update, delete on SEGDBA.UTILI_SEGUR to SEG;



connect TAPTESTEnglpd

create synonym ECRAN_MODUL for SEGDBA.ECRAN_MODUL;                          
create synonym ECRAN_SISTE for SEGDBA.ECRAN_SISTE;                          
create synonym FUNCA_SISTE for SEGDBA.FUNCA_SISTE;                          
create synonym GRUPO_UTILI_SEGUR for SEGDBA.GRUPO_UTILI_SEGUR;              
create synonym HELP_SISTE for SEGDBA.HELP_SISTE;                            
create synonym HIERA_FUNCA_SISTE for SEGDBA.HIERA_FUNCA_SISTE;              
create synonym MODUL_SISTE for SEGDBA.MODUL_SISTE;                          
create synonym PARAM_TROCA_SENHA for SEGDBA.PARAM_TROCA_SENHA;              
create synonym PRIVI_GRUPO_UTILI for SEGDBA.PRIVI_GRUPO_UTILI;              
create synonym SENHA_UTILI_SEGUR for SEGDBA.SENHA_UTILI_SEGUR;              
create synonym SISTEMA for SEGDBA.SISTEMA;                                  
create synonym TIPO_OBJEC_SISTE for SEGDBA.TIPO_OBJEC_SISTE;                
create synonym UTILI_GRUPO_UTILI for SEGDBA.UTILI_GRUPO_UTILI;              
create synonym UTILI_PROPR_MODUL for SEGDBA.UTILI_PROPR_MODUL;              
create synonym UTILI_SEGUR for SEGDBA.UTILI_SEGUR;  



connect GALPDBA@nglpf
GRANT SELECT ON ESTRU_COMER TO SEG,SEGDBA;
GRANT SELECT ON COMPANHIA TO SEG,SEGDBA;
GRANT SELECT ON ERRO_PROCE_SISTE TO SEG,SEGDBA;


connect SEG@nglpf
drop synonym companhia;
drop synonym ESTRU_COMER;
drop synonym ERRO_PROCE_SISTE;
create synonym COMPANHIA for GALPDBA.COMPANHIA;
create synonym ESTRU_COMER for GALPDBA.ESTRU_COMER;
create synonym ERRO_PROCE_SISTE for GALPDBA.ERRO_PROCE_SISTE;

*********************************************************************************************

select object_type,object_name from dba_objects
where owner='INTEGRA'
and object_type not in ('SYNONYM','TABLE','INDEX','SEQUENCE','PACKAGE BODY','DATABASE LINK','TRIGGER')
ORDER BY 1




CREATE TABLESPACE SG01DD
DATAFILE '/db/oradata/glpp/data/glpp_sg01dd.ora'
SIZE 20m
DEFAULT STORAGE( INITIAL 32K NEXT 32k PCTINCREASE 0);

CREATE TABLESPACE GF01DD
DATAFILE '/db/oradata/glpp/data/glpp_gf01dd.ora'
SIZE 400m
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);

CREATE TABLESPACE QF01DD
DATAFILE '/db/oradata/glpp/data/glpp_qf01dd.ora'
SIZE 250m 
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);

CREATE TABLESPACE GO01DD
DATAFILE '/db/oradata/glpp/data/glpp_go01dd.ora'
SIZE 200m 
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);

/*
CREATE TABLESPACE GF02DD
DATAFILE '/db/oradata/glpd/data/glpd_gf02dd.ora'
SIZE 300m 
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);


CREATE TABLESPACE GF01IX
DATAFILE '/db/oradata/glpp/indx/glpp_gf01ix.ora'
SIZE 400m
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);
*/

CREATE USER SEGDBA
IDENTIFIED BY VENUS32
DEFAULT TABLESPACE SG01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER SEG
IDENTIFIED BY seg
DEFAULT TABLESPACE SG01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPDBA
IDENTIFIED BY GLDBA
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALP
IDENTIFIED BY galp
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER TAPDBA
IDENTIFIED BY tdba
DEFAULT TABLESPACE QF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER TAP
IDENTIFIED BY tap
DEFAULT TABLESPACE QF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GASDBA
IDENTIFIED BY gdba
DEFAULT TABLESPACE GO01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GASOLEO
IDENTIFIED BY gasoleo
DEFAULT TABLESPACE GO01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAP
IDENTIFIED BY GALPSAP
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAP_DBA
IDENTIFIED BY galpsap_dba
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;



alter USER SEGDBA
quota unlimited on SG01DD;

alter USER SEG
quota unlimited on SG01DD;

alter USER GALPDBA
quota unlimited on GF01DD;

alter USER GALP
quota unlimited on GF01DD;

alter USER TAPDBA
quota unlimited on QF01DD;

alter USER TAP
quota unlimited on QF01DD;

alter USER GASDBA
quota unlimited on GO01DD;

alter USER GASOLEO
quota unlimited on GO01DD;

alter USER GALPSAP
quota unlimited on GF01DD;

alter USER GALPSAP_DBA
DEFAULT TABLESPACE GF01DD;



grant connect,resource to SEGDBA;
grant connect,resource to SEG;
grant connect,resource to GALPDBA;
grant connect,resource to GALP;
grant connect,resource to TAPDBA;
grant connect,resource to TAP;
grant connect,resource to GASDBA;
grant connect,resource to GASOLEO;
grant connect,resource to GALPSAP;
grant connect,resource to GALPSAP_DBA;

revoke unlimited tablespace from SEGDBA;
revoke unlimited tablespace from SEG;
revoke unlimited tablespace from GALPDBA;
revoke unlimited tablespace from GALP;
revoke unlimited tablespace from TAPDBA;
revoke unlimited tablespace from TAP;
revoke unlimited tablespace from GASDBA;
revoke unlimited tablespace from GASOLEO;
revoke unlimited tablespace from GALPSAP;
revoke unlimited tablespace from GALPSAP_DBA;

create role roseguranca_connect;





CREATE TABLESPACE GF02DD
DATAFILE '/db/oradata/glpd/data/galpd_gf02dd.ora'
SIZE 400m
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);

CREATE TABLESPACE GF03DD
DATAFILE '/db/oradata/glpd/data/galpd_gf03dd.ora'
SIZE 400m
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);

CREATE TABLESPACE GF04DD
DATAFILE '/db/oradata/glpd/data/galpd_gf04dd.ora'
SIZE 400m
DEFAULT STORAGE( INITIAL 128K NEXT 128k PCTINCREASE 30);



CREATE USER gftst
IDENTIFIED BY gftst
DEFAULT TABLESPACE GF02DD
TEMPORARY TABLESPACE TEMP;

CREATE USER inter
IDENTIFIED BY inter
DEFAULT TABLESPACE GF03DD
TEMPORARY TABLESPACE TEMP;

CREATE USER fact
IDENTIFIED BY fact
DEFAULT TABLESPACE GF02DD
TEMPORARY TABLESPACE TEMP;

alter USER gftst
quota unlimited on GF02DD;

alter USER inter
quota unlimited on GF03DD;

alter USER fact
quota unlimited on GF02DD;

grant connect,resource to gftst;
grant connect,resource to inter;
grant connect,resource to fact;





CREATE USER GALPSAPH
IDENTIFIED BY GALPSAPH
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAPH_DBA
IDENTIFIED BY galpsapH_dba
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAPI
IDENTIFIED BY GALPSAPI
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAPI_DBA
IDENTIFIED BY galpsapI_dba
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

alter USER GALPSAPH
quota unlimited on GF01DD;

alter USER GALPSAPH_DBA
quota unlimited on GF01DD;

alter USER GALPSAPI
quota unlimited on GF01DD;

alter USER GALPSAPI_DBA
quota unlimited on GF01DD;

grant connect,resource to GALPSAPI;
grant connect,resource to GALPSAPI_DBA;
grant connect,resource to GALPSAPH_DBA;
grant connect,resource to GALPSAPH;









drop user galp cascade;
drop user galpsap cascade;
drop user galpsap_dba cascade;
alter tablespace gf01dd coalesce;

CREATE USER GALP
IDENTIFIED BY galp
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAP
IDENTIFIED BY GALPSAP
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

CREATE USER GALPSAP_DBA
IDENTIFIED BY galpsap_dba
DEFAULT TABLESPACE GF01DD
TEMPORARY TABLESPACE TEMP;

alter USER GALP
quota unlimited on GF01DD;
alter USER GALPSAP
quota unlimited on GF01DD;
alter USER GALPSAP_DBA
DEFAULT TABLESPACE GF01DD;
grant connect,resource to GALP;
grant connect,resource to GALPSAP;
grant connect,resource to GALPSAP_DBA;





connect galpdba@nglpf

GRANT REFERENCES,SELECT ON galpdba.COMPANHIA TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.CONCELHO TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.DISTRITO TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.ERRO_PROCE_SISTE TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.FREGUESIA TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.ISP_CORPO_ZONA_TERRI TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.MOEDA TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.MORADA TO GASDBA;
GRANT REFERENCES,SELECT ON galpdba.POSICAO TO GASDBA;

GRANT REFERENCES,SELECT ON galpdba.COMPANHIA TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.CONCELHO TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.DISTRITO TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.ERRO_PROCE_SISTE TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.FREGUESIA TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.ISP_CORPO_ZONA_TERRI TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.MOEDA TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.MORADA TO GASOLEO;
GRANT REFERENCES,SELECT ON galpdba.POSICAO TO GASOLEO;



GRANT REFERENCES,SELECT ON galpdba.COMPANHIA TO TAPdba;
GRANT REFERENCES,SELECT ON galpdba.POSICAO TO TAPdba;
GRANT REFERENCES,SELECT ON galpdba.TIPO_LOCAL_POSIC TO TAPdba;
GRANT REFERENCES,SELECT ON galpdba.MOEDA TO TAPdba;
GRANT REFERENCES,SELECT ON galpdba.ERRO_PROCE_SISTE TO TAPdba;

GRANT REFERENCES,SELECT ON galpdba.COMPANHIA TO TAP;
GRANT REFERENCES,SELECT ON galpdba.ERRO_PROCE_SISTE TO TAP;
GRANT REFERENCES,SELECT ON galpdba.MOEDA TO TAP;
GRANT REFERENCES,SELECT ON galpdba.TIPO_LOCAL_POSIC TO TAP;
GRANT REFERENCES,SELECT ON galpdba.POSICAO TO TAP;




connect gasdba@nglpf

drop SYNONYM gasdba.COMPANHIA ;
drop SYNONYM gasdba.CONCELHO ;
drop SYNONYM gasdba.DISTRITO ;
drop SYNONYM gasdba.ERRO_PROCE_SISTE ;
drop SYNONYM gasdba.FREGUESIA ;
drop SYNONYM gasdba.ISP_CORPO_ZONA_TERRI ;
drop SYNONYM gasdba.MOEDA ;
drop SYNONYM gasdba.MORADA ;
drop SYNONYM gasdba.POSICAO ;

CREATE SYNONYM gasdba.COMPANHIA FOR galpdba.COMPANHIA;
CREATE SYNONYM gasdba.CONCELHO FOR galpdba.CONCELHO;
CREATE SYNONYM gasdba.DISTRITO FOR galpdba.DISTRITO;
CREATE SYNONYM gasdba.ERRO_PROCE_SISTE FOR galpdba.ERRO_PROCE_SISTE;
CREATE SYNONYM gasdba.FREGUESIA FOR galpdba.FREGUESIA;
CREATE SYNONYM gasdba.ISP_CORPO_ZONA_TERRI FOR galpdba.ISP_CORPO_ZONA_TERRI;
CREATE SYNONYM gasdba.MOEDA FOR galpdba.MOEDA;
CREATE SYNONYM gasdba.MORADA FOR galpdba.MORADA;
CREATE SYNONYM gasdba.POSICAO FOR galpdba.POSICAO;


connect gasoleo@nglpf

drop SYNONYM COMPANHIA ;
drop SYNONYM CONCELHO ;
drop SYNONYM DISTRITO ;
drop SYNONYM ERRO_PROCE_SISTE ;
drop SYNONYM FREGUESIA ;
drop SYNONYM ISP_CORPO_ZONA_TERRI ;
drop SYNONYM MOEDA ;
drop SYNONYM MORADA ;
drop SYNONYM POSICAO ;

CREATE SYNONYM GASOLEO.COMPANHIA FOR galpdba.COMPANHIA;
CREATE SYNONYM GASOLEO.CONCELHO FOR galpdba.CONCELHO;
CREATE SYNONYM GASOLEO.DISTRITO FOR galpdba.DISTRITO;
CREATE SYNONYM GASOLEO.ERRO_PROCE_SISTE FOR galpdba.ERRO_PROCE_SISTE;
CREATE SYNONYM GASOLEO.FREGUESIA FOR galpdba.FREGUESIA;
CREATE SYNONYM GASOLEO.ISP_CORPO_ZONA_TERRI FOR galpdba.ISP_CORPO_ZONA_TERRI;
CREATE SYNONYM GASOLEO.MOEDA FOR galpdba.MOEDA;
CREATE SYNONYM GASOLEO.MORADA FOR galpdba.MORADA;
CREATE SYNONYM GASOLEO.POSICAO FOR galpdba.POSICAO;



connect tapdba@nglpf

drop synonym COMPANHIA;
drop synonym ERRO_PROCE_SISTE;
drop synonym MOEDA;
drop synonym TIPO_LOCAL_POSIC;
drop synonym POSICAO;

CREATE SYNONYM TAPDBA.COMPANHIA FOR galpdba.COMPANHIA;
CREATE SYNONYM TAPDBA.ERRO_PROCE_SISTE FOR galpdba.ERRO_PROCE_SISTE;
CREATE SYNONYM TAPDBA.MOEDA FOR galpdba.MOEDA;
CREATE SYNONYM TAPDBA.TIPO_LOCAL_POSIC FOR galpdba.TIPO_LOCAL_POSIC;
CREATE SYNONYM TAPDBA.POSICAO FOR galpdba.POSICAO;

connect tap@nglpf

drop synonym COMPANHIA;
drop synonym ERRO_PROCE_SISTE;
drop synonym MOEDA;
drop synonym TIPO_LOCAL_POSIC;
drop synonym POSICAO;

CREATE SYNONYM TAP.COMPANHIA FOR galpdba.COMPANHIA;
CREATE SYNONYM TAP.ERRO_PROCE_SISTE FOR galpdba.ERRO_PROCE_SISTE;
CREATE SYNONYM TAP.MOEDA FOR galpdba.MOEDA;
CREATE SYNONYM TAP.TIPO_LOCAL_POSIC FOR galpdba.TIPO_LOCAL_POSIC;
CREATE SYNONYM TAP.POSICAO FOR galpdba.POSICAO;



grant select on subsi_gadol to galpdba;
create synonym subsi_gasol for gasdba.subsi_gasol;







connect gasdba@nglpf

/*
drop SEQUENCE GASDBA.SQ_NUM_SEQUE_BANDA;      
drop SEQUENCE GASDBA.SQ_NUM_SEQUE_BANDA_REJEI;
drop SEQUENCE GASDBA.SQ_NUM_SEQUE_REJEI_TRANS;
*/
CREATE SEQUENCE GASDBA.SQ_NUM_SEQUE_BANDA      ;
CREATE SEQUENCE GASDBA.SQ_NUM_SEQUE_BANDA_REJEI;
CREATE SEQUENCE GASDBA.SQ_NUM_SEQUE_REJEI_TRANS;

grant select on subsi_gasol to galpdba;
GRANT EXECUTE ON SP_FECHO_CARTA_PONTO TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_ACTIV_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_ACUMU_POSIC_ACTIV_GAS TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_BENEF_CARTA_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_CARTA_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_CARTA_GUARD_FISCA TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_CONSU_CARTA_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_GUARD_FISCA TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_HISTO_CARTA_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_HISTO_CONSU_CARTA_GAS TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_LEITU_POSIC_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_POSIC_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_TRANS_GASOL TO GASOLEO;
GRANT EXECUTE ON SP_MIGRA_TRANS_GASOL_REJEI TO GASOLEO;
GRANT SELECT ON SQ_NUM_SEQUE_BANDA TO GASOLEO;
GRANT SELECT ON SQ_NUM_SEQUE_BANDA_REJEI TO GASOLEO;
GRANT SELECT ON SQ_NUM_SEQUE_REJEI_TRANS TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON ACTIV_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON ACUMU_POSIC_ACTIV_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON BANDA_MINIS TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON BANDA_MINIS_REJEI TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON BENEF_CARTA_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON CARTA_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON CARTA_GUARD_FISCA TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON CONSU_CARTA_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON GUARD_FISCA TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_CARTA_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_CARTA_GUARD_FISCA TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_CONSU_CARTA_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_TRANS TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON JUSTI_HISTO_CARTA_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON LEITU_POSIC_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON POSIC_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON SUBSI_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON TIPO_ACTIV_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON TIPO_TRANS_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON TRANS_GASOL TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON TRANS_GASOL_REJEI TO GASOLEO;
GRANT SELECT,INSERT,DELETE,UPDATE ON VERSA_PLAFO_GASOL TO GASOLEO;

ALTER TABLE ACTIV_GASOL
ADD CONSTRAINT FK_ACTIV_GAOL_COMPANHIA 
FOREIGN KEY (IDT_COMPA) 
REFERENCES GALPDBA.COMPANHIA (IDT_COMPA);

ALTER TABLE POSIC_GASOL
ADD CONSTRAINT FK_POSIC_GA_1240_FREGUESI 
FOREIGN KEY (COD_DISTR, COD_CONCE, COD_FREGU) 
REFERENCES GALPDBA.FREGUESIA (COD_DISTR, COD_CONCE, COD_FREGU)
ADD CONSTRAINT FK_POSIC_GAOL_COMPANHIA 
FOREIGN KEY (IDT_COMPA) 
REFERENCES GALPDBA.COMPANHIA (IDT_COMPA);

ALTER TABLE BANDA_MINIS
ADD CONSTRAINT FK_BANDA_MI_RELATION__FREGUESI 
FOREIGN KEY (COD_DISTR, COD_CONCE, COD_FREGU) 
REFERENCES GALPDBA.FREGUESIA (COD_DISTR, COD_CONCE, COD_FREGU);

ALTER TABLE BANDA_MINIS_REJEI
ADD CONSTRAINT FK_BANDA_MINIS_REJEI 
FOREIGN KEY (COD_ERRO_PROCE_SISTE) 
REFERENCES GALPDBA.ERRO_PROCE_SISTE (COD_ERRO_PROCE_SISTE);

ALTER TABLE BENEF_CARTA_GASOL
ADD CONSTRAINT FK_BENEF_CA_1375_FREGUESI 
FOREIGN KEY (COD_DISTR, COD_CONCE, COD_FREGU) 
REFERENCES GALPDBA.FREGUESIA (COD_DISTR, COD_CONCE, COD_FREGU);

ALTER TABLE GUARD_FISCA
ADD CONSTRAINT FK_GUARD_FI_1416_FREGUESI 
FOREIGN KEY (COD_DISTR, COD_CONCE, COD_FREGU) 
REFERENCES GALPDBA.FREGUESIA (COD_DISTR, COD_CONCE, COD_FREGU);

ALTER TABLE SUBSI_GASOL
ADD CONSTRAINT FK_SUBSI_GASOL_COMPANHIA 
FOREIGN KEY (IDT_COMPA) 
REFERENCES GALPDBA.COMPANHIA(IDT_COMPA);

ALTER TABLE TRANS_GASOL_REJEI
ADD CONSTRAINT FK_TRANS_GASOL_REJEI 
FOREIGN KEY (COD_ERRO_PROCE_SISTE) 
REFERENCES GALPDBA.ERRO_PROCE_SISTE (COD_ERRO_PROCE_SISTE);



connect gasoleo@nglpf

create synonym SP_FECHO_CARTA_PONTO for gasdba.SP_FECHO_CARTA_PONTO;
create synonym SP_MIGRA_ACTIV_GASOL for gasdba.SP_MIGRA_ACTIV_GASOL;
create synonym SP_MIGRA_ACUMU_POSIC_ACTIV_GAS for gasdba.SP_MIGRA_ACUMU_POSIC_ACTIV_GAS;
create synonym SP_MIGRA_BENEF_CARTA_GASOL for gasdba.SP_MIGRA_BENEF_CARTA_GASOL;
create synonym SP_MIGRA_CARTA_GASOL for gasdba.SP_MIGRA_CARTA_GASOL;
create synonym SP_MIGRA_CARTA_GUARD_FISCA for gasdba.SP_MIGRA_CARTA_GUARD_FISCA;
create synonym SP_MIGRA_CONSU_CARTA_GASOL for gasdba.SP_MIGRA_CONSU_CARTA_GASOL;
create synonym SP_MIGRA_GUARD_FISCA for gasdba.SP_MIGRA_GUARD_FISCA;
create synonym SP_MIGRA_HISTO_CARTA_GASOL for gasdba.SP_MIGRA_HISTO_CARTA_GASOL;
create synonym SP_MIGRA_HISTO_CONSU_CARTA_GAS for gasdba.SP_MIGRA_HISTO_CONSU_CARTA_GAS;
create synonym SP_MIGRA_LEITU_POSIC_GASOL for gasdba.SP_MIGRA_LEITU_POSIC_GASOL;
create synonym SP_MIGRA_POSIC_GASOL for gasdba.SP_MIGRA_POSIC_GASOL;
create synonym SP_MIGRA_TRANS_GASOL for gasdba.SP_MIGRA_TRANS_GASOL;
create synonym SP_MIGRA_TRANS_GASOL_REJEI for gasdba.P_MIGRA_TRANS_GASOL_REJEI;

create synonym SQ_NUM_SEQUE_BANDA for gasdba.SQ_NUM_SEQUE_BANDA;
create synonym SQ_NUM_SEQUE_BANDA_REJEI for gasdba.SQ_NUM_SEQUE_BANDA_REJEI;
create synonym SQ_NUM_SEQUE_REJEI_TRANS for gasdba.SQ_NUM_SEQUE_REJEI_TRANS;

create synonym ACTIV_GASOL for gasdba.ACTIV_GASOL;
create synonym ACUMU_POSIC_ACTIV_GASOL for gasdba.ACUMU_POSIC_ACTIV_GASOL;
create synonym BANDA_MINIS for gasdba.BANDA_MINIS;
create synonym BANDA_MINIS_REJEI for gasdba.BANDA_MINIS_REJEI;
create synonym BENEF_CARTA_GASOL for gasdba.BENEF_CARTA_GASOL;
create synonym CARTA_GASOL for gasdba.CARTA_GASOL;
create synonym CARTA_GUARD_FISCA for gasdba.CARTA_GUARD_FISCA;
create synonym CONSU_CARTA_GASOL for gasdba.CONSU_CARTA_GASOL;
create synonym GUARD_FISCA for gasdba.GUARD_FISCA;
create synonym HISTO_CARTA_GASOL for gasdba.HISTO_CARTA_GASOL;
create synonym HISTO_CARTA_GUARD_FISCA for gasdba.HISTO_CARTA_GUARD_FISCA;
create synonym HISTO_CONSU_CARTA_GASOL for gasdba.HISTO_CONSU_CARTA_GASOL;
create synonym HISTO_TRANS for gasdba.HISTO_TRANS;
create synonym JUSTI_HISTO_CARTA_GASOL for gasdba.JUSTI_HISTO_CARTA_GASOL;
create synonym LEITU_POSIC_GASOL for gasdba.LEITU_POSIC_GASOL;
create synonym POSIC_GASOL for gasdba.POSIC_GASOL;
create synonym SUBSI_GASOL for gasdba.SUBSI_GASOL;
create synonym TIPO_ACTIV_GASOL for gasdba.TIPO_ACTIV_GASOL;
create synonym TIPO_TRANS_GASOL for gasdba.TIPO_TRANS_GASOL;
create synonym TRANS_GASOL for gasdba.TRANS_GASOL;
create synonym TRANS_GASOL_REJEI for gasdba.TRANS_GASOL_REJEI;
create synonym VERSA_PLAFO_GASOL for gasdba.VERSA_PLAFO_GASOL;





connect tapdba@nglpf

/*
drop sequence SQ_NUM_SEQUE_REJEI;
CREATE SEQUENCE SQ_NUM_SEQUE_REJEI;
*/

GRANT EXECUTE ON SP_CARGA_TRANS_CARTA TO TAP;
GRANT EXECUTE ON SP_FECHO_CARTA_PONTO TO TAP;
GRANT EXECUTE ON SP_MIGRA_CARTA_PONTO TO TAP;
GRANT EXECUTE ON SP_MIGRA_CARTA_PONTO_LOCAL TO TAP;
GRANT EXECUTE ON SP_MIGRA_HISTO_CARTA_PONTO TO TAP;
GRANT EXECUTE ON SP_MIGRA_HISTO_MOVIM_ENVIA TO TAP;
GRANT EXECUTE ON SP_MIGRA_HISTO_PONTO_LOCAL TO TAP;
GRANT EXECUTE ON SP_MIGRA_HISTO_POSIC TO TAP;
GRANT EXECUTE ON SP_MIGRA_PREENCHE_PONTO_ATRIB TO TAP;
GRANT EXECUTE ON SP_MIGRA_TRANS_PONTO_REJEI TO TAP;
GRANT EXECUTE ON SP_RECUP_TRANS_CARTA TO TAP;
GRANT SELECT ON SQ_NUM_SEQUE_REJEI TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON CARTA_PONTO TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON CODIG_PISTA_2 TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON EMISS_CARTA_PONTO TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_CARTA_PONTO TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_MOVIM_ENVIA TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_PONTO_TIPO_LOCAL TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON HISTO_POSIC TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON ITEM_PISTA_2 TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON REGRA_PONTO_TIPO_CARTA TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON TIPO_CARTA_PONTO TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON TRANS_CARTA_PONTO TO TAP;
GRANT SELECT,INSERT,DELETE,UPDATE ON TRANS_PONTO_REJEI TO TAP;



alter table EMISS_CARTA_PONTO
    add constraint FK_EMISS_CA_8995_MOEDA foreign key  (COD_MOEDA)
       references GALPDBA.MOEDA (COD_MOEDA);

alter table HISTO_PONTO_TIPO_LOCAL
    add constraint FK_HISTO_PO_1229_TIPO_LOC foreign key  (COD_TIPO_LOCAL)
       references GALPDBA.TIPO_LOCAL_POSIC (COD_TIPO_LOCAL);

alter table HISTO_POSIC
    add constraint FK_HISTO_PO_1228_POSICAO foreign key  (IDT_COMPA, COD_POSIC)
       references GALPDBA.POSICAO (IDT_COMPA, COD_POSIC);

alter table TRANS_PONTO_REJEI
    add constraint FK_TRANS_PO_8996_ERRO_PRO foreign key  (COD_ERRO_PROCE_SISTE)
       references GALPDBA.ERRO_PROCE_SISTE (COD_ERRO_PROCE_SISTE);

alter table TRANS_CARTA_PONTO
    add constraint FK_TRANS_CA_8989_POSICAO foreign key  (IDT_COMPA, COD_POSIC)
       references GALPDBA.POSICAO (IDT_COMPA, COD_POSIC);



CONNECT TAP@NGLPf


CREATE OR REPLACE VIEW ACUMPONTOLITRO
AS SELECT C.COD_ENTID_EMISS
      ,C.COD_TIPO_CARTA
      ,C.COD_CARTA_PONTO
      ,E.NOM_ENTID_EMISS
      ,T.NOM_CARTA_PONTO
      ,C.QTD_TOTAL_PONTO_CALCU_CARTA
      ,C.QTD_TOTAL_PONTO_ATRIB_CARTA
      ,C.QTD_TOTAL_LITRO_CONSU_CARTA
      ,C.QTD_TOTAL_TRANS_CARTA
      ,C.VAL_TOTAL_DIVIS
  FROM EMISS_CARTA_PONTO E
      ,TIPO_CARTA_PONTO  T
      ,CARTA_PONTO       C
 WHERE E.COD_ENTID_EMISS = T.COD_ENTID_EMISS
   AND T.COD_ENTID_EMISS = C.COD_ENTID_EMISS
   AND T.COD_TIPO_CARTA = C.COD_TIPO_CARTA ;


CREATE OR REPLACE VIEW ACUMDATATIPOLOCAL
AS SELECT H.COD_TIPO_LOCAL
      ,H.ANO_HISTO_TIPO_LOCAL
      ,H.MES_HISTO_TIPO_LOCAL
      ,T.NOM_TIPO_LOCAL
      ,H.QTD_PONTO_CALCU_MES
      ,H.QTD_PONTO_ATRIB_MES
      ,H.QTD_LITRO_CONSU_MES
      ,H.QTD_TRANS_PROCE_MES
      ,H.VAL_ATRIB_DIVIS_MES
  FROM TIPO_LOCAL_POSIC      T
      ,HISTO_PONTO_TIPO_LOCAL H
 WHERE T.COD_TIPO_LOCAL = H.COD_TIPO_LOCAL  ;


CREATE OR REPLACE VIEW ACUMDATATIPOCARTA
AS SELECT H.ANO_HISTO_CARTA
      ,H.MES_HISTO_CARTA
      ,E.NOM_ENTID_EMISS
      ,T.NOM_CARTA_PONTO
      ,H.QTD_PONTO_CALCU_MES
      ,H.QTD_PONTO_ATRIB_MES
      ,H.QTD_LITRO_CONSU_MES
      ,H.QTD_TRANS_PROCE_MES
      ,H.VAL_ATRIB_DIVIS_MES
  FROM EMISS_CARTA_PONTO E
      ,TIPO_CARTA_PONTO  T
      ,HISTO_CARTA_PONTO H 
 WHERE E.COD_ENTID_EMISS = T.COD_ENTID_EMISS
   AND T.COD_ENTID_EMISS = H.COD_ENTID_EMISS
   AND T.COD_TIPO_CARTA  = H.COD_TIPO_CARTA ;

CREATE SYNONYM CARTA_PONTO FOR TAPDBA.CARTA_PONTO;
CREATE SYNONYM CODIG_PISTA_2 FOR TAPDBA.CODIG_PISTA_2;
CREATE SYNONYM EMISS_CARTA_PONTO FOR TAPDBA.EMISS_CARTA_PONTO;
CREATE SYNONYM HISTO_CARTA_PONTO FOR TAPDBA.HISTO_CARTA_PONTO;
CREATE SYNONYM HISTO_MOVIM_ENVIA FOR TAPDBA.HISTO_MOVIM_ENVIA;
CREATE SYNONYM HISTO_PONTO_TIPO_LOCAL FOR TAPDBA.HISTO_PONTO_TIPO_LOCAL;
CREATE SYNONYM HISTO_POSIC FOR TAPDBA.HISTO_POSIC;
CREATE SYNONYM ITEM_PISTA_2 FOR TAPDBA.ITEM_PISTA_2;
CREATE SYNONYM REGRA_PONTO_TIPO_CARTA FOR TAPDBA.REGRA_PONTO_TIPO_CARTA;
CREATE SYNONYM SP_CARGA_TRANS_CARTA FOR TAPDBA.SP_CARGA_TRANS_CARTA;
CREATE SYNONYM SP_FECHO_CARTA_PONTO FOR TAPDBA.SP_FECHO_CARTA_PONTO;
CREATE SYNONYM SP_MIGRA_CARTA_PONTO FOR TAPDBA.SP_MIGRA_CARTA_PONTO;
CREATE SYNONYM SP_MIGRA_CARTA_PONTO_LOCAL FOR TAPDBA.SP_MIGRA_CARTA_PONTO_LOCAL;
CREATE SYNONYM SP_MIGRA_HISTO_CARTA_PONTO FOR TAPDBA.SP_MIGRA_HISTO_CARTA_PONTO;
CREATE SYNONYM SP_MIGRA_HISTO_MOVIM_ENVIA FOR TAPDBA.SP_MIGRA_HISTO_MOVIM_ENVIA;
CREATE SYNONYM SP_MIGRA_HISTO_PONTO_LOCAL FOR TAPDBA.SP_MIGRA_HISTO_PONTO_LOCAL;
CREATE SYNONYM SP_MIGRA_HISTO_POSIC FOR TAPDBA.SP_MIGRA_HISTO_POSIC;
CREATE SYNONYM SP_MIGRA_PREENCHE_PONTO_ATRIB FOR TAPDBA.SP_MIGRA_PREENCHE_PONTO_ATRIB;
CREATE SYNONYM SP_MIGRA_TRANS_PONTO_REJEI FOR TAPDBA.SP_MIGRA_TRANS_PONTO_REJEI;
CREATE SYNONYM SP_RECUP_TRANS_CARTA FOR TAPDBA.SP_RECUP_TRANS_CARTA;
CREATE SYNONYM SQ_NUM_SEQUE_REJEI FOR TAPDBA.SQ_NUM_SEQUE_REJEI;
CREATE SYNONYM TIPO_CARTA_PONTO FOR TAPDBA.TIPO_CARTA_PONTO;
CREATE SYNONYM TRANS_CARTA_PONTO FOR TAPDBA.TRANS_CARTA_PONTO;
CREATE SYNONYM TRANS_PONTO_REJEI FOR TAPDBA.TRANS_PONTO_REJEI;

alter PACKAGE BODY PACK_AIRMAX compile body;                                         
alter PROCEDURE PROC_RATEIO_CONG compile;                                       
alter PROCEDURE PROC_RATEIO_GERAL compile;                                      
alter PROCEDURE PROC_RATEIO_LIGHT compile;                                      
alter PROCEDURE PROC_RATEIO_TAM compile;                                        
alter PROCEDURE PROC_RAT_GER_CONG compile;                                      
alter PROCEDURE PROC_REC2655X compile;                                          
alter PROCEDURE PROC_REC9104 compile;                                           
alter PROCEDURE PROC_REC9202 compile;                                           
alter TRIGGER TRIG_REC2213 compile;                                             
alter TRIGGER TRIG_REC2214 compile;                                             

**********************************************************************************************

alter index IND_ACOM_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_ACOM_2 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_ACOM_3 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_ACOM_4 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_ACOM_5 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_AVLAN_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_AVLAN_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_AVLAN_3 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_AVLAN_4 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_BLT_1 rebuild tablespace TS_REC_INDEX02;                        
alter index IND_CMUO_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_COAMU_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_CONREC_1 rebuild tablespace TS_REC_INDEX01;                     
alter index IND_CPCNG_1 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_CPCNG_2 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_CPCNG_3 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_CPEMI_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_CPEMI_2 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_CPUTI_1 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_CPUTI_2 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_CPUTI_3 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_CPUTI_4 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_CTNEL_1 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_CTNEL_2 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_DETITS_1 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_DETITS_2 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_DOC_REC rebuild tablespace TS_REC_INDEX03;                      
alter index IND_DOREC_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_DOREC_3 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_DOREC_4 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_DOREC_5 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_DOREC_6 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_DRCJD_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_DRTX_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_EXBAG_1 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_EXBAG_2 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_EXBAG_3 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_EXCAD_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_FATAG_1 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_FATAG_2 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_FATAG_3 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_FATAG_4 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_FCDOC_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_FCDOC_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_FORES_1 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_FORIA_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_FORIA_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_FORIA_3 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_FTCNG_1 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_FTCNG_2 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_FTCNG_3 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_GRCOM_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_GRCOM_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_HISDR_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_ICMUO_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_ICMUO_2 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_IMPA_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_IMPCID_1 rebuild tablespace TS_REC_INDEX01;                     
alter index IND_IMPUF_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_IRRDR_1 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_IRRDR_2 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_ITFAT_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_ITFAT_2 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_ITFAT_3 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_ITGCO_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_ITREE_1 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_ITREE_2 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_LCDRU_1 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_LCVC_1 rebuild tablespace TS_REC_INDEX05;                       
alter index IND_LDCAN rebuild tablespace TS_REC_INDEX05;                        
alter index IND_LIFA_1 rebuild tablespace TS_REC_INDEX06;                       
alter index IND_MCO_1 rebuild tablespace TS_REC_INDEX02;                        
alter index IND_MCO_2 rebuild tablespace TS_REC_INDEX02;                        
alter index IND_MOVFRL_1 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_MOVFRL_1_ERRO rebuild tablespace TS_REC_INDEX05;                
alter index IND_MOVFRL_2 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_MOVFRL_2_ERRO rebuild tablespace TS_REC_INDEX05;                
alter index IND_MOVFRL_3 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_MOVFRL_3_ERRO rebuild tablespace TS_REC_INDEX05;                
alter index IND_MOVFRL_4 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_MTRA_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_MTRA_2 rebuild tablespace TS_REC_INDEX03;                       
alter index IND_MVPAS_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_MVPAS_2 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_MVPAS_3 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_MVPAS_4 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_MVPAS_5 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_MVPSPG_1 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_OPFP_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_OPFP_2 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_OPFRE_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_OPFRE_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_PAREC_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_PAREC_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_PAXRIP_1 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_PEFEC_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_PERFAT_1 rebuild tablespace TS_REC_INDEX01;                     
alter index IND_PERFAT_3 rebuild tablespace TS_REC_INDEX01;                     
alter index IND_PGAGE_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_PGAVL_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_PGAVL_2 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_PGCCR_1 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_PGCCR_2 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_PGDRE_1 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_PGDRE_2 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_PGDRE_3 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_PGFIN_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_PGFRE_1 rebuild tablespace TS_REC_INDEX02;                      
alter index IND_PGLIV_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_PGMCO_1 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_PGPTA_1 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_PGRE_1 rebuild tablespace TS_REC_INDEX05;                       
alter index IND_PGRE_2 rebuild tablespace TS_REC_INDEX05;                       
alter index IND_PGRE_3 rebuild tablespace TS_REC_INDEX05;                       
alter index IND_PGRE_4 rebuild tablespace TS_REC_INDEX05;                       
alter index IND_PGRIP_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_PGSUB_1 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_PGVDS_1 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_PGVDS_2 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_PGVIS_1 rebuild tablespace TS_REC_INDEX05;                      
alter index IND_PTA_1 rebuild tablespace TS_REC_INDEX02;                        
alter index IND_RECFRL_1 rebuild tablespace TS_REC_INDEX01;                     
alter index IND_RESCC_1 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_RESCC_2 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_RESCC_3 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_RESCC_4 rebuild tablespace TS_REC_INDEX03;                      
alter index IND_RGREE_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_RGREE_2 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_RIPES_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_RIP_1 rebuild tablespace TS_REC_INDEX05;                        
alter index IND_RIP_2 rebuild tablespace TS_REC_INDEX05;                        
alter index IND_RIP_3 rebuild tablespace TS_REC_INDEX05;                        
alter index IND_RIP_4 rebuild tablespace TS_REC_INDEX05;                        
alter index IND_RIP_5 rebuild tablespace TS_REC_INDEX05;                        
alter index IND_SOCOF_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_SOLREE rebuild tablespace TS_REC_INDEX03;                       
alter index IND_TIFRL_1 rebuild tablespace TS_REC_INDEX01;                      
alter index IND_TRAPNC_6 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_TRAPNC_7 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_TRELF_1 rebuild tablespace TS_REC_INDEX06;                      
alter index IND_TRIP_1 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_TRIP_2 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_TRIP_3 rebuild tablespace TS_REC_INDEX01;                       
alter index IND_TRPTA_1 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_TRPTA_2 rebuild tablespace TS_REC_INDEX04;                      
alter index IND_VOCCNG_1 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_VOCUTI_1 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_VOCUTI_2 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_VOCUTI_3 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_VOCUTI_4 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_VOOCNG_2 rebuild tablespace TS_REC_INDEX06;                     
alter index IND_VOOCNG_3 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_VOOCNG_4 rebuild tablespace TS_REC_INDEX03;                     
alter index IND_WKDOREC_1 rebuild tablespace TS_REC_INDEX03;                    
alter index IND_WK_VOADO rebuild tablespace TS_REC_INDEX01;                     
alter index IND_WK_VOCUTI_5 rebuild tablespace TS_REC_INDEX06;                  
alter index IND_WVOANVEN_1 rebuild tablespace TS_REC_INDEX01;                   
alter index LCDRU_PK rebuild tablespace TS_REC_INDEX01;                         
alter index LCVC_PK rebuild tablespace TS_REC_INDEX01;                          
alter index PK_ACFRE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_ACOM rebuild tablespace TS_REC_INDEX01;                          
alter index PK_AUX_BILHETE rebuild tablespace TS_REC_INDEX01;                   
alter index PK_AUX_FAT rebuild tablespace TS_REC_INDEX01;                       
alter index PK_AVLAN rebuild tablespace TS_REC_INDEX01;                         
alter index PK_BLT rebuild tablespace TS_REC_INDEX01;                           
alter index PK_CALDI rebuild tablespace TS_REC_INDEX01;                         
alter index PK_CARCRED rebuild tablespace TS_REC_INDEX01;                       
alter index PK_CDRIP rebuild tablespace TS_REC_INDEX01;                         
alter index PK_CMUO rebuild tablespace TS_REC_INDEX03;                          
alter index PK_COAMU rebuild tablespace TS_REC_INDEX01;                         
alter index PK_CONREC rebuild tablespace TS_REC_INDEX01;                        
alter index PK_CPCNG rebuild tablespace TS_REC_INDEX01;                         
alter index PK_CPEMI rebuild tablespace TS_REC_INDEX01;                         
alter index PK_CPUTI rebuild tablespace TS_REC_INDEX01;                         
alter index PK_CTBSP rebuild tablespace TS_REC_INDEX03;                         
alter index PK_CTNEL rebuild tablespace TS_REC_INDEX05;                         
alter index PK_CTRPR rebuild tablespace TS_REC_INDEX03;                         
alter index PK_DEL_MOVFRL rebuild tablespace TS_REC_INDEX03;                    
alter index PK_DETITS rebuild tablespace TS_REC_INDEX03;                        
alter index PK_DOREC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_DRCJD rebuild tablespace TS_REC_INDEX01;                         
alter index PK_DRCNG rebuild tablespace TS_REC_INDEX01;                         
alter index PK_DRTX rebuild tablespace TS_REC_INDEX01;                          
alter index PK_EXBAG rebuild tablespace TS_REC_INDEX01;                         
alter index PK_EXCAD rebuild tablespace TS_REC_INDEX01;                         
alter index PK_FATAG rebuild tablespace TS_REC_INDEX03;                         
alter index PK_FATCOP rebuild tablespace TS_REC_INDEX01;                        
alter index PK_FATFRET rebuild tablespace TS_REC_INDEX01;                       
alter index PK_FCDOC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_FOFRL rebuild tablespace TS_REC_INDEX01;                         
alter index PK_FORES rebuild tablespace TS_REC_INDEX01;                         
alter index PK_FORIA rebuild tablespace TS_REC_INDEX01;                         
alter index PK_FTCNG rebuild tablespace TS_REC_INDEX01;                         
alter index PK_FVDR rebuild tablespace TS_REC_INDEX01;                          
alter index PK_GRCOM rebuild tablespace TS_REC_INDEX01;                         
alter index PK_HISDR rebuild tablespace TS_REC_INDEX01;                         
alter index PK_HSCPR rebuild tablespace TS_REC_INDEX02;                         
alter index PK_HSLAN rebuild tablespace TS_REC_INDEX01;                         
alter index PK_ICMUO rebuild tablespace TS_REC_INDEX01;                         
alter index PK_IMPA rebuild tablespace TS_REC_INDEX01;                          
alter index PK_IMPCID rebuild tablespace TS_REC_INDEX01;                        
alter index PK_IMPUF rebuild tablespace TS_REC_INDEX01;                         
alter index PK_IRRDR rebuild tablespace TS_REC_INDEX03;                         
alter index PK_ITFAT rebuild tablespace TS_REC_INDEX01;                         
alter index PK_ITGCO rebuild tablespace TS_REC_INDEX01;                         
alter index PK_ITREE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_LDRC rebuild tablespace TS_REC_INDEX01;                          
alter index PK_LIFA rebuild tablespace TS_REC_INDEX01;                          
alter index PK_MCO rebuild tablespace TS_REC_INDEX01;                           
alter index PK_MICUO rebuild tablespace TS_REC_INDEX01;                         
alter index PK_MIGR_BIL rebuild tablespace TS_REC_INDEX03;                      
alter index PK_MIGR_CRITICA rebuild tablespace TS_REC_INDEX03;                  
alter index PK_MIGR_PGTO rebuild tablespace TS_REC_INDEX03;                     
alter index PK_MIGR_TRECHO rebuild tablespace TS_REC_INDEX03;                   
alter index PK_MOREE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_MOVFRL rebuild tablespace TS_REC_INDEX03;                        
alter index PK_MOVFRL_ERRO rebuild tablespace TS_REC_INDEX05;                   
alter index PK_MTEAV rebuild tablespace TS_REC_INDEX01;                         
alter index PK_MTRA rebuild tablespace TS_REC_INDEX01;                          
alter index PK_MTRIP rebuild tablespace TS_REC_INDEX01;                         
alter index PK_MVPAS rebuild tablespace TS_REC_INDEX03;                         
alter index PK_MVPSPG rebuild tablespace TS_REC_INDEX03;                        
alter index PK_NOTCC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_OPFP rebuild tablespace TS_REC_INDEX01;                          
alter index PK_OPFRE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PAREC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PAXPTA rebuild tablespace TS_REC_INDEX01;                        
alter index PK_PAXRIP rebuild tablespace TS_REC_INDEX01;                        
alter index PK_PEFEC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PERFAT rebuild tablespace TS_REC_INDEX01;                        
alter index PK_PGAGE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGAVL rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGCCR rebuild tablespace TS_REC_INDEX06;                         
alter index PK_PGCLI rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGCON rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGDRE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGFIN rebuild tablespace TS_REC_INDEX03;                         
alter index PK_PGFRE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGLIV rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGMCO rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGPTA rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGRE rebuild tablespace TS_REC_INDEX01;                          
alter index PK_PGRIP rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PGSUB rebuild tablespace TS_REC_INDEX06;                         
alter index PK_PGVDS rebuild tablespace TS_REC_INDEX03;                         
alter index PK_PGVIS rebuild tablespace TS_REC_INDEX05;                         
alter index PK_PMREC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_PRCTB rebuild tablespace TS_REC_INDEX05;                         
alter index PK_PTA rebuild tablespace TS_REC_INDEX01;                           
alter index PK_RECFRL rebuild tablespace TS_REC_INDEX01;                        
alter index PK_RESCC rebuild tablespace TS_REC_INDEX03;                         
alter index PK_RGREE rebuild tablespace TS_REC_INDEX01;                         
alter index PK_RIP rebuild tablespace TS_REC_INDEX01;                           
alter index PK_RIPES rebuild tablespace TS_REC_INDEX01;                         
alter index PK_RNESF rebuild tablespace TS_REC_INDEX01;                         
alter index PK_SOCOF rebuild tablespace TS_REC_INDEX01;                         
alter index PK_SOLREE rebuild tablespace TS_REC_INDEX01;                        
alter index PK_TICOM rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TIFPG rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TIFRL rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TIFUN rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TIIRR rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TIMOV rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TIMP rebuild tablespace TS_REC_INDEX01;                          
alter index PK_TIPF rebuild tablespace TS_REC_INDEX01;                          
alter index PK_TIPFAT rebuild tablespace TS_REC_INDEX01;                        
alter index PK_TPAREC rebuild tablespace TS_REC_INDEX01;                        
alter index PK_TPDOC rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TPHIS rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TPIFAT rebuild tablespace TS_REC_INDEX01;                        
alter index PK_TPPER rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TPSRV rebuild tablespace TS_REC_INDEX01;                         
alter index PK_TRCCR_ADMCC rebuild tablespace TS_REC_INDEX01;                   
alter index PK_TRCEMI rebuild tablespace TS_REC_INDEX02;                        
alter index PK_TRELF rebuild tablespace TS_REC_INDEX06;                         
alter index PK_TRIP rebuild tablespace TS_REC_INDEX01;                          
alter index PK_TRPTA rebuild tablespace TS_REC_INDEX01;                         
alter index PK_VOADO rebuild tablespace TS_REC_INDEX03;                         
alter index PK_VOANVEN rebuild tablespace TS_REC_INDEX01;                       
alter index PK_VOCCNG rebuild tablespace TS_REC_INDEX06;                        
alter index PK_VOCUTI rebuild tablespace TS_REC_INDEX06;                        
alter index PK_WKAUCP rebuild tablespace TS_REC_INDEX02;                        
alter index PK_WKAUDC rebuild tablespace TS_REC_INDEX02;                        
alter index PK_WKCP rebuild tablespace TS_REC_INDEX01;                          
alter index PK_WKDOREC rebuild tablespace TS_REC_INDEX04;                       
alter index PK_WKFCON rebuild tablespace TS_REC_INDEX01;                        
alter index PK_WKICMS rebuild tablespace TS_REC_INDEX05;                        
alter index PK_WKPAX rebuild tablespace TS_REC_INDEX01;                         
alter index PK_WKTRE_PAX_PTA rebuild tablespace TS_REC_INDEX01;                 
alter index PK_WK_BASE rebuild tablespace TS_REC_INDEX01;                       
alter index PK_WK_BOLETO rebuild tablespace TS_REC_INDEX01;                     
alter index PK_WK_CONVITE rebuild tablespace TS_REC_INDEX03;                    
alter index PK_WK_CPFID rebuild tablespace TS_REC_INDEX01;                      
alter index PK_WK_FOREST rebuild tablespace TS_REC_INDEX01;                     
alter index PK_WK_PVFID rebuild tablespace TS_REC_INDEX03;                      
alter index PK_WK_REC rebuild tablespace TS_REC_INDEX01;                        
alter index PK_WK_SOLICIT rebuild tablespace TS_REC_INDEX01;                    
alter index PK_WK_VOADO rebuild tablespace TS_REC_INDEX01;                      
alter index UK_AVLAN_ALMAN1 rebuild tablespace TS_REC_INDEX03;                  
alter index UK_MVPAS_MPAUT1 rebuild tablespace TS_REC_INDEX03;                  
alter index UK_RIP_RIPA1 rebuild tablespace TS_REC_INDEX03;                     
alter index UK_RIP_RIPM1 rebuild tablespace TS_REC_INDEX03;                     
alter index UK_SOLREE_SLRAT1 rebuild tablespace TS_REC_INDEX03;                 
alter index UK_SOLREE_SLRMN1 rebuild tablespace TS_REC_INDEX03;                 
alter index WK_INDEX_DOC_RECEI rebuild tablespace TS_REC_INDEX03;               
alter index WK_PEND_FIDELIDADE rebuild tablespace TS_REC_INDEX01;               

**********************************************************************************************

ALTER TABLE TRECHO_VIAGEM_IRREGULAR
  DROP CONSTRAINT PK_TREIRR;

PROMPT Adding PRIMARY Constraint To TRECHO_VIAGEM_IRREGULAR Table

ALTER TABLE TRECHO_VIAGEM_IRREGULAR ADD (
      CONSTRAINT PK_TREIRR
      PRIMARY KEY (FK_TREVIFK_CD_VERSAO,
                   FK_TREVIFK_CD_NATURE,
                   FK_TREVIFK_CD_NUMERO,
                   FK_TREVIFK_DT_REALIZ,
                   FK_TREVIFK_AD_PESSOA,
                   FK_TREVIFK_AD_AEROP_ORIG,
                   FK_TREVIFK_AD_AEROP_DEST,
                   FK_CLASS_CL_ASSENTO)
USING INDEX 
PCTFREE  10
TABLESPACE TS_ETI_INDEX01
STORAGE  (
  INITIAL   5242880
  NEXT   524288
  MINEXTENTS  1
  MAXEXTENTS  121
  PCTINCREASE  0
  )
)
/

**********************************************************************************************


--col BLOCKING_OTHERS format a15
--col sid format 999999
--
--  select SESSION_ID sid
--        ,NAME
--        ,MODE_HELD
--        ,MODE_REQUESTED
--        ,BLOCKING_OTHERS        
--    from sys.dba_dml_locks
--order by session_id
/


--  select s.sid
--        ,s.serial#
--        ,p.spid       UNIX
--        ,s.username
--        ,s.osuser
--        ,substr(s.machine,1,15) machine 
--    from v$process p
--        ,v$session s
--   where s.paddr=p.addr
--order by 5



--  select r.name rollseg
--        ,s.username username
--        ,s.sid
--        ,s.serial#
--        ,p.spid UNIX
--        ,substr(s.machine,1,15) machine
--    from v$transaction t
--        ,v$rollname r
--        ,v$process p
--        ,v$session s
--   where t.addr   = s.taddr
--     and t.xidusn = r.usn
--     and s.paddr  = p.addr
--order by 1,2
/


-- coleta de estatisticas por sessao
--break on sid skip 1
--
--  select s.sid
--        ,z.osuser    "USUARIO REDE"
--        ,z.username  "USUARIO BANCO"
--        ,n.name
--        ,s.value
--    from v$statname n
--        ,v$sesstat s
--        ,v$session z
--   where z.sid       =s.sid
--     and n.statistic#=s.statistic#
--     and value>0
--     and class=64
--order by sid,name
/

--
-- # Assunto...: Consulta de lock´s no banco.                                #
--
--col object_name  format a30
--col schemaname   format a15
--col object_type  format a12
--
--  select a.sid
--        ,d.osuser
--        ,d.schemaname
--        ,a.type
--        ,c.object_type
--        ,a.id1
--        ,decode(a.lmode,1,NULL
--                       ,2,'ROW SHARE'
--                       ,3,'ROW EXCLUSIVE'
--                       ,4,'SHARE'
--                       ,5,'SHARE ROW EXCLUSIVE'
--                       ,6,'EXCLUSIVE','NONE') LMODE
--        ,decode(a.request,1,NULL
--                         ,2,'ROW SHARE'
--                         ,3,'ROW EXCLUSIVE'
--                         ,4,'SHARE'
--                         ,5,'SHARE ROW EXCLUSIVE'
--                         ,6,'EXCLUSIVE','NONE') LREQUEST
--        ,c.object_name
--    from v$lock a
--        ,dba_objects c
--        ,v$session d
--   where a.sid   =d.sid
--     and a.id1   =c.object_id(+)
--     and d.osuser is not null
--order by 1

grant all on ADM_CARTAO_CREDITO to systrcom;                                                       
grant all on AERONAVE to systrcom;                                                                 
grant all on AERONAVE_CABINE to systrcom;                                                          
grant all on AERONAVE_VERSAO_ASSENTO to systrcom;                                                  
grant all on AEROPORTO to systrcom;                                                                
grant all on AGENCIA_BANCARIA to systrcom;                                                         
grant all on AGENCIA_TURISMO to systrcom;                                                          
grant all on AGEN_TUR_EMP_AER to systrcom;                                                         
grant all on ANALISTA to systrcom;                                                                 
grant all on AREA to systrcom;                                                                     
grant all on ASSENTO_CLASSE_AERONAVE to systrcom;                                                  
grant all on BANCO to systrcom;                                                                    
grant all on BK_GRUPO_USUARIO_USUARIO to systrcom;                                                 
grant all on CABINE_AERONAVE to systrcom;                                                          
grant all on CAMBIO to systrcom;                                                                   
grant all on CARACTERISTICA_ASSENTO to systrcom;                                                   
grant all on CARACTERISTICA_ASS_VERSAO to systrcom;                                                
grant all on CARGO_EXTERNO to systrcom;                                                            
grant all on CATEGORIA_AEROPORTO to systrcom;                                                      
grant all on CG_FORM_HELP to systrcom;                                                             
grant all on CIDADE to systrcom;                                                                   
grant all on CLASSE_AERONAVE to systrcom;                                                          
grant all on CLASSE_ASSENTO to systrcom;                                                           
grant all on CLASSE_ASSENTO_OLD to systrcom;                                                       
grant all on CLASSIFICACAO_RECEITA to systrcom;                                                    
grant all on CLIENTE to systrcom;                                                                  
grant all on CLIENTE_EMPRESA_GRUPO to systrcom;                                                    
grant all on CLIENTE_TIPO_CLIENTE to systrcom;                                                     
grant all on CL_ASSENTO_CL_AERONAVE to systrcom;                                                   
grant all on CL_ASSENTO_CL_AERONAVE_OLD to systrcom;                                               
grant all on COMPLMTO_ENDERECO_PESSOA to systrcom;                                                 
grant all on COMPOSICAO_PAIS to systrcom;                                                          
grant all on CONTATO to systrcom;                                                                  
grant all on CONTATO_PESSOA to systrcom;                                                           
grant all on CONVERSAO_UNID_MEDIDA to systrcom;                                                    
grant all on CTA_CORRENTE_BANCARIA to systrcom;                                                    
grant all on CTA_LANCTO_CONTABIL to systrcom;                                                      
grant all on DADO_ADICIONAL_PESSOA to systrcom;                                                    
grant all on DEPART_EXTERNO to systrcom;                                                           
grant all on DIFERENCA to systrcom;                                                                
grant all on EMPRESA_AEREA to systrcom;                                                            
grant all on ENDERECO_FINALIDADE to systrcom;                                                      
grant all on ENDERECO_PFJ to systrcom;                                                             
grant all on ERRO_MENSAGEM to systrcom;                                                            
grant all on ERRO_MENSAGEMS to systrcom;                                                           
grant all on ESTAGIARIO to systrcom;                                                               
grant all on ESTAGIARIO_AEROPORTO to systrcom;                                                     
grant all on ESTAGIARIO_EMPRESA to systrcom;                                                       
grant all on ESTAGIARIO_FUNCAO to systrcom;                                                        
grant all on ESTAGIARIO_UNID_ORGZ to systrcom;                                                     
grant all on ETAPA to systrcom;                                                                    
grant all on EVT_CARRIER_CONFIGURATION to systrcom;                                                
grant all on EVT_DEST_PROFILE to systrcom;                                                         
grant all on EVT_HISTORY to systrcom;                                                              
grant all on EVT_INSTANCE to systrcom;                                                             
grant all on EVT_MAIL_CONFIGURATION to systrcom;                                                   
grant all on EVT_MONITOR_NODE to systrcom;                                                         
grant all on EVT_NOTIFY_STATUS to systrcom;                                                        
grant all on EVT_OPERATORS to systrcom;                                                            
grant all on EVT_OPERATORS_ADDITIONAL to systrcom;                                                 
grant all on EVT_OPERATORS_SYSTEMS to systrcom;                                                    
grant all on EVT_OUTSTANDING to systrcom;                                                          
grant all on EVT_PROFILE to systrcom;                                                              
grant all on EVT_PROFILE_EVENTS to systrcom;                                                       
grant all on EVT_REGISTRY to systrcom;                                                             
grant all on EVT_REGISTRY_BACKLOG to systrcom;                                                     
grant all on FILHO_PESSOA to systrcom;                                                             
grant all on FINALIDADE_ENDERECO to systrcom;                                                      
grant all on FORNECEDOR to systrcom;                                                               
grant all on FORNECEDOR_MOEDA to systrcom;                                                         
grant all on FORNEC_GRP_FORNECIMENTO to systrcom;                                                  
grant all on FORNEC_GRP_FORNEC_AEROP to systrcom;                                                  
grant all on FUNCAO to systrcom;                                                                   
grant all on FUNCIONARIO to systrcom;                                                              
grant all on FUNCIONARIO_AEROPORTO to systrcom;                                                    
grant all on FUNCIONARIO_EMPRESA to systrcom;                                                      
grant all on FUNCIONARIO_FUNCAO to systrcom;                                                       
grant all on FUNCIONARIO_UNID_ORGZ to systrcom;                                                    
grant all on FUNC_AEROP to systrcom;                                                               
grant all on GENERO_PREFERENCIA to systrcom;                                                       
grant all on GRP_CARACTERISTICA_ASSENTO to systrcom;                                               
grant all on GRUPO_EMPRESARIAL to systrcom;                                                        
grant all on GRUPO_FORNECIMENTO to systrcom;                                                       
grant all on GRUPO_USUARIO to systrcom;                                                            
grant all on GRUPO_USUARIO_PROGRAMA to systrcom;                                                   
grant all on GRUPO_USUARIO_USUARIO to systrcom;                                                    
grant all on HIST_SITUACAO_CLIENTE to systrcom;                                                    
grant all on HORA_TRABALHADA to systrcom;                                                          
grant all on INDICE_ECONOMICO to systrcom;                                                         
grant all on INDICE_ECONOM_FATOR to systrcom;                                                      
grant all on JATOSEXE to systrcom;                                                                 
grant all on META to systrcom;                                                                     
grant all on META_EMPRESA_AEREA to systrcom;                                                       
grant all on META_UNID_OPERACIONAL to systrcom;                                                    
grant all on MODELO_CLASSE_AERONAVE to systrcom;                                                   
grant all on MOEDA to systrcom;                                                                    
grant all on MOEDA_CAMBIO to systrcom;                                                             
grant all on MOEDA_COTACAO to systrcom;                                                            
grant all on MOEDA_PAIS to systrcom;                                                               
grant all on NACIONALIDADE_PESSOA to systrcom;                                                     
grant all on PAIS to systrcom;                                                                     
grant all on PESSOA to systrcom;                                                                   
grant all on PESSOA_RAMO_ATIVIDADE to systrcom;                                                    
grant all on PONTO_VENDA to systrcom;                                                              
grant all on PREFERENCIA_NIVEL_DOIS to systrcom;                                                   
grant all on PREFERENCIA_NIVEL_UM to systrcom;                                                     
grant all on PREFERENCIA_PESSOA to systrcom;                                                       
grant all on PROGRAMA to systrcom;                                                                 
grant all on PRONOME_TRATAMENTO to systrcom;                                                       
grant all on QUOTA_PESQUISA to systrcom;                                                           
grant all on RAMO_ATIVIDADE to systrcom;                                                           
grant all on RECURSO_AEROPORTO to systrcom;                                                        
grant all on RECURSO_EMPRESA to systrcom;                                                          
grant all on RECURSO_EXTERNO to systrcom;                                                          
grant all on RECURSO_FORNECEDOR to systrcom;                                                       
grant all on RECURSO_FUNCAO to systrcom;                                                           
grant all on RECURSO_UNID_ORGZ to systrcom;                                                        
grant all on REPRESENTANTE to systrcom;                                                            
grant all on REPRESENTANTE_EMP_AER to systrcom;                                                    
grant all on REPRES_AEROPORTO to systrcom;                                                         
grant all on REPRES_EMP_AER_AEROP to systrcom;                                                     
grant all on SEGTO_OPERACAO to systrcom;                                                           
grant all on SEGTO_OPERA_EMP_AEREA to systrcom;                                                    
grant all on SINDICATO to systrcom;                                                                
grant all on SISTEMA to systrcom;                                                                  
grant all on SITUACAO_CLIENTE to systrcom;                                                         
grant all on SMACTUALPARAMETER_S to systrcom;                                                      
grant all on SMAGENTJOB_S to systrcom;                                                             
grant all on SMARCHIVE_S to systrcom;                                                              
grant all on SMBREAKABLELINKS to systrcom;                                                         
grant all on SMCLIQUE to systrcom;                                                                 
grant all on SMCONFIGURATION to systrcom;                                                          
grant all on SMCONSOLESOSETTING_S to systrcom;                                                     
grant all on SMDATABASE_S to systrcom;                                                             
grant all on SMDBAUTH_S to systrcom;                                                               
grant all on SMDEFAUTH_S to systrcom;                                                              
grant all on SMDEPENDENTLINKS to systrcom;                                                         
grant all on SMDISTRIBUTIONSET_S to systrcom;                                                      
grant all on SMFOLDER_S to systrcom;                                                               
grant all on SMFORMALPARAMETER_S to systrcom;                                                      
grant all on SMGLOBALCONFIGURATION_S to systrcom;                                                  
grant all on SMHOSTAUTH_S to systrcom;                                                             
grant all on SMHOST_S to systrcom;                                                                 
grant all on SMINSTALLATION_S to systrcom;                                                         
grant all on SMLOGMESSAGE_S to systrcom;                                                           
grant all on SMMONTHLYENTRY_S to systrcom;                                                         
grant all on SMMONTHWEEKENTRY_S to systrcom;                                                       
grant all on SMMOWNERLINKS to systrcom;                                                            
grant all on SMOMSTRING_S to systrcom;                                                             
grant all on SMOSNAMES_X to systrcom;                                                              
grant all on SMOWNERLINKS to systrcom;                                                             
grant all on SMPACKAGE_S to systrcom;                                                              
grant all on SMPARALLELJOB_S to systrcom;                                                          
grant all on SMPARALLELOPERATION_S to systrcom;                                                    
grant all on SMPARALLELSTATEMENT_S to systrcom;                                                    
grant all on SMPRODUCTATTRIBUTE_S to systrcom;                                                     
grant all on SMPRODUCT_S to systrcom;                                                              
grant all on SMP_AD_ADDRESSES_ to systrcom;                                                        
grant all on SMP_AD_DISCOVERED_NODES_ to systrcom;                                                 
grant all on SMP_AD_NODES_ to systrcom;                                                            
grant all on SMP_AD_PARMS_ to systrcom;                                                            
grant all on SMP_AUTO_DISCOVERY_ITEM_ to systrcom;                                                 
grant all on SMP_AUTO_DISCOVERY_PARMS_ to systrcom;                                                
grant all on SMP_BLOB_ to systrcom;                                                                
grant all on SMP_BRM_ACTIVE_JOB_ to systrcom;                                                      
grant all on SMP_BRM_CHANNEL_DEVICE_ to systrcom;                                                  
grant all on SMP_BRM_DEFAULT_CHANNEL_ to systrcom;                                                 
grant all on SMP_BRM_RC_CONNECT_STRING_ to systrcom;                                               
grant all on SMP_BRM_SAVED_JOB_ to systrcom;                                                       
grant all on SMP_BRM_TEMP_SCRIPTS_ to systrcom;                                                    
grant all on SMP_CREDENTIALS$ to systrcom;                                                         
grant all on SMP_EBU_ACTIVE_JOB_ to systrcom;                                                      
grant all on SMP_EBU_SAVED_JOB_ to systrcom;                                                       
grant all on SMP_JOB_ to systrcom;                                                                 
grant all on SMP_JOB_EVENTLIST_ to systrcom;                                                       
grant all on SMP_JOB_HISTORY_ to systrcom;                                                         
grant all on SMP_JOB_INSTANCE_ to systrcom;                                                        
grant all on SMP_JOB_LIBRARY_ to systrcom;                                                         
grant all on SMP_JOB_TASK_INSTANCE_ to systrcom;                                                   
grant all on SMP_LONG_TEXT_ to systrcom;                                                           
grant all on SMP_REP_VERSION to systrcom;                                                          
grant all on SMP_SERVICES to systrcom;                                                             
grant all on SMP_SERVICE_DATA_ to systrcom;                                                        
grant all on SMP_SERVICE_GROUP_DEFN_ to systrcom;                                                  
grant all on SMP_SERVICE_GROUP_ITEM_ to systrcom;                                                  
grant all on SMP_SERVICE_ITEM_ to systrcom;                                                        
grant all on SMP_UPDATESERVICES_CALLED_ to systrcom;                                               
grant all on SMP_USER_DETAILS to systrcom;                                                         
grant all on SMP_VAB_ACTIVE_JOB_ to systrcom;                                                      
grant all on SMP_VAB_SAVED_JOB_ to systrcom;                                                       
grant all on SMRELEASE_S to systrcom;                                                              
grant all on SMRUN_S to systrcom;                                                                  
grant all on SMSCHEDULE_S to systrcom;                                                             
grant all on SMSHAREDORACLECLIENT_S to systrcom;                                                   
grant all on SMSHAREDORACLECONFIGURATION_S to systrcom;                                            
grant all on SMTABLESPACE_S to systrcom;                                                           
grant all on SMVCENDPOINT_S to systrcom;                                                           
grant all on SMWEEKLYENTRY_S to systrcom;                                                          
grant all on SUB_AEREA to systrcom;                                                                
grant all on SUB_REGIAO to systrcom;                                                               
grant all on TIPO_CLIENTE to systrcom;                                                             
grant all on TIPO_CONTATO to systrcom;                                                             
grant all on TIPO_DADO_ADICIONAL to systrcom;                                                      
grant all on TIPO_PREFERENCIA to systrcom;                                                         
grant all on TIPO_UNIDADE to systrcom;                                                             
grant all on TITULO_PESSOA to systrcom;                                                            
grant all on UF to systrcom;                                                                       
grant all on UND_OPER_CLASSIF_RECEI to systrcom;                                                   
grant all on UNIDADE_MEDIDA to systrcom;                                                           
grant all on UNIDADE_OPERACIONAL to systrcom;                                                      
grant all on UNIDADE_ORGANIZACIONAL to systrcom;                                                   
grant all on USUARIO to systrcom;                                                                  
grant all on USUARIO_AEROPORTO to systrcom;                                                        
grant all on USUARIO_CIDADE to systrcom;                                                           
grant all on USUARIO_EMPRESA_AEREA to systrcom;                                                    
grant all on VER_ASS_CABINE to systrcom;                                                           
grant all on VER_ASS_CLA_AERONAVE to systrcom;                                                     
grant all on VER_ASS_CLA_AERONAVE_DETL to systrcom;                                                
grant all on VER_ASS_CLA_ASSENTO to systrcom;                                                      
grant all on WK_AEROPORTO to systrcom;                                                             
grant all on WK_ETAPA to systrcom;                                                                 


create snapshot log on natureza_linha;
create snapshot log on tempo_conexao_pax;
create snapshot log on voo_planejado;


                                                                                
alter tablespace TS_COR_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_COR_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_ETI_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_ETI_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_PLN_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_SBD_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_TAR_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_TAR_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_DADOS02 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_DADOS03 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_DADOS04 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_DADOS05 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_SBD_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_UNF_DADOS default storage                                   
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_UNF_INDEX default storage                                   
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_DADOS06 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_INDEX05 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_INDEX02 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_INDEX06 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_PLN_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_INDEX03 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_REC_INDEX04 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_CMB_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_CMB_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_SECPRESS default storage                                    
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_SECPRESS_IND default storage                                
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace CCT_DADOS default storage                                      
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace CCT_INDEX default storage                                      
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_ETI_DADOS02 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_ETI_DADOS03 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_ETI_INDEX02 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_ETI_INDEX03 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_TRE_DADOS01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
alter tablespace TS_TRE_INDEX01 default storage                                 
(initial 20480 next 20480);                                                     
                                                                                
**********************************************************************************
                                                                                
prompt IND_ITIACM_1                                                             
analyze index IND_ITIACM_1 validate structure;                                   
select del_lf_rows from index_stats;                                            
                                                                                
prompt IND_ITIACM_2                                                             
analyze index IND_ITIACM_2 validate structure;                                   
select del_lf_rows from index_stats;                                            
                                                                                
prompt IND_ITIDIA_1                                                             
analyze index IND_ITIDIA_1 validate structure;                                   
select del_lf_rows from index_stats;                                            
                                                                                
prompt IND_ITODAC_1                                                             
analyze index IND_ITODAC_1 validate structure;                                   
select del_lf_rows from index_stats;                                            


********************************************

alter tablespace RBS end backup;                                                
alter tablespace SYSTEM end backup;                                             
alter tablespace TEMP end backup;                                               
alter tablespace TOOLS end backup;                                              
alter tablespace TS_CMB_DADOS01 end backup;                                     
alter tablespace TS_CMB_INDEX01 end backup;                                     
alter tablespace TS_COR_DADOS01 end backup;                                     
alter tablespace TS_COR_INDEX01 end backup;                                     
alter tablespace TS_ETI_DADOS01 end backup;                                     
alter tablespace TS_ETI_INDEX01 end backup;                                     
alter tablespace TS_PLN_DADOS01 end backup;                                     
alter tablespace TS_PLN_INDEX01 end backup;                                     
alter tablespace TS_REC_DADOS01 end backup;                                     
alter tablespace TS_REC_DADOS02 end backup;                                     
alter tablespace TS_REC_DADOS03 end backup;                                     
alter tablespace TS_REC_DADOS04 end backup;                                     
alter tablespace TS_REC_DADOS05 end backup;                                     
alter tablespace TS_REC_DADOS06 end backup;                                     
alter tablespace TS_REC_INDEX01 end backup;                                     
alter tablespace TS_REC_INDEX02 end backup;                                     
alter tablespace TS_REC_INDEX03 end backup;                                     
alter tablespace TS_REC_INDEX04 end backup;                                     
alter tablespace TS_REC_INDEX05 end backup;                                     
alter tablespace TS_REC_INDEX06 end backup;                                     
alter tablespace TS_SBD_DADOS01 end backup;                                     
alter tablespace TS_SBD_INDEX01 end backup;                                     
alter tablespace TS_TAR_DADOS01 end backup;                                     
alter tablespace TS_TAR_INDEX01 end backup;                                     
alter tablespace TS_UNF_DADOS end backup;                                       
alter tablespace TS_UNF_INDEX end backup;                                       
alter tablespace USERS end backup;                                              

31 rows selected.


alter database recover logfile '/producao/arch2/lf_T0001S0000055208.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057054.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057055.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057056.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057057.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057058.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057059.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057060.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057061.arc';
alter database recover logfile '/producao/arch2/lf_T0001S0000057062.arc';

set feed off
set pagesize 0
set termout off
spool compile_.sql
select 'set termout on' from dual;
select 'set echo on' from dual;
select 'alter ' || Rtrim(object_type) || ' ' || rtrim(object_name) ||
       ' compile;'
From user_objects
Where status = 'INVALID' and object_type not in ('PACKAGE BODY')
;
select 'alter package ' ||  rtrim(object_name) ||
       ' compile body;'
From user_objects
Where status = 'INVALID' and object_type in ('PACKAGE BODY')
;
select 'alter trigger ' || rtrim(trigger_name) ||
       ' enable;'
From user_triggers
Where status = 'DISABLED'
;
select 'alter table ' || rtrim(table_name) ||
       ' enable constraint '|| rtrim(constraint_name)||';'
From user_constraints
Where status = 'DISABLED' and constraint_type = 'R'
;
spool off
@compile_
set echo off
set termout off
host rm compile_.sql
set feed on




