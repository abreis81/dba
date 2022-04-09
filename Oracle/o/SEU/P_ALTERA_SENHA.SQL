CREATE OR REPLACE PROCEDURE P_ALTERA_SENHA (ra in varchar2,senha in varchar2)

IS

 LC$Source    VARCHAR2(100);
 LR$Source    RAW(128) := UTL_I18N.STRING_TO_RAW(senha);
 LR$Key       RAW(2000) := 'F2F13DB07332D9B345A42F4F2EB3FBC7EC2E2EA876A2922F';
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
  
  LC$Source_ASM := utl_i18n.raw_to_char(LR$Base64);
  update asm.senha_pessoal@perp set senha = LC$Source_ASM 
  where id = (select id from asm.pessoal@perp where chapa=ra);
  
END;
/