CREATE OR REPLACE VIEW seumig.SEUACO AS
SELECT EMPRESA AS SACO_IDEMPRESA,
       TO_CHAR(RA_MAT) AS SACO_MATRICULA,
       RA_NOME AS SACO_NOME,
       RA_NASC AS SACO_NASC,
       RA_CIC AS SACO_CIC,
       RA_RG AS SACO_RG,
       RA_SEXO AS SACO_SEXO,
       RA_ENDEREC AS SACO_ENDERECO,
       RA_COMPLEM AS SACO_COMPLEMENTO,
       RA_BAIRRO AS SACO_BAIRRO,
       RA_MUNICIP AS SACO_CIDADE,
       RA_ESTADO AS SACO_ESTADO,
       RA_CEP AS SACO_CEP,
       RA_TELEFON AS SACO_TELEFONE,
       I3_DESC AS SACO_DPTO,
       RJ_DESC AS SACO_CARGO,
       RA_TITULA_ AS SACO_TITULACAO,
       RA_EMAIL AS SACO_EMAIL,
       RA_ADMISSA AS SACO_ADMISSAO,
       RA_SENHA AS SACO_SENHA,
       ROWNUM AS SACO_NREG
  FROM (SELECT '1' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA010, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '01'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA010.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'
        UNION 
        SELECT '2' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA010, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '01'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA010.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'   
        UNION
        SELECT '3' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA010, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '01'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA010.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'   
        UNION
        SELECT '4' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA040, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '01'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA040.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'   
        UNION
        SELECT '5' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA010, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '02'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA010.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'   
        UNION
        SELECT '6' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA020, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '01'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA020.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'   
        UNION
        SELECT '7' EMPRESA, RA_NASC, RA_SEXO, RA_NOME, RA_MAT, RA_ENDEREC, RA_COMPLEM, RA_BAIRRO, RA_MUNICIP,
                RA_ESTADO,  RA_CEP, RA_TELEFON, I3_CUSTO, I3_DESC, RJ_DESC, RA_CIC, RA_RG, RA_TITULA_, RA_EMAIL,
                RA_ADMISSA, RA_SENHA
          FROM SRA040, SIGA.SI3010, SIGA.SRJ010
         WHERE RA_FILIAL = I3_FILIAL
           AND RA_FILIAL = '01'
           AND RA_CC = I3_CUSTO
           AND RA_CODFUNC = RJ_FUNCAO
           AND RJ_FILIAL = ' '
           AND RA_SITFOLH <> 'D'
           AND ltrim(rtrim(I3_DESC)) <> ' '
           AND SRA040.D_E_L_E_T_ <> '*'
           AND SI3010.D_E_L_E_T_ <> '*'
           AND SRJ010.D_E_L_E_T_ <> '*'   )