
REM  -----------------------------------------------------------------
REM  Autor    : Marco A Freitas
REM  Criacao  : 13/02/1997
REM  Objetivo : Tenta executar deferred errors. Se não conseguir apaga
REM  -----------------------------------------------------------------

SET SERVEROUTPUT ON

DECLARE

   CURSOR deferred IS SELECT deferred_tran_id ,
			     deferred_tran_db ,
			     destination
                      FROM deferror;

   wtran_id VARCHAR2(22) ;
   wtran_db VARCHAR2(128);
   wdestina VARCHAR2(128);

BEGIN

   DBMS_OUTPUT.PUT_LINE('COMECOU A BUSCA...');

   FOR cdeferred IN deferred LOOP

      wtran_id := cdeferred.deferred_tran_id;
      wtran_db := cdeferred.deferred_tran_db;
      wdestina := cdeferred.destination;

      DBMS_OUTPUT.PUT_LINE('ESTOU EXECUTANDO...');

      DBMS_DEFER_SYS.EXECUTE_ERROR(wtran_id, wtran_db, wdestinaA);

   END LOOP;

EXCEPTION

   WHEN OTHERS THEN

REM      DBMS_DEFER_SYS.DELETE_ERROR(wtran_id, wtran_db, wdestina);

      DBMS_OUTPUT.PUT_LINE('APAGOU MAIS UM...');

END;

/
