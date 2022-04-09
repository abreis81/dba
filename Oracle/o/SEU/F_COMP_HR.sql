CREATE OR REPLACE FUNCTION SEU.F_COMP_HR
   ( cHrIni1 IN number,
     cHrFim1 IN number,
     cHrIni2 IN number,
     cHrFim2 IN number )
   RETURN number
IS
    RES number;
BEGIN

     IF cHrIni1 = cHrIni2 Or  cHrFim1 = cHrFim2 THEN
        SELECT 1
          INTO RES
          FROM DUAL;
     ELSE

      SELECT 1
        INTO RES
        FROM DUAL
       WHERE cHrIni1 BETWEEN cHrIni2 + 1 AND cHrFim2 - 1
          OR cHrFim1 BETWEEN cHrIni2 + 1 AND cHrFim2 - 1
          OR cHrIni2 BETWEEN cHrIni1 + 1 AND cHrFim1 - 1
          OR cHrFim2 BETWEEN cHrIni1 + 1 AND cHrFim1 - 1;

     END IF;


RETURN RES ;
END;