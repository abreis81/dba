CREATE OR REPLACE Procedure SEU.P_CLIENTE_UND is
BEGIN

  UPDATE SEU.SEUAET
     SET SAET_UNIDADE = (SELECT CASE TRIM(SAET_UNIDADE)
                                 WHEN '01' THEN '000135'
                                 WHEN '02' THEN '000136'
                                 WHEN '04' THEN '000131'
                                 WHEN '09' THEN '000132'
                                 WHEN '11' THEN '000133'
                                 WHEN '14' THEN '000134'
                                 WHEN '15' THEN '000137'
                                 WHEN '16' THEN '000138'
                                 WHEN '17' THEN '000139'
                                 WHEN '18' THEN '000140'
                                 WHEN '19' THEN '000141'
                                 WHEN '20' THEN '000142'
                                 WHEN '21' THEN '000143'
                             END
                            FROM DUAL )
     WHERE SAET_IDEMPRESA = 1
     AND LENGTH(TRIM(SAET_UNIDADE)) = 2;

    UPDATE SEU.SEUAET
       SET SAET_CURSO = TRIM(SAET_CURSO),
           SAET_RG    = TRIM(SAET_RG),
           SAET_EMAIL = TRIM(SAET_EMAIL),
           SAET_PAI   = TRIM(SAET_PAI),
           SAET_MAE   = TRIM(SAET_MAE);

     COMMIT;
END;