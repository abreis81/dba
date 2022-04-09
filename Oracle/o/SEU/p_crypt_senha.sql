CREATE OR REPLACE PROCEDURE P_CRYPT_SENHA (usuario IN VARCHAR2, senha IN VARCHAR2)
IS

    input_string     VARCHAR2(16) := senha;
    raw_input        RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(input_string,'AL32UTF8','WE8ISO8859P1'));
    key_string       VARCHAR2(100) := 'TESTECONEXAOPORTALUNINO9';
    raw_key          RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(key_string,'AL32UTF8','WE8ISO8859P1'));
    encrypted_raw    RAW(2048);
    encrypted_string VARCHAR2(2048);
    
BEGIN
		encrypted_raw := dbms_crypto.Encrypt(
        src => raw_input, 
        typ => DBMS_CRYPTO.ENCRYPT_3DES_2KEY + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5,
        key => raw_key);
    insert into teste_crypt values (usuario, encrypted_raw);
    
    commit;
END;
/

CREATE OR REPLACE PROCEDURE P_DECRYPT_SENHA
IS

    output_string    VARCHAR2(50);
    --raw_input        RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(input_string,'AL32UTF8','WE8ISO8859P1'));
    key_string       VARCHAR2(100) := 'TESTECONEXAOPORTALUNINO9';
    raw_key          RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(key_string,'AL32UTF8','WE8ISO8859P1'));
    DEcrypted_raw    RAW(2048);
    encrypted_string VARCHAR2(2048);
    rIV raw(8);
    
BEGIN
	rIV := hextoraw('0000000000000000');
	for rc1 in (select * from teste_crypt) loop
	  
		DEcrypted_raw := dbms_crypto.DEcrypt(
        src => rc1.SENHA, 
        typ => DBMS_CRYPTO.ENCRYPT_3DES_2KEY + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5, 
        key => raw_key);  
        output_string := utl_i18n.raw_to_char(data => DEcrypted_raw,
                                           src_charset => 'AL32UTF8');
    dbms_output.put_line( output_string);
	end loop;
END;
/
