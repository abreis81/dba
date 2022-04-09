CREATE OR REPLACE FUNCTION SEU.F_ENCRYPT_SENHA (usuario in number,senha in varchar2)
RETURN VARCHAR2
IS

 LC$Source    VARCHAR2(100);
 LR$Source    RAW(128) := UTL_I18N.STRING_TO_RAW(senha);
 LR$Key       RAW(2000) := utl_raw.cast_to_raw('TESTECONEXAOPORTALUNINO9');
 LR$Crypted   RAW(2048);
 LR$Base64    RAW(32767);
 LC$Source_ASM VARCHAR2(100);
 LR$Source_ASM RAW(128);
 encryption_type    PLS_INTEGER :=          -- total encryption type
                            DBMS_CRYPTO.ENCRYPT_3DES
                          + DBMS_CRYPTO.CHAIN_ECB
                          + DBMS_CRYPTO.PAD_PKCS5;

BEGIN

  LR$Crypted := dbms_crypto.encrypt(src => LR$Source,
  typ => encryption_type, key => LR$Key);
  LR$Base64 := utl_encode.base64_encode(LR$Crypted);
  
  select senha into LC$Source_ASM from asm.senha_pessoal@seu_asm where id=usuario;
  LR$Source_ASM := UTL_I18N.STRING_TO_RAW(LC$Source_ASM);
  
  IF LR$Source_ASM = LR$Base64 then
  	return utl_i18n.raw_to_char(LR$Base64);
  ELSE
  	return 'NAO AUTORIZADO';
  END IF;
  
END;
/