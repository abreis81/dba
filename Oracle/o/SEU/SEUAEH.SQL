CREATE OR REPLACE VIEW seu.SEUAEH AS
SELECT "SAEH_IDEMPRESA", "SAEH_NUMRA", "SAEH_ITEM", "SAEH_TIPBOL", "SAEH_CURSO", "SAEH_BOLSA",
       "SAEH_PERBOL", "SAEH_VLRBOL", "SAEH_DTVAL1", "SAEH_DTVAL2", "SAEH_PERDE", "SAEH_MEMO1",
       "SAEH_CLIENT", "SAEH_LOJA", "SAEH_MATR", "SAEH_NFIES", "SAEH_NREG"
  FROM (
        SELECT 1            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5010
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' '
        UNION
        SELECT 2            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5010
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' '
        UNION
        SELECT 3            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5010
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' '
        UNION
        SELECT 4            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5040
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' '
        UNION
        SELECT 5            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5010
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' '
        UNION
        SELECT 6            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5020
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' '
        UNION
        SELECT 7            SAEH_IDEMPRESA,
               TRIM(JC5_NUMRA)    SAEH_NUMRA,
               JC5_ITEM     SAEH_ITEM,
               JC5_TIPBOL   SAEH_TIPBOL,
               JC5_CURSO    SAEH_CURSO,
               JC5_BOLSA    SAEH_BOLSA,
               JC5_PERBOL   SAEH_PERBOL,
               JC5_VLRBOL   SAEH_VLRBOL,
               JC5_DTVAL1   SAEH_DTVAL1,
               JC5_DTVAL2   SAEH_DTVAL2,
               JC5_PERDE    SAEH_PERDE,
               JC5_MEMO1    SAEH_MEMO1,
               JC5_CLIENT   SAEH_CLIENT,
               JC5_LOJA     SAEH_LOJA,
               JC5_MATR     SAEH_MATR,
               JC5_NFIES    SAEH_NFIES,
               R_E_C_N_O_   SAEH_NREG
          FROM SIGA.JC5030
         WHERE JC5_FILIAL = '  '
           AND D_E_L_E_T_ = ' ')
/