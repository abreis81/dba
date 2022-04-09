create or replace view seu.seuaco as 
SELECT SACO_IDEMPRESA, SACO_MATRICULA, SACO_NOME, SACO_NASC,
       SACO_CIC, SACO_RG, SACO_SEXO, SACO_ENDERECO, SACO_COMPLEMENTO, 
       SACO_BAIRRO, SACO_CIDADE, SACO_ESTADO, SACO_CEP, SACO_telefonE,
       SACO_DPTO, SACO_CARGO, SACO_TITULACAO, SACO_EMAIL, SACO_ADMISSAO, SACO_SENHA, 
       ROWNUM AS SACO_NREG,
       SACO_CODTIT
FROM (SELECT 1 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '01'
AND filial = 'A01'
UNION
SELECT 2 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '01'
AND filial = 'A01'
UNION
SELECT 3 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '01'
AND filial = 'A01'
UNION
SELECT 4 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '04'
AND filial = 'G07'
UNION
SELECT 5 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '01'
AND filial = 'D02'
UNION
SELECT 6 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '01'
AND filial = 'A01' 
UNION
SELECT 7 as saco_idempresa,
ra_mat as saco_matricula,
ra_nome as saco_nome,
ra_nasc as saco_nasc,
ra_cic as saco_cic,
ra_rg as saco_rg,
case ra_sexo 
when 'M' then '1'
when 'F' then '2'
end as saco_sexo,
ra_enderec as saco_endereco,
ra_complem as saco_complemento,
ra_bairro as saco_bairro,
ra_municip as saco_cidade,
ra_estado as saco_estado,
ra_cep as saco_cep,
ra_telefon as saco_telefone,
i3_desc as saco_dpto,
rj_desc as saco_cargo,
ra_titula_ as saco_titulacao,
ra_email as saco_email,
ra_admissa as saco_admissao,
ra_senha as saco_senha,
rownum as saco_nreg,
'00' as saco_codtit
FROM ASM.FUNC_ATIVOS_2@seu_asm
WHERE empresa = '01'
AND filial = 'A01'
) TMP
/