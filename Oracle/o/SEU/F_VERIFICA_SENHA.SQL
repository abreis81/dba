CREATE OR REPLACE FUNCTION F_VERIFICA_SENHA (usuario IN VARCHAR2, senha IN VARCHAR2)
RETURN NUMBER
IS

    input_string     VARCHAR2(16) := senha;
    raw_input        RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(input_string,'AL32UTF8','WE8ISO8859P1'));
    key_string       VARCHAR2(8)  := 'S3U#0910';
    raw_key          RAW(128) := UTL_RAW.CAST_TO_RAW(CONVERT(key_string,'AL32UTF8','WE8ISO8859P1'));
    encrypted_raw    RAW(2048);
    encrypted_string VARCHAR2(2048);
    decrypted_raw    RAW(2048);
    decrypted_string VARCHAR2(2048); 
    
BEGIN
    select senha into encrypted_raw from teste_crypt where userid=usuario;
    decrypted_raw := dbms_crypto.Decrypt(
        src => encrypted_raw, 
        typ => DBMS_CRYPTO.DES_CBC_PKCS5, 
        key => raw_key);
    decrypted_string := 
    CONVERT(UTL_RAW.CAST_TO_VARCHAR2(decrypted_raw),'WE8ISO8859P1','AL32UTF8');
		dbms_output.put_line('> Decrypted string output          : ' || 
        decrypted_string);
		if input_string = decrypted_string THEN
    	RETURN 1;
    ELSE
    	RETURN 0;
		END if;

END;
/
