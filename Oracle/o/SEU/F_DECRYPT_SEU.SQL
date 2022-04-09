CREATE OR REPLACE FUNCTION SEU.F_DECRYPT_SEU (idusuario in number)
RETURN VARCHAR2
IS

 cReturn      varchar2(100);
 LR$Key       RAW(2000) := SEU.F_CHAVE();
 LR$DeCrypted   RAW(2048);
 LR$Base64    RAW(32767);
 LC$Source_SEU VARCHAR2(100);
 LR$Source_SEU RAW(128);
 existe       number := 0;
 encryption_type    PLS_INTEGER :=          -- total encryption type
                            DBMS_CRYPTO.ENCRYPT_3DES
                          + DBMS_CRYPTO.CHAIN_ECB
                          + DBMS_CRYPTO.PAD_PKCS5;

BEGIN
 
  select saad_senha into LC$Source_SEU 
    from seu.seuaad
   where saad_idusuario = idusuario;
  
  LR$Base64 := UTL_I18N.STRING_TO_RAW(LC$Source_SEU);
  LR$Source_SEU := utl_encode.base64_decode (LR$Base64);
  LR$DeCrypted := dbms_crypto.decrypt(src => LR$Source_SEU,typ => encryption_type, key => LR$Key);
  cReturn := utl_i18n.raw_to_char(LR$DeCrypted);
  return cReturn;
END;
/