CREATE OR REPLACE PROCEDURE PRC_REPLICA IS

CURSOR C_REPLICA IS
     select packagename,
            enq_time,
            step_no,
            enq_tid,
            schemaname,
            procname,
            chain_no,
            data_transacao,
            rowid
       from tempo1
order by 1,8;

RC_REPLICA  C_REPLICA%ROWTYPE;
nSTEPNO     NUMBER;
nTRANSACAO  NUMBER := 0;
setPACK     VARCHAR2(50);
setTIME     VARCHAR2(20);
setTABLE    VARCHAR2(40);
setTID      VARCHAR2(30);
setDATE     DATE;
ncontr  number := 0;

BEGIN

  OPEN C_REPLICA;
  FETCH C_REPLICA INTO RC_REPLICA;

  WHILE C_REPLICA%FOUND LOOP
    select max(RC_REPLICA.step_no) into nSTEPNO from tempo1 where enq_tid=RC_REPLICA.ENQ_TID;
    nSTEPNO := nSTEPNO + 1;
    setTID    := RC_REPLICA.ENQ_TID;
    setTIME   := RC_REPLICA.ENQ_TIME;
    setDATE   := RC_REPLICA.DATA_TRANSACAO;
    setPACK   := RC_REPLICA.PACKAGENAME;
    
    WHILE setPACK = RC_REPLICA.PACKAGENAME LOOP

      IF (RC_REPLICA.ENQ_TID <> setTID) THEN
      BEGIN
        UPDATE SYSTEM.DEF$_AQCALL
           SET ENQ_TID =setTID
              ,ENQ_TIME=setDATE
              ,STEP_NO =nSTEPNO
         WHERE ENQ_TID =RC_REPLICA.ENQ_TID and step_no = rc_replica.step_no ;

ncontr := ncontr + 1;

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

  DBMS_OUTPUT.PUT_LINE('TOTAL DE TRANSACAO: '||TO_CHAR(ncontr,'999999'));

  CLOSE C_REPLICA;

EXCEPTION
  WHEN OTHERS THEN
    CLOSE C_REPLICA;

END;
/
