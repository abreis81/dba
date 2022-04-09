CREATE OR REPLACE Procedure SEU.P_ATUALIZA_CLIENTE is
BEGIN




      DECLARE

             CURSOR C1 IS SELECT *
                            FROM "yAluno2"@PRESEU_CLIENTE
                           WHERE rownum <= (SELECT COUNT(*) FROM "yAluno2"@PRESEU_CLIENTE )
                           ORDER BY "log_data";

      BEGIN

             FOR RC1 IN C1 LOOP

                 IF RC1."log_tipo" = 'I' THEN
                    dbms_output.put_line('I');

                    DELETE
                      FROM SEU.SEUAET
                     WHERE SAET_NUMRA = RC1."codigo";


                    INSERT INTO SEU.SEUAET (SAET_IDEMPRESA, SAET_NUMRA, SAET_NOME, SAET_RG, SAET_DTNASC,
                                            SAET_CPF, SAET_DTMAT, SAET_ANO, SAET_UNIDADE, SAET_CURSO,
                                            SAET_SEMESTR, SAET_SERIE, SAET_TURMA, SAET_TURNO, SAET_BOLSA,
                                            SAET_JUIZO, SAET_SITUAC, SAET_END, SAET_MUN,
                                            SAET_EST, SAET_BAIRRO, SAET_CEP, SAET_TEL,
                                            SAET_FAX, SAET_EMAIL, SAET_CLIENTE, SAET_PAIS,
                                            SAET_SEXO, SAET_PAI, SAET_MAE, SAET_INIJUIZ, SAET_FIMJUIZ,
                                            SAET_IDUSUARIO, SAET_NREG, SAET_NUM, SAET_COMPL)
                                    VALUES  (1,
                                             RC1."codigo",
                                             RC1."nome",
                                             '',
                                             TO_CHAR(RC1."dtnasc",'YYYYMMDD'),
                                             RC1."CPF",
                                             TO_CHAR(RC1."dtmat",'YYYYMMDD'),
                                             Substr(RC1."aass", 1,4),
                                             TRIM(RC1."es_codigo"),
                                             TRIM(RC1."cr_codigo"),
                                             CASE
                                                 WHEN Substr(TRIM(RC1."aass"), 5,1) NOT  BETWEEN 'A' AND 'Z' THEN '0' || Substr(TRIM(RC1."aass"), 5,1)
                                                 ELSE Substr(TRIM(RC1."aass"), 5,1)
                                             END,
                                             RC1."serie",
                                             Substr(RC1."turma", 1,1),
                                             CASE WHEN Substr(RC1."turma", 2,1) = '1'   THEN '001'  WHEN Substr(RC1."turma", 2,1) = '2'   THEN '003' WHEN Substr(RC1."turma", 2,1) = '3'   THEN '002'  END,
                                             '',
                                             '',
                                             CASE WHEN RC1."sit" = 'M'   THEN '001' WHEN RC1."sit" = 'R'   THEN '002' WHEN RC1."sit" = 'T'   THEN '003' WHEN RC1."sit" = 'F'   THEN '004' WHEN RC1."sit" = 'C'   THEN '005' WHEN RC1."sit" = 'Des' THEN '006' WHEN RC1."sit" = 'O'   THEN '007' WHEN RC1."sit" = 'Dep' THEN '999' END,
                                             RC1."local1",
                                             RC1."cidade",
                                             RC1."estado",
                                             RC1."bairro",
                                             RC1."CEP",
                                             RC1."fone",
                                             '',
                                             '',
                                             '000000',
                                             '',
                                             RC1."sexo",
                                             '',
                                             '',
                                             '',
                                             '',
                                             1,
                                             0,
                                             '',
                                             '');

                    UPDATE SEU.SEUAET
                       SET SAET_EMAIL = (SELECT "email"
                                           FROM  "alunopass"@PRESEU_CLIENTE
                                          WHERE "codigo" = RC1."codigo"
                                            AND SAET_NUMRA = "codigo")
                     WHERE SAET_IDEMPRESA = 1
                       AND SAET_NUMRA = RC1."codigo";

                 END IF;


                 IF RC1."log_tipo" = 'U' THEN

                    UPDATE SEU.SEUAET
                       SET SAET_NUMRA     = RC1."codigo",
                           SAET_NOME      = RC1."nome",
                           SAET_DTNASC    = TO_CHAR(RC1."dtnasc",'YYYYMMDD'),
                           SAET_CPF       = RC1."CPF",
                           SAET_DTMAT     = TO_CHAR(RC1."dtmat",'YYYYMMDD'),
                           SAET_ANO       = Substr(RC1."aass", 1,4),
                           SAET_UNIDADE   = TRIM(RC1."es_codigo"),
                           SAET_CURSO     = TRIM(RC1."cr_codigo"),
                           SAET_SEMESTR   = CASE
                                                 WHEN Substr(TRIM(RC1."aass"), 5,1) NOT  BETWEEN 'A' AND 'Z' THEN '0' || Substr(TRIM(RC1."aass"), 5,1)
                                                 ELSE Substr(TRIM(RC1."aass"), 5,1)
                                             END,
                           SAET_SERIE     = RC1."serie",
                           SAET_TURMA     = Substr(RC1."turma", 1,1),
                           SAET_TURNO     = CASE WHEN Substr(RC1."turma", 2,1) = '1'   THEN '001'  WHEN Substr(RC1."turma", 2,1) = '2'   THEN '003' WHEN Substr(RC1."turma", 2,1) = '3'   THEN '002'       END,
                           SAET_SITUAC    = CASE WHEN RC1."sit" = 'M'   THEN '001' WHEN RC1."sit" = 'R'   THEN '002' WHEN RC1."sit" = 'T'   THEN '003' WHEN RC1."sit" = 'F'   THEN '004' WHEN RC1."sit" = 'C'   THEN '005' WHEN RC1."sit" = 'Des' THEN '006' WHEN RC1."sit" = 'O'   THEN '007' WHEN RC1."sit" = 'Dep' THEN '999' END,
                           SAET_END       = RC1."local1",
                           SAET_MUN       = RC1."cidade",
                           SAET_EST       = RC1."estado",
                           SAET_BAIRRO    = RC1."bairro",
                           SAET_CEP       = RC1."CEP",
                           SAET_TEL       = RC1."fone",
                           SAET_SEXO      = RC1."sexo"
                     WHERE SAET_NUMRA     = RC1."codigo"
                       AND SAET_IDEMPRESA = 1;

                    UPDATE SEU.SEUAET
                       SET SAET_EMAIL = (SELECT "email"
                                           FROM  "alunopass"@PRESEU_CLIENTE
                                          WHERE "codigo" = RC1."codigo"
                                            AND SAET_NUMRA = "codigo")
                     WHERE SAET_IDEMPRESA = 1
                       AND SAET_NUMRA = RC1."codigo";

                 END IF;


                 IF RC1."log_tipo" = 'D' THEN

                    DELETE SEU.SEUAET
                     WHERE SAET_NUMRA     = RC1."codigo"
                       AND SAET_IDEMPRESA = 1;

                 END IF;


                  DELETE
                    FROM "yAluno2"@PRESEU_CLIENTE
                   WHERE REC = RC1."REC";

                  COMMIT;

              END LOOP;
      COMMIT;
      END;

      DECLARE

             CURSOR C1 IS SELECT *
                            FROM "yDocumento2"@PRESEU_CLIENTE
                           WHERE rownum <= (SELECT COUNT(*) FROM "yDocumento2"@PRESEU_CLIENTE )
                           ORDER BY "log_data";

             --CONT NUMBER := 0;

      BEGIN

             FOR RC1 IN C1 LOOP

                UPDATE SEU.SEUAET
                   SET SAET_RG        = TRIM(RC1."RG"),
                       SAET_PAIS      = TRIM(RC1."pais"),
                       SAET_PAI       = TRIM(RC1."pai"),
                       SAET_MAE       = TRIM(RC1."mae")
                 WHERE SAET_NUMRA     = RC1."al_codigo"
                   AND SAET_IDEMPRESA = 1;

                DELETE
                  FROM "yDocumento2"@PRESEU_CLIENTE
                 WHERE REC = RC1."REC";

                COMMIT;

              END LOOP;
      COMMIT;
      END;

      DECLARE
             CURSOR C1 IS SELECT *
                            FROM SEU.SEUABP_LOG2
                           WHERE ROWNUM <= (SELECT COUNT(*) FROM SEU.SEUABP_LOG2 )
                           ORDER BY DATA_HORA ;


      BEGIN

             FOR RC1 IN C1 LOOP

                 IF RC1.OPERACAO = 'I' THEN

                    DELETE
                      FROM SEU.SEUAET
                     WHERE SAET_NUMRA = RC1.SABP_NUMRA_DEPOIS;

                    INSERT INTO SEU.SEUAET(SAET_IDEMPRESA, SAET_NUMRA, SAET_NOME, SAET_RG, SAET_DTNASC, SAET_CPF, SAET_DTMAT, SAET_ANO, SAET_UNIDADE, SAET_CURSO, SAET_SEMESTR, SAET_SERIE, SAET_TURMA, SAET_BOLSA, SAET_JUIZO, SAET_SITUAC, SAET_END, SAET_MUN, SAET_EST, SAET_BAIRRO, SAET_CEP, SAET_TEL, SAET_FAX, SAET_EMAIL, SAET_CLIENTE, SAET_PAIS, SAET_SEXO, SAET_PAI, SAET_MAE, SAET_INIJUIZ, SAET_FIMJUIZ, SAET_IDUSUARIO, SAET_NUM, SAET_COMPL)
                                    VALUES(RC1.SABP_IDEMPRESA_DEPOIS,
                                           RC1.SABP_NUMRA_DEPOIS,
                                           RC1.SABP_DESC_DEPOIS,
                                           RC1.SABP_RG_DEPOIS,
                                           RC1.SABP_DTNASC_DEPOIS,
                                           RC1.SABP_CPF_DEPOIS,
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           '',
                                           RC1.SABP_LOGRADOURO_DEPOIS,
                                           RC1.SABP_CIDADE_DEPOIS,
                                           RC1.SABP_ESTADO_DEPOIS,
                                           RC1.SABP_BAIRRO_DEPOIS,
                                           RC1.SABP_CEP_DEPOIS,
                                           RC1.SABP_TELEFONE1_DEPOIS,
                                           RC1.SABP_TELEFONE3_DEPOIS,
                                           RC1.SABP_EMAIL_DEPOIS,
                                           '',
                                           RC1.SABP_NACIONAL_DEPOIS,
                                           RC1.SABP_SEXO_DEPOIS,
                                           RC1.SABP_PAI_DEPOIS,
                                           RC1.SABP_MAE_DEPOIS,
                                           '',
                                           '',
                                           1,
                                           RC1.SABP_NUM_DEPOIS,
                                           RC1.SABP_COMPL_DEPOIS);

                 END IF;


                 IF RC1.OPERACAO = 'U' THEN

                     UPDATE SEU.SEUAET
                        SET SAET_NUMRA  = RC1.SABP_NUMRA_DEPOIS,
                            SAET_NOME   = RC1.SABP_DESC_DEPOIS,
                            SAET_RG     = RC1.SABP_RG_DEPOIS,
                            SAET_DTNASC = RC1.SABP_DTNASC_DEPOIS,
                            SAET_CPF    = RC1.SABP_CPF_DEPOIS,
                            SAET_END    = RC1.SABP_LOGRADOURO_DEPOIS,
                            SAET_MUN    = RC1.SABP_CIDADE_DEPOIS,
                            SAET_EST    = RC1.SABP_ESTADO_DEPOIS,
                            SAET_BAIRRO = RC1.SABP_BAIRRO_DEPOIS,
                            SAET_CEP    = RC1.SABP_CEP_DEPOIS,
                            SAET_TEL    = RC1.SABP_TELEFONE1_DEPOIS,
                            SAET_FAX    = RC1.SABP_TELEFONE2_DEPOIS,
                            SAET_EMAIL  = RC1.SABP_EMAIL_DEPOIS,
                            SAET_PAIS   = RC1.SABP_NACIONAL_DEPOIS,
                            SAET_SEXO   = RC1.SABP_SEXO_DEPOIS,
                            SAET_PAI    = RC1.SABP_PAI_DEPOIS,
                            SAET_MAE    = RC1.SABP_MAE_DEPOIS,
                            SAET_NUM    = RC1.SABP_NUM_DEPOIS,
                            SAET_COMPL  = RC1.SABP_COMPL_DEPOIS
                      WHERE SAET_IDEMPRESA = RC1.SABP_IDEMPRESA_ANTES
                        AND SAET_NUMRA     = RC1.SABP_NUMRA_ANTES;

                 END IF;

                 IF RC1.OPERACAO = 'D' THEN

                    DELETE SEU.SEUAET
                     WHERE SAET_IDEMPRESA = RC1.SABP_IDEMPRESA_ANTES
                       AND SAET_NUMRA     = RC1.SABP_NUMRA_ANTES;

                 END IF;

                  DELETE
                    FROM SEU.SEUABP_LOG2
                   WHERE NREG = RC1.NREG;

                  COMMIT;

              END LOOP;
      COMMIT;
      END;



      DECLARE

             CURSOR C1 IS SELECT *
                            FROM SEU.SEUABO_LOG2
                           WHERE ROWNUM <= (SELECT COUNT(*) FROM SEU.SEUABO_LOG2 )
                           ORDER BY DATA_HORA ;

      BEGIN

             FOR RC1 IN C1 LOOP

                 IF RC1.OPERACAO = 'I' AND RC1.SABO_ATIVO_ANTES = 'S' THEN

                    UPDATE SEU.SEUAET
                       SET SAET_DTMAT     = RC1.SABO_DATA_ANTES,
                           SAET_ANO       = RC1.SABO_ANOLET_ANTES,
                           SAET_UNIDADE   = RC1.SABO_CODUND_ANTES,
                           SAET_CURSO     = RC1.SABO_CODCUR_ANTES,
                           SAET_SEMESTR   = RC1.SABO_PERIODO_ANTES,
                           SAET_SERIE     = RC1.SABO_SERIE_ANTES,
                           SAET_TURMA     = RC1.SABO_TURMA_ANTES,
                           SAET_SITUAC    = CASE
                                                WHEN RC1.SABO_TPSIT_ANTES  = '002' AND RC1.SABO_SITALU_ANTES = '001' THEN '999'
                                                ELSE RC1.SABO_SITALU_ANTES
                                             END
                     WHERE SAET_IDEMPRESA = RC1.SABO_IDEMPRESA_ANTES
                       AND SAET_NUMRA     = RC1.SABO_NUMRA_ANTES;

                 END IF;


                 IF RC1.OPERACAO = 'U' AND RC1.SABO_ATIVO_DEPOIS = 'S' THEN

                    UPDATE SEU.SEUAET
                       SET SAET_DTMAT     = RC1.SABO_DATA_DEPOIS,
                           SAET_ANO       = RC1.SABO_ANOLET_DEPOIS,
                           SAET_UNIDADE   = RC1.SABO_CODUND_DEPOIS,
                           SAET_CURSO     = RC1.SABO_CODCUR_DEPOIS,
                           SAET_SEMESTR   = RC1.SABO_PERIODO_DEPOIS,
                           SAET_SERIE     = RC1.SABO_SERIE_DEPOIS,
                           SAET_TURMA     = RC1.SABO_TURMA_DEPOIS,
                           SAET_SITUAC    = CASE
                                                WHEN RC1.SABO_TPSIT_DEPOIS  = '002' AND RC1.SABO_SITALU_DEPOIS = '001' THEN '999'
                                                ELSE RC1.SABO_SITALU_DEPOIS
                                             END
                     WHERE SAET_IDEMPRESA = RC1.SABO_IDEMPRESA_ANTES
                       AND SAET_NUMRA     = RC1.SABO_NUMRA_ANTES;

                 END IF;

                 IF RC1.OPERACAO = 'D' THEN

                    DELETE SEU.SEUAET
                     WHERE SAET_IDEMPRESA = RC1.SABO_IDEMPRESA_ANTES
                       AND SAET_NUMRA     = RC1.SABO_NUMRA_ANTES;

                 END IF;

                  DELETE
                    FROM SEU.SEUABO_LOG2
                   WHERE NREG = RC1.NREG;

                  COMMIT;

              END LOOP;
      COMMIT;
      END;


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

      COMMIT;


END;
/  