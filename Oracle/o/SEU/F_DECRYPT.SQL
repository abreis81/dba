CREATE OR REPLACE FUNCTION SEU.F_DECRYPT (usuario in varchar2, codemp varchar2)
RETURN VARCHAR2
IS

 cReturn      varchar2(100);
 LR$Key       RAW(2000) := SEU.F_CHAVE();
 LR$DeCrypted   RAW(2048);
 LR$Base64    RAW(32767);
 LC$Source_ASM VARCHAR2(100);
 LR$Source_ASM RAW(128);
 existe       number := 0;
 encryption_type    PLS_INTEGER :=          -- total encryption type
                            DBMS_CRYPTO.ENCRYPT_3DES
                          + DBMS_CRYPTO.CHAIN_ECB
                          + DBMS_CRYPTO.PAD_PKCS5;

BEGIN
 
  select senha into LC$Source_ASM 
    from asm.func_ativos@seu_asm
   where chapa = usuario
     and empresa = codemp;
  
  begin
	LR$Base64 := UTL_I18N.STRING_TO_RAW(LC$Source_ASM);
	LR$Source_ASM := utl_encode.base64_decode (LR$Base64);
  LR$DeCrypted := dbms_crypto.decrypt(src => LR$Source_ASM,
  								typ => encryption_type, key => LR$Key);
  cReturn := utl_i18n.raw_to_char(LR$DeCrypted);
	return cReturn;
  exception when others then return '000000';
  end;
END;
/