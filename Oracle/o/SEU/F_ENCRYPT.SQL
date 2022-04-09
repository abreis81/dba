CREATE OR REPLACE FUNCTION SEU.F_ENCRYPT (usuario in varchar2,senha in varchar2,codemp varchar2)
RETURN VARCHAR2
IS

 cReturn      varchar2(100);
 LC$Source    VARCHAR2(100);
 LR$Source    RAW(128) := UTL_I18N.STRING_TO_RAW(upper(senha));
 LR$Key       RAW(2000) := SEU.F_CHAVE();
 LR$Crypted   RAW(2048);
 LR$Base64    RAW(32767);
 LC$Source_ASM VARCHAR2(100);
 LR$Source_ASM RAW(128);
 existe       number := 0;
 encryption_type    PLS_INTEGER :=          -- total encryption type
                            DBMS_CRYPTO.ENCRYPT_3DES
                          + DBMS_CRYPTO.CHAIN_ECB
                          + DBMS_CRYPTO.PAD_PKCS5;

BEGIN

  LR$Crypted := dbms_crypto.encrypt(src => LR$Source,
  typ => encryption_type, key => LR$Key);
  LR$Base64 := utl_encode.base64_encode(LR$Crypted);
  
  IF (TRIM(usuario) IS NOT NULL) THEN
      Begin
            select senha into LC$Source_ASM 
              from asm.func_ativos@seu_asm
             where chapa = usuario
               and empresa = codemp;
               
               LR$Source_ASM := UTL_I18N.STRING_TO_RAW(LC$Source_ASM);
               IF LR$Source_ASM = LR$Base64 THEN
                  cReturn := utl_i18n.raw_to_char(LR$Base64);
               ELSE
                  cReturn:= 'NAO AUTORIZADO';
               END IF;
      Exception 
          When no_data_found Then
            cReturn:= 'NAO AUTORIZADO';
      End;               

  ELSE
      cReturn := utl_i18n.raw_to_char(LR$Base64);     
  END IF;

  return cReturn;

END;
/