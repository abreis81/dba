Procedimento a ser executado para o processamento do NOSSO NUMERO :

-- ANTES DO PROCESSAMENTO

   -- retirar estatisticas do indice ATT.ID_PARCELA_001
   analyze index ATT.ID_PARCELA_001 delete statistics;
   -- alterar os indices ATT.FCESP_PENDENCIA_OPPORTUNITY e ATT.ID_PENDENCIA_010 para invisible
   alter index ATT.FCESP_PENDENCIA_OPPORTUNITY INVISIBLE;
   alter index ATT.ID_PENDENCIA_010 INVISIBLE;

   -- verificar se as estatisticas do indice foram retiradas 
   select i.last_analyzed, i.* from dba_indexes i where i.table_owner like upper('%%') and i.table_name like upper('%%') 
      and i.index_name like upper('ID_PARCELA_001') 

   -- verificar se os indices foram alterados para invisible
   select I.visibility, I.last_analyzed, I.*
     from dba_indexes I                     
    where visibility <> 'VISIBLE';

          /* - os indices abaixo devem ser mantidos invisible
              ID_HIST_PARTIC_PLANO_006
              ID_PARTICIP_PLANO_012
              ID_PENDENCIA_013
          */



-- APOS PROCESSAMENTO
    -- import das estatisticas do indice ATT.ID_PARCELA_001
    begin
    DBMS_STATS.IMPORT_INDEX_STATS (
       statid        => 'MPROD_20121216_0638'
      ,ownname       => 'ATT'
      ,indname       => 'ID_PARCELA_001'
      ,stattab       => 'STAT_TAB'
      ,no_invalidate => true
    );
    end;
    /
    -- verificar se as estatisticas do indice foram atualizadas 
     select i.last_analyzed, i.* from dba_indexes i where i.table_owner like upper('%%') and i.table_name like upper('%%') 
        and i.index_name like upper('ID_PARCELA_001') 


   -- alterar os indices para VISIBLE
   alter index att.FCESP_PENDENCIA_OPPORTUNITY VISIBLE;
   alter index ATT.ID_PENDENCIA_010 VISIBLE;

   -- verificar se indice estao visible
    select I.visibility, I.last_analyzed, I.*
      from dba_indexes I                     
    where visibility <> 'VISIBLE';

          /* - os indices abaixo devem ser mantidos invisible
              ID_HIST_PARTIC_PLANO_006
              ID_PARTICIP_PLANO_012
              ID_PENDENCIA_013
          */
