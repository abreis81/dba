CREATE OR REPLACE VIEW "SEU"."SEUACO" ("SACO_IDEMPRESA","SACO_MATRICULA","SACO_NOME","SACO_NASC","SACO_CIC","SACO_RG","SACO_SEXO","SACO_ENDERECO","SACO_COMPLEMENTO","SACO_BAIRRO","SACO_CIDADE","SACO_ESTADO","SACO_CEP","SACO_TELEFONE","SACO_DPTO","SACO_CARGO","SACO_TITULACAO","SACO_EMAIL","SACO_ADMISSAO","SACO_SENHA","SACO_NREG","SACO_CODTIT") AS SELECT saco_idempresa,
saco_matricula,
saco_nome,
saco_nasc,
saco_cic,
saco_rg,
saco_sexo,
saco_endereco,
saco_complemento,
saco_bairro,
saco_cidade,
saco_estado,
saco_cep,
saco_telefone,
saco_dpto,
saco_cargo,
saco_titulacao,
saco_email,
saco_admissao,
saco_senha,
saco_nreg ,
saco_codtit
FROM (SELECT saaa_idempresa as saco_idempresa,
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
RPAD(id,LENGTH(id)+20,9)||LPAD(saaa_idempresa,4,9) as saco_nreg ,
'0' as SACO_CODTIT
FROM ASM.FUNC_ATIVOS_2@seu_asm a, seuaaa b
WHERE ( saaa_idempresa in (CASE WHEN filial = 'A01' AND empresa = '01' THEN 1 END)
or saaa_idempresa in (CASE WHEN filial = 'A01' AND empresa = '01' THEN 2 END)
or saaa_idempresa in (CASE WHEN filial = 'A01' AND empresa = '01' THEN 3 END)
or saaa_idempresa in (CASE WHEN filial = 'A01' AND empresa = '01' THEN 6 END)
or saaa_idempresa in (CASE WHEN filial = 'A01' AND empresa = '01' THEN 7 END)
or saaa_idempresa in (CASE WHEN filial = 'G07' AND empresa = '04' THEN 4 END)
or saaa_idempresa in (CASE WHEN filial = 'D02' AND empresa = '01' THEN 5 END) ) ) 