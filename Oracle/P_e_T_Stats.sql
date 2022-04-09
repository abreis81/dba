select TABLE_NAME, LAST_ANALYZED
from dba_tables 
where table_name in ('SEPTBLSSE')

SELECT INDEX_NAME, LAST_ANALYZED
FROM DBA_INDEXES
WHERE TABLE_NAME='SEPTBLSSE'

FCESP_PENDENCIA_OPPORTUNITY

select * 
from att.stat_tab 
where TYPE='T'
AND c1 = 'TB_PENDENCIA'


1º) export estatística da tabela 
begin
dbms_stats.export_table_stats(
   statid  => 'MPROD_20111206_1526'
  ,ownname => 'ATT'
 ,tabname => 'SEPTBLSSE'
 ,stattab => 'STAT_TAB'
 ,cascade => true);
end;   

2º) export estatística do índice
begin
DBMS_STATS.EXPORT_INDEX_STATS (
   statid        => 'PROD_220111202_0850_I01'
  ,ownname       => 'ATT'
  ,indname       => 'ID_PARCELA_001'
  ,stattab       => 'STAT_TAB');
end;

3º) exclusão das estatísticas da tabela 
analyze table ATT.SEPTBLSSE DELETE STATISTICS;

4º) import estatística do índice
begin
DBMS_STATS.IMPORT_INDEX_STATS (
   statid        => 'MPROD_20111031_1116'
  ,ownname       => 'ATT'
  ,indname       => 'ID_PARCELA_001'
  ,stattab       => 'STAT_TAB'
  ,no_invalidate => true);
end;

5º) após o processamento import da estatitica da tabela 
begin
dbms_stats.import_table_stats(
   statid        => 'MPROD_20111031_1116'
 ,ownname      => 'ATT'
  ,tabname       => 'SEPTBLSSE'
  ,stattab       => 'STAT_TAB'
  ,cascade       => true
  ,no_invalidate => true);
end;



EMPREGADO
