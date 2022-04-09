CREATE OR REPLACE TRIGGER SEU.TRG_SEUAAP_DEP_I BEFORE
INSERT ON SEU.SEUAAP REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW
WHEN (new.saap_tpcurso='02' or new.saap_tpcurso='04') 
BEGIN
	IF :new.SAAP_TPCURSO = '02' THEN -- DEPENDÊNCIA
   insert into seuaay  (saay_idempresa, saay_codcur, saay_versao, saay_serie, saay_coddis, saay_tpnota, saay_partamg, saay_tpgrade, saay_tpcurso, saay_partbloq, saay_modalidade, saay_idusuario, saay_ativcomp, saay_conceito, saay_obrigacc)
   values(:new.saap_idempresa,	'999998', '001','01','999999','4','N','002','01','N','01',:new.saap_idusuario,'N','N','N');
  END IF;
	IF :new.SAAP_TPCURSO = '04' THEN  -- DEPENDÊNCIA EAD
   insert into seuaay  (saay_idempresa, saay_codcur, saay_versao, saay_serie, saay_coddis, saay_tpnota, saay_partamg, saay_tpgrade, saay_tpcurso, saay_partbloq, saay_modalidade, saay_idusuario, saay_ativcomp, saay_conceito, saay_obrigacc)
   values(:new.saap_idempresa,	'999998', '001','01','999999','4','N','002','01','N','03',:new.saap_idusuario,'N','N','N');
  END IF; 
END;
/

