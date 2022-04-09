/*

  segmento de rollback
  DBA_ROLLBACK_SEGS   - informacao sobre todos os segmentos de rollback
  DBA_SEGMENTS        - todos os segmentos da base inclusive rollback
  V$ROLLNAME          - nome dos segmentos de rollback que estao ONLINE
  V$ROLLSTAT          - estatisticas sobre os segmentos de rollback
  V$TRANSACTION       - informacoes sobre as transacao que estao ativas na base de dados


*/

create public rollback segment rb01
tablespace rbs
storage( initial 1m
            next 1m
      minextents 20
      maxextents 121
         optimal 20m );

obs: se nao for especificado o parametro OPTIMAL o segmento de rollback apos ser utilizado
     e criar extents extras nao volta sendo necessario fazer manualmente com:

     alter rollback segment rb01 shrink to 20m;


alter public rollback segment rb01 offline;
drop public rollback segment rb01;

--
-- atribuicao explicita de uma transacao ao segmento de rollback
--
set transaction use rollback segment rb50;               ( versao 7x )
execute dbms_transaction.use_rollback_segment('rb50');   ( versao 8x ) antes rodar o package DBMSUTIL.SQL sob o schema do SYSTEM





