Declare
cNewCodigo varchar2(6);
Cursor vSEUABK Is
    SELECT SABK_IDEMPRESA, SABK_CODIGO, SABK_IDUSUARIO
      FROM SEU.SEUABK a
     WHERE SABK_IDUSUARIO <> 1
       AND ( SABK_IDEMPRESA, SABK_CODIGO)  in (SELECT SABK_IDEMPRESA, SABK_CODIGO 
                                                 FROM SEU.SEUABK
                                             GROUP BY SABK_IDEMPRESA, SABK_CODIGO
                                               HAVING COUNT(*) > 1 );
Begin
  For rSEUABK In vSEUABK Loop
    Begin
    select seu.SEQ_SEUABK_INSERT.nextval into cNewCodigo from dual;
    
    UPDATE SEU.SEUABI 
       SET SABI_CODHOR = '000'||cNewCodigo
     WHERE SABI_IDEMPRESA = rSEUABK.SABK_IDEMPRESA
       AND SABI_CODHOR    = rSEUABK.SABK_CODIGO
       AND SABI_IDUSUARIO = rSEUABK.SABK_IDUSUARIO;
       
       
    UPDATE SEU.SEUABK
       SET SABK_CODIGO = '000'||cNewCodigo
     WHERE SABK_IDEMPRESA = rSEUABK.SABK_IDEMPRESA
       AND SABK_CODIGO    = rSEUABK.SABK_CODIGO
       AND SABK_IDUSUARIO = rSEUABK.SABK_IDUSUARIO;
       
    End;
    COMMIT;
   End Loop;
End;