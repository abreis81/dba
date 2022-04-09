CREATE OR REPLACE FUNCTION SEU.F_COMP_DT
   ( cDtIni1 IN number,
     cDTFim1 IN number,
     cDTIni2 IN number,
     cDtFim2 IN number )
   RETURN number
IS
    RES number;
BEGIN

     IF cDtIni1 = cDtIni2 Or  cDtFim1 = cDtFim2 THEN
        SELECT 1
          INTO RES
          FROM DUAL;
     ELSE

      SELECT 1
        INTO RES
        FROM DUAL
       WHERE cDtIni1 BETWEEN cDtIni2 + 1 AND cDtFim2 - 1
          OR cDtFim1 BETWEEN cDtIni2 + 1 AND cDtFim2 - 1
          OR cDtIni2 BETWEEN cDtIni1 + 1 AND cDtFim1 - 1
          OR cDtFim2 BETWEEN cDtIni1 + 1 AND cDtFim1 - 1;

     END IF;


RETURN RES ;
END;