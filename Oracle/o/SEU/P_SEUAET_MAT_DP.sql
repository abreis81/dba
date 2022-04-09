CREATE OR REPLACE PROCEDURE SEU."P_SEUAET_MAT_DP"(IDEMPRESA IN NUMBER,
                                                  NUMRA     IN VARCHAR2) IS

BEGIN

  IF NUMRA IS NULL THEN

    FOR C1 IN (SELECT *
                 FROM SEU.SEUAET
                WHERE SAET_ANO = '2007'
                  AND SAET_SEMESTR IN ('C1', 'B1', '02', '03')
                  AND SAET_SITUAC IN ('001', '999')) LOOP

      UPDATE SEU.SEUAET
         SET SAET_QTDDP = (SELECT COUNT(*)
                             FROM "Nota Frequencia"@PRESEU_R
                            WHERE "aass" in ('20072', '20078')
                              AND "sit" in ('D', 'A')
                              AND "al_codigo" = SAET_NUMRA
                              AND "al_codigo" = C1.SAET_NUMRA)
       WHERE SAET_NUMRA = C1.SAET_NUMRA;

      UPDATE SEU.SEUAET
         SET SAET_QTDMAT = (SELECT COUNT(*)
                              FROM "Nota Frequencia"@PRESEU_R
                             WHERE "aass" in ('20072')
                               AND "sit" in ('M')
                               AND "al_codigo" = SAET_NUMRA
                               AND "al_codigo" = C1.SAET_NUMRA)
       WHERE SAET_NUMRA = C1.SAET_NUMRA;

      UPDATE SEU.SEUAET
         SET SAET_QTDDP = (SELECT COUNT(*) + NVL(SAET_QTDDP, 0)
                             FROM SEU.SEUABO, SEU.SEUABU
                            WHERE SABO_ATIVO = 'S'
                              AND SABO_IDEMPRESA = C1.SAET_IDEMPRESA
                              AND SABO_IDEMPRESA = SABU_IDEMPRESA
                              AND SABO_NUMRA = SABU_NUMRA
                              AND SABO_CODCUR = SABU_CODCUR
                              AND SABO_VERSAO = SABU_VERSAO
                              AND SABO_ANOLET = SABU_ANOLET
                              AND SABO_PERIODO = SABU_PERIODO
                              AND SABU_REGIME IN ('001', '002', '009')
                              AND SABU_SITDIS NOT IN ('007', '008', '009')
                              AND SABO_NUMRA = C1.SAET_NUMRA
                              AND SABO_NUMRA = SAET_NUMRA)
       WHERE SAET_NUMRA = C1.SAET_NUMRA;

      UPDATE SEU.SEUAET
         SET SAET_QTDMAT = (SELECT COUNT(*) + NVL(SAET_QTDMAT, 0)
                              FROM SEU.SEUABO, SEU.SEUABU
                             WHERE SABO_ATIVO = 'S'
                               AND SABO_IDEMPRESA = C1.SAET_IDEMPRESA
                               AND SABO_IDEMPRESA = SABU_IDEMPRESA
                               AND SABO_NUMRA = SABU_NUMRA
                               AND SABO_CODCUR = SABU_CODCUR
                               AND SABO_VERSAO = SABU_VERSAO
                               AND SABO_ANOLET = SABU_ANOLET
                               AND SABO_PERIODO = SABU_PERIODO
                               AND SABU_REGIME = '007'
                               AND SABU_SITDIS NOT IN ('007', '008', '009')
                               AND SABO_NUMRA = C1.SAET_NUMRA
                               AND SABO_NUMRA = SAET_NUMRA)
       WHERE SAET_NUMRA = C1.SAET_NUMRA;

      COMMIT;
    END LOOP;

  ELSE

    UPDATE SEU.SEUAET
       SET SAET_QTDDP = (SELECT COUNT(*)
                           FROM "Nota Frequencia"@PRESEU_R
                          WHERE "aass" in ('20072', '20078')
                            AND "sit" in ('D', 'A')
                            AND "al_codigo" = SAET_NUMRA
                            AND "al_codigo" = NUMRA)
     WHERE SAET_NUMRA = NUMRA;

    UPDATE SEU.SEUAET
       SET SAET_QTDMAT = (SELECT COUNT(*)
                            FROM "Nota Frequencia"@PRESEU_R
                           WHERE "aass" in ('20072')
                             AND "sit" in ('M')
                             AND "al_codigo" = SAET_NUMRA
                             AND "al_codigo" = NUMRA)
     WHERE SAET_NUMRA = NUMRA;

    UPDATE SEU.SEUAET
       SET SAET_QTDDP = (SELECT COUNT(*) + NVL(SAET_QTDDP, 0)
                           FROM SEU.SEUABO, SEU.SEUABU
                          WHERE SABO_ATIVO = 'S'
                            AND SABO_IDEMPRESA = IDEMPRESA
                            AND SABO_IDEMPRESA = SABU_IDEMPRESA
                            AND SABO_NUMRA = SABU_NUMRA
                            AND SABO_CODCUR = SABU_CODCUR
                            AND SABO_VERSAO = SABU_VERSAO
                            AND SABO_ANOLET = SABU_ANOLET
                            AND SABO_PERIODO = SABU_PERIODO
                            AND SABU_REGIME IN ('001', '002', '009')
                            AND SABU_SITDIS NOT IN ('007', '008', '009')
                            AND SABO_NUMRA = NUMRA
                            AND SABO_NUMRA = SAET_NUMRA)
     WHERE SAET_NUMRA = NUMRA;

    UPDATE SEU.SEUAET
       SET SAET_QTDMAT = (SELECT COUNT(*) + NVL(SAET_QTDMAT, 0)
                            FROM SEU.SEUABO, SEU.SEUABU
                           WHERE SABO_ATIVO = 'S'
                             AND SABO_IDEMPRESA = IDEMPRESA
                             AND SABO_IDEMPRESA = SABU_IDEMPRESA
                             AND SABO_NUMRA = SABU_NUMRA
                             AND SABO_CODCUR = SABU_CODCUR
                             AND SABO_VERSAO = SABU_VERSAO
                             AND SABO_ANOLET = SABU_ANOLET
                             AND SABO_PERIODO = SABU_PERIODO
                             AND SABU_REGIME = '007'
                             AND SABU_SITDIS NOT IN ('007', '008', '009')
                             AND SABO_NUMRA = NUMRA
                             AND SABO_NUMRA = SAET_NUMRA)
     WHERE SAET_NUMRA = NUMRA;

    COMMIT;

  END IF;

END;
/