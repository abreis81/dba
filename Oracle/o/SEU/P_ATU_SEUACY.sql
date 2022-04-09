CREATE OR REPLACE PROCEDURE SEU.P_ATU_SEUACY (EMP in varchar2, RA in varchar2)
IS
       GERX    VARCHAR2(20);
       ANOLET  VARCHAR2(4);
       PERIODO VARCHAR2(2);
Begin


     IF EMP = '1' THEN

        DECLARE

               CURSOR C1 IS SELECT *
                              FROM SIGA.SE1010,
                                   (SELECT SAET_NUMRA, SACV_NRPARC, SAET_ANO, SACV_MESINI, SACV_ANOLET, SACV_PERIODO
                                      FROM SEU.SEUAET,
                                           SEU.SEUACV
                                     WHERE SAET_IDEMPRESA = 1
                                       AND SAET_IDEMPRESA = SACV_IDEMPRESA
                                       AND SAET_CURSO     = SACV_CODCUR
                                       AND SAET_ANO       = SACV_ANOLET
                                       AND SAET_SEMESTR   = SACV_PERIODO
                                       AND SAET_UNIDADE   = SACV_CODUND
                                       AND SAET_SERIE     = SACV_SERIE
                                       AND SAET_TURNO     = SACV_TURNO
                                       AND SAET_NUMRA     = RA )
                             WHERE E1_FILIAL (+)= '  '
                               AND RPAD(SAET_NUMRA, 15, ' ') = E1_NUMRA(+)
                               AND CASE WHEN SACV_NRPARC > 9 THEN CHR(SACV_NRPARC + 55 ) ELSE TO_CHAR(SACV_NRPARC) END      = E1_PARCELA (+)
                               AND SAET_ANO               = SUBSTR(E1_VENCTO(+), 1, 4)
                               AND SACV_NRPARC <> '1'
                               AND E1_PREFIXO(+) = 'MES'
                               AND CASE
                                        WHEN LPAD(SACV_MESINI, 2, '0') >= '01'
                                         AND LPAD(SACV_MESINI, 2, '0') <= '06'
                                   THEN '01'
                                   ELSE '02'
                                    END                                        = CASE
                                                                                      WHEN SUBSTR(E1_VENCTO(+), 5, 2) >= '01'
                                                                                       AND SUBSTR(E1_VENCTO(+), 5, 2) <= '06'
                                                                                 THEN '01'
                                                                                 ELSE '02'
                                                                                 END
                               AND D_E_L_E_T_ (+) = ' '
                             ORDER BY SACV_NRPARC;


                BEGIN

                       FOR RC1 IN C1 LOOP

                           IF TRIM(RC1.E1_PARCELA)  IS NULL THEN
                              GERX := GERX || ' ';
                           ELSE
                              GERX := GERX || 'X';
                           END IF;

                           ANOLET  := RC1.SACV_ANOLET;
                           PERIODO := RC1.SACV_PERIODO;

                       END LOOP;
                END;


    ELSE

        DECLARE

               CURSOR C1 IS SELECT *
                              FROM SIGA.SE1010,
                                   (SELECT SABO_CODCUR, SABO_SERIE, SABO_NUMRA, SACV_NRPARC, SACV_ANOLET, SACV_PERIODO, SACV_MESINI
                                      FROM SEU.SEUABO,
                                           SEU.SEUACV
                                     WHERE SABO_IDEMPRESA = EMP
                                       AND SABO_IDEMPRESA = SACV_IDEMPRESA
                                       AND SABO_CODCUR    = SACV_CODCUR
                                       AND SABO_ANOLET    = SACV_ANOLET
                                       AND SABO_PERIODO   = SACV_PERIODO
                                       AND SABO_CODUND    = SACV_CODUND
                                       AND SABO_SERIE     = SACV_SERIE
                                       AND SABO_TURNO     = SACV_TURNO
                                       AND SACV_QTDPARC   = SABO_QTDPARC
                                       AND SABO_ATIVO     = 'S'
                                       AND SACV_NRPARC    <> '1'
                                       AND SABO_NUMRA     = RA )
                             WHERE E1_FILIAL (+)= '  '
                               AND E1_PREFIXO(+) = 'MES'
                               AND RPAD(SABO_NUMRA, 15, ' ') = E1_NUMRA(+)
                               AND CASE WHEN SACV_NRPARC > 9 THEN CHR(SACV_NRPARC + 55 ) ELSE TO_CHAR(SACV_NRPARC) END      = E1_PARCELA (+)
                               AND D_E_L_E_T_ (+) = ' '
                               AND SABO_CODCUR || SABO_SERIE = TRIM(E1_NRDOC(+))
                             ORDER BY SACV_NRPARC;


                BEGIN

                       FOR RC2 IN C1 LOOP

                           IF TRIM(RC2.E1_PARCELA)  IS NULL THEN
                              GERX := GERX || ' ';
                           ELSE
                              GERX := GERX || 'X';
                           END IF;

                           ANOLET  := RC2.SACV_ANOLET;
                           PERIODO := RC2.SACV_PERIODO;

                       END LOOP;
                END;

    END IF;

        UPDATE SEU.SEUACY
           SET SACY_NPARC  = 'X' || GERX
         WHERE SACY_NUMRA  = RA
           AND SACY_ANOLET = ANOLET
           AND SACY_PERIODO = PERIODO;


        COMMIT;

End;
/