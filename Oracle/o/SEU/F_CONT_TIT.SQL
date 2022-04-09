CREATE OR REPLACE FUNCTION SEU.F_CONT_TIT
   ( cControle  IN VARCHAR2,
     nPar    IN NUMBER )
   RETURN VARCHAR
IS
    cRet VARCHAR2(100);
    I NUMBER;
    cCont VARCHAR2(100);

BEGIN

     IF Length(cControle) > nPar THEN
         cCont := cControle;
     ELSE
         cCont := rPad(cControle, nPar, ' ' );
     END IF;

     IF Length(cControle) <> 0 THEN
       FOR I IN 1 .. length(cCont)
       LOOP
           IF nPar = I THEN
              cRet := cRet || 'X';
           ELSE
              cRet := cRet || SUBSTR(cCont, I, 1);
           END IF;
    
        END LOOP;
     ELSE
         cRet := 'X';
     END IF;        

RETURN cRet;
END;