CREATE SEQUENCE "SEU"."SEQ_SEUADL_PROCESSO_VM" NOCYCLE NOORDER NOCACHE MAXVALUE 99999999 MINVALUE 0 INCREMENT BY 1 START WITH 1 ;
CREATE SEQUENCE "SEU"."SEQ_SEUADL_PROCESSO_MM" NOCYCLE NOORDER NOCACHE MAXVALUE 99999999 MINVALUE 0 INCREMENT BY 1 START WITH 1 ;
CREATE SEQUENCE "SEU"."SEQ_SEUADL_PROCESSO_VG" NOCYCLE NOORDER NOCACHE MAXVALUE 99999999 MINVALUE 0 INCREMENT BY 1 START WITH 1 ;

GRANT SELECT ON "SEU"."SEQ_SEUADL_PROCESSO_VM" TO R_SEU_ALL;
GRANT SELECT ON "SEU"."SEQ_SEUADL_PROCESSO_MM" TO R_SEU_ALL;
GRANT SELECT ON "SEU"."SEQ_SEUADL_PROCESSO_VG" TO R_SEU_ALL;