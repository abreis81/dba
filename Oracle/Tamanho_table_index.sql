-- TAMANHO DA TABELA E DA PK DESTA TABELA 
SELECT TABLE_NAME, SUM(TAM) FROM (
select C.owner, C.table_name, C.constraint_name, S.BYTES/1024/1024 TAM , s.segment_name -- S.* 
from dba_segments s, DBA_CONSTRAINTS C
where ( S.SEGMENT_NAME = C.constraint_name OR S.SEGMENT_NAME = C.table_name)  
  AND S.OWNER = C.owner
  AND C.owner = 'ATT'
  AND C.constraint_type = 'P'
  AND C.table_name IN 
(
'ADESAO_PLANO_PARTIC_FSS',
'ADESAO_PLANO_PATROC',
'AGENDA_ACOMPHMTO_FSS',
'BENEFICIO_PARTIC_FSS',
'COTACAO_MES_UM',
'CUSTEIO_PLANO_FSS',
'DEPENDENTE',
'EMPREGADO',
'EMPRESA',
'EMPRG_DPDTE',
'ENDERECO_FSS',
'FCH_FINAN_PARTIC_FSS',
'FICHA_FINANCEIRA',
'GRAU_DEPENDENCIA',
'HAB_PART_CAPIT_FSS',
'HAB_PART_CUSTEIO_PLANO_FSS',
'HIST_PART_CAPIT_FSS',
'HIST_SAL_BASE_FSS',
'INDICE_CORR_PLN_FSS',
'MOEDA_BRASILEIRA_FSS',
'MOV_CONT_PARTIC_FSS',
'PARC_PAGTO_BENEF_FSS',
'PARTICIPANTE_FSS',
'PATROCINADORA_FSS',
-- 'PCT_CTB_INDIVI_PARTIC_FSS',
'PCT_CTB_INDIV_PARTIC_FSS',
'PCT_CTB_PCTIPR',
'PLANO_BENEFICIO_FSS',
'SIT_PARTICIP_FSS',
'TB_FERIADO',
'TIPO_CTB_CAPIT_FSS',
'TIPO_ENDERECO_FSS',
'TIPO_PARTICIP_FSS',
'UNIDADE_MONETARIA',
'VERBA_FSS'
) )
GROUP BY TABLE_NAME
ORDER BY TABLE_NAME;