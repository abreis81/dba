-- rodar na perp ( atualizar a senha para a do padrão do RH

SET SERVEROUTPUT ON
DECLARE
   PMSG VARCHAR2(1000);
   BEGIN
    P_ALTERA_SENHA('004142','01',PMSG);
    DBMS_OUTPUT.PUT_LINE(PMSG);
   END;
/

