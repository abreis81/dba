create or replace PROCEDURE PRC_REPLICA IS

CURSOR C_REPLICA IS
     select packagename,
            enq_time,
            enq_tid,
            step_no,
            schemaname,
            procname,
            chain_no,
            rowid
       from tempo1
order by 1,2,3,4;

RC_REPLICA  C_REPLICA%ROWTYPE;
nSTEPNO     NUMBER;
nTRANSACAO  NUMBER := 0;
setPACK     VARCHAR2(50);
setTIME     VARCHAR2(20);
setTABLE    VARCHAR2(40);
setTID      VARCHAR2(30);
setDATE     DATE;
nQTD        NUMBER := 1;

BEGIN

  OPEN C_REPLICA;
  FETCH C_REPLICA INTO RC_REPLICA;

  WHILE C_REPLICA%FOUND LOOP

    nSTEPNO   := 0;
    setTID    := RC_REPLICA.ENQ_TID;
    setDATE   := RC_REPLICA.ENQ_TIME;
    setPACK   := RC_REPLICA.PACKAGENAME;

    WHILE setPACK = RC_REPLICA.PACKAGENAME LOOP

      IF nSTEPNO > 0 THEN

         BEGIN
           UPDATE SYSTEM.DEF$_AQCALL
              SET ENQ_TID =setTID
                 ,ENQ_TIME=setDATE
                 ,STEP_NO =nSTEPNO
            WHERE ENQ_TID =RC_REPLICA.ENQ_TID
              AND STEP_NO =RC_REPLICA.STEP_NO;
/*
           UPDATE TEMPO2
              SET ENQ_TID2=setTID
                 ,ENQ_TIME2=setDATE
                 ,STEP_NO2 =nSTEPNO
            WHERE ENQ_TID =RC_REPLICA.ENQ_TID
              AND STEP_NO =RC_REPLICA.STEP_NO;
*/

           nQTD := nQTD + 1;

           COMMIT;

         EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('DEU ERRO !!!!! '||SQLCODE);

         END;

      END IF;

      nSTEPNO := nSTEPNO + 1;
      FETCH C_REPLICA INTO RC_REPLICA;
      EXIT WHEN C_REPLICA%NOTFOUND;

    END LOOP;

  END LOOP;

  DBMS_OUTPUT.PUT_LINE('TOTAL DE TRANSACAO: '||TO_CHAR(nQTD,'999999'));

  CLOSE C_REPLICA;

EXCEPTION
  WHEN OTHERS THEN
    CLOSE C_REPLICA;

END;
/