  /*----------------------------/*
  || FORMATACAO DE QUANTIDADE   ||
  || NA IMPRESSAO DO XGF        ||
  ||                            ||
  */----------------------------*/
  FUNCTION FU_MASCA_QUANT( PE_QTD    NUMBER
                          ,PE_TAM    NUMBER
                          ,PE_DECIM  NUMBER ) RETURN VARCHAR2 IS

  V_VALOR_1   VARCHAR2(30);
  V_VALOR_2   VARCHAR2(10);
  V_POSDE     NUMBER := 0;

  BEGIN

    IF PE_QTD = 0 THEN
       IF PE_DECIM=0 THEN
          RETURN( LPAD( 0, PE_TAM ) );
       ELSE
          RETURN( LPAD('0,'||RPAD('0',PE_DECIM,'0'),PE_TAM) );
       END IF;
    END IF;

    V_VALOR_1 := FLOOR(PE_QTD);
    V_POSDE   := INSTR(PE_QTD,',');
    IF V_POSDE <> 0 THEN
       V_VALOR_2 := RPAD(SUBSTR(TRUNC(PE_QTD,PE_DECIM),V_POSDE+1),PE_DECIM,'0');
    ELSE
       V_VALOR_2 := RPAD('0',PE_DECIM,'0');
    END IF;

    IF V_VALOR_1 = 0 OR V_VALOR_1 IS NULL THEN
       IF PE_DECIM=0 THEN
          RETURN( LPAD( 0, PE_TAM ) );
       ELSE
          RETURN( LPAD('0,'||V_VALOR_2,PE_TAM ) );
       END IF;
    ELSE
       IF PE_DECIM=0 THEN
          RETURN( LPAD(V_VALOR_1,PE_TAM ) );
       ELSE
          RETURN( LPAD(V_VALOR_1||','||V_VALOR_2,PE_TAM ) );
       END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN  
      RAISE_APPLICATION_ERROR(-20008,'FU_MASCA_QUANT ==>'||SQLERRM);
  END;


  /*----------------------------/*
  || FORMATACAO DO VALOR        ||
  || IMPRESSO NO XGF            ||
  ||                            ||
  */----------------------------*/
  FUNCTION FU_MASCA_VALOR( PE_VALOR        IN NUMBER
                          ,PE_COD_MOEDA    IN MOEDA.COD_MOEDA%TYPE
                          ,PE_TAMANHO      IN NUMBER
                          ,PE_QTD_DECIM    IN NUMBER ) RETURN VARCHAR2 IS

  RC_MOEDA          MOEDA%ROWTYPE;
  V_COD_MOEDA       MOEDA.COD_MOEDA%TYPE;
  V_TEMP            VARCHAR2(40);
  V_VALOR           VARCHAR2(50);
  V_VALOR_1         VARCHAR2(40);
  V_VALOR_2         VARCHAR2(10);  
  V_POSICAO         CHAR(1);
  V_INDEX           NUMBER;
  V_CONTADOR        NUMBER;
  V_DECIMAIS        NUMBER;
  V_DEC             NUMBER;

  BEGIN

    V_COD_MOEDA:=NVL(PE_COD_MOEDA,'PTE');

    BEGIN
      SELECT COD_MOEDA
            ,NOM_MOEDA
            ,TAX_CONVE_CAMBI_EURO
            ,NUM_DECIM
            ,COD_PREFI
            ,COD_CARAC_MILHA
            ,COD_CARAC_DECIM
            ,COD_SUFIX
        INTO RC_MOEDA.COD_MOEDA
            ,RC_MOEDA.NOM_MOEDA
            ,RC_MOEDA.TAX_CONVE_CAMBI_EURO
            ,RC_MOEDA.NUM_DECIM
            ,RC_MOEDA.COD_PREFI
            ,RC_MOEDA.COD_CARAC_MILHA
            ,RC_MOEDA.COD_CARAC_DECIM
            ,RC_MOEDA.COD_SUFIX
        FROM MOEDA
       WHERE COD_MOEDA = V_COD_MOEDA;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN( 'MOEDA INVALIDA.' );
    END;

    V_DECIMAIS := PE_QTD_DECIM;
    V_TEMP     := TO_CHAR(NVL(PE_VALOR,0));
    V_VALOR    := SUBSTR(LPAD(LTRIM(RTRIM(V_TEMP)),PE_TAMANHO + 1,' '),1,PE_TAMANHO + 1);
--
--  VERIFICAR A FORMA COMO BANCO ESTA ARMAZENANDO OS VALORES   17/11/1999
--  
--  V_DEC      := INSTR(V_VALOR, RC_MOEDA.COD_CARAC_DECIM ,1);

    V_DEC      := INSTR(V_VALOR, ',' ,1);

    IF V_DEC = 0 THEN
       V_VALOR_1 := V_VALOR;
       V_VALOR_2 := RPAD('0',PE_QTD_DECIM,'0');
    ELSE
       V_VALOR_1  := SUBSTR(V_VALOR, 1, V_DEC - 1 );
       V_VALOR_2  := RPAD( SUBSTR(V_VALOR, V_DEC + 1, V_DECIMAIS ), V_DECIMAIS,'0');
    END IF;

    IF LENGTH(LTRIM(RTRIM(V_VALOR_1))) = 0 OR LTRIM(RTRIM(V_VALOR_1)) IS NULL THEN
       V_VALOR_1 := '0' || RC_MOEDA.COD_CARAC_DECIM || V_VALOR_2;
       RETURN( LPAD(V_VALOR_1,PE_TAMANHO,' ') );
    END IF;

    V_CONTADOR := 1;
    V_TEMP     := '';
    V_INDEX    := V_DEC - 1;

    LOOP

      V_POSICAO := SUBSTR(V_VALOR_1,V_INDEX,1);
      V_TEMP    := V_POSICAO || V_TEMP;

      IF MOD(V_CONTADOR,3) = 0 AND V_INDEX <> V_DEC AND V_INDEX <>  1 THEN
         V_TEMP := RC_MOEDA.COD_CARAC_MILHA || V_TEMP ;
      END IF;

      IF V_CONTADOR >= LENGTH(LTRIM(RTRIM(V_VALOR_1))) OR V_INDEX=1 THEN
         EXIT;
      END IF;

      V_CONTADOR := V_CONTADOR + 1;
      V_INDEX    := V_INDEX - 1;

    END LOOP;
    
    IF SUBSTR(V_TEMP,1,1) = RC_MOEDA.COD_CARAC_MILHA THEN
       V_TEMP := SUBSTR(V_TEMP,2);
    END IF;

    V_TEMP := V_TEMP || RC_MOEDA.COD_CARAC_DECIM || V_VALOR_2;
    V_TEMP := LPAD(V_TEMP,PE_TAMANHO,' ');

    RETURN( V_TEMP );

    EXCEPTION WHEN OTHERS THEN  
       RAISE_APPLICATION_ERROR(-20008,'FU_MASCA_VALOR ==>'||SQLERRM);

  END FU_MASCA_VALOR;
