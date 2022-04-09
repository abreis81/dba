CREATE OR REPLACE FUNCTION SEU.F_SENHA_CRYPTO(senha in varchar2)
RETURN VARCHAR2
is
	senha_crypto varchar2(500);
begin
	senha_crypto := f_encrypt (upper(senha),'TESTECONEXAOPORTALUNINO9');
	return senha_crypto;
end;
/