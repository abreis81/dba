
UNDEFINE wk_tran_id
UNDEFINE wk_call_id

REM  -------------------------------------------------------------------------------
REM  Autor    : Marco A Freitas
REM  Criacao  : 17/04/1997
REM  Objetivo : Esta rotina exibe todas as chamadas para um determinado deferred TXN
REM  -------------------------------------------------------------------------------

SET SERVEROUTPUT ON SIZE 1000000

DECLARE

   argno        NUMBER;
   argtyp       NUMBER;
   typdsc       CHAR(15);
   rowid_val    ROWID;
   char_val     VARCHAR2(255);
   date_val     DATE;
   number_val   NUMBER;
   varchar2_val VARCHAR2(2000);
   raw_val      RAW(255);
   callno       NUMBER;
   origdb       VARCHAR2(200);
   tranid       VARCHAR2(70);
   schnam       VARCHAR2(35);
   pkgnam       VARCHAR2(35);
   prcnam       VARCHAR2(35);
   operation    VARCHAR2(35);
   argcnt       NUMBER;

   CURSOR c_defcall IS SELECT callno           ,
                              deferred_tran_db ,
                              deferred_tran_id ,
                              schemaname       ,
                              packagename      ,
                              procname         ,
                              argcount
                       FROM   defcall  
                       WHERE deferred_tran_id = '&&wk_tran_id.' AND callno = '&&wk_call_id.';

   CURSOR c_operation IS SELECT SUBSTR(procname, 05, 12)  
                         FROM defcall 
                         WHERE deferred_tran_id = '&&wk_tran_id.' AND callno = '&&wk_call_id.';

BEGIN

   argno := 1;

   open c_defcall;
   open c_operation;

   WHILE TRUE LOOP

      FETCH c_defcall INTO callno, origdb, tranid, schnam, pkgnam, prcnam, argcnt;
      FETCH c_operation INTO operation;

      EXIT WHEN c_defcall%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Transaction id: '||tranid);
      DBMS_OUTPUT.PUT_LINE('DML operation is an ' || operation || '.');
      DBMS_OUTPUT.PUT_LINE('Originating from ' || origdb || '.');
      DBMS_OUTPUT.PUT_LINE('Call to ' || schnam || '.' || pkgnam || '.' || prcnam);
      DBMS_OUTPUT.PUT_LINE('ARG ' || 'Data Type       ' || 'Value');
      DBMS_OUTPUT.PUT_LINE('--- ' || '--------------- ' || '----------------------');

      argno := 1;

      WHILE TRUE LOOP

         IF argno > argcnt THEN
            EXIT;
         END IF;
 
         argtyp := DBMS_DEFER_QUERY.GET_ARG_TYPE(callno, origdb, argno, tranid);

         IF argtyp = 1 THEN

            typdsc       := 'VARCHAR2';
            varchar2_val := DBMS_DEFER_QUERY.GET_VARCHAR2_ARG(callno, origdb, argno, tranid);

            DBMS_OUTPUT.PUT_LINE(TO_CHAR(argno, '09') || ') ' || typdsc || ' ' || varchar2_val);

         END IF;

         IF argtyp = 2 THEN

            typdsc     := 'NUMBER';
            number_val := DBMS_DEFER_QUERY.GET_NUMBER_ARG(callno, origdb, argno, tranid);

            DBMS_OUTPUT.PUT_LINE(TO_CHAR(argno, '09') || ') ' || typdsc || ' ' || number_val);

         END IF;

         IF argtyp = 11 THEN

            typdsc := 'ROWID';
            rowid_val := DBMS_DEFER_QUERY.GET_ROWID_ARG(callno, origdb, argno, tranid);

            DBMS_OUTPUT.PUT_LINE(TO_CHAR(argno, '09') || ') ' || typdsc || ' ' || rowid_val);

         END IF;

         IF argtyp = 12 THEN

            typdsc := 'DATE';
            date_val := DBMS_DEFER_QUERY.GET_DATE_ARG(callno, origdb, argno, tranid);

            DBMS_OUTPUT.PUT_LINE(TO_CHAR(argno, '09') || ') ' || typdsc || ' ' || TO_CHAR(date_val, 'YYYY-MM-DD HH24:MI:SS'));

         END IF;

         IF argtyp = 23 THEN

            typdsc := 'RAW';
            raw_val := DBMS_DEFER_QUERY.GET_RAW_ARG(callno, origdb, argno, tranid);

            DBMS_OUTPUT.PUT_LINE(TO_CHAR(argno, '09') || ') ' || typdsc || ' ' || raw_val);

         END IF;

         IF argtyp = 96 THEN

            typdsc := 'CHAR';
            char_val := DBMS_DEFER_QUERY.GET_CHAR_ARG(callno, origdb, argno, tranid);

            DBMS_OUTPUT.PUT_LINE(TO_CHAR(argno, '09') || ') ' || typdsc || ' ' || char_val);

         END IF;
 
         argno := argno + 1;

      END LOOP;

   END LOOP;

   CLOSE c_defcall;
   CLOSE c_operation;

END;
/
