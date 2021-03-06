CREATE OR REPLACE PROCEDURE PRC_REPLICACAO( PE_DIRETORIO IN VARCHAR2 DEFAULT '/ora09/textos'
                                           ,PE_TXT       IN VARCHAR2 ) IS

CURSOR C_PK IS
  SELECT CLIENTE_ID  COLUNA1
    FROM TBEDGE_TRATAMENTO;

V_TEXTO UTL_FILE.FILE_TYPE;
V_LINHA NUMBER := 0;

TYPE A_MATRIZ IS
  ARRAY(120000) OF VARCHAR2(100);

A_TEXTO    A_MATRIZ := A_MATRIZ();
   
BEGIN

  V_TEXTO := UTL_FILE.FOPEN( PE_DIRETORIO, PE_TXT, 'W' );

  FOR RC_PK IN C_PK LOOP

      A_TEXTO.EXTEND;
      V_LINHA := V_LINHA + 1;
      A_TEXTO(V_LINHA) := RC_PK.COLUNA1;

      IF V_LINHA > 100000 THEN

         FOR I IN 1..V_LINHA LOOP
             UTL_FILE.PUT_LINE(V_TEXTO, A_TEXTO(I) );
         END LOOP;

         V_LINHA := 0;
                  
      END IF;

  END LOOP;

  IF V_LINHA > 0 THEN

     FOR I IN 1..V_LINHA LOOP
         UTL_FILE.PUT_LINE(V_TEXTO, A_TEXTO(I) );
     END LOOP;
                 
  END IF;

  UTL_FILE.FCLOSE( V_TEXTO );

EXCEPTION
  WHEN OTHERS THEN
    UTL_FILE.PUT_LINE(V_TEXTO,'PROBLEMA NA GERACAO DO ARQUIVO');
    UTL_FILE.FCLOSE(V_TEXTO);

END;
/
SHOW ERRORS
