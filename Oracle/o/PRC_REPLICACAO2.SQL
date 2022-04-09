CREATE OR REPLACE PROCEDURE PRC_REPLICACAO2( PE_DIRETORIO IN VARCHAR2 DEFAULT '/ora01/dba/log'
                                           ,PE_TXT       IN VARCHAR2 
					   ,PE_TABELA    IN VARCHAR2 ) IS

Cursor c_cons(tabela in varchar2) is 
 select a.column_name coluna from dba_cons_columns a, dba_constraints b 
   where a.table_name=tabela 
	 and a.constraint_name=b.constraint_name
	 and b.constraint_type='P' order by a.position;

V_TEXTO UTL_FILE.FILE_TYPE;
V_LINHA NUMBER := 0;

type a_matriz is
  array(50) of varchar2(100);

A_TEXTO    A_MATRIZ := A_MATRIZ();

STR VARCHAR2(2000);
STR2 VARCHAR2(2000) := '';
CONTADOR NUMBER :=1;  
BEGIN
  str:='DECLARE';
  str:= str||'
  '||'      pe_diretorio varchar2(50) := '||''''||pe_diretorio||''''||';'||'
  '||'      pe_txt varchar2(50) := '||''''||pe_tabela||'_STA.txt'||''''||';'||'
  '||'      pe_tabela varchar2(50) := '||''''||pe_tabela||''''||';';
  str:=str||'
	cursor c_pk is select * from '||pe_tabela||';'||'

	V_TEXTO UTL_FILE.FILE_TYPE;
        V_LINHA NUMBER := 0;

        TYPE A_MATRIZ IS
        ARRAY(120000) OF VARCHAR2(100);

	A_TEXTO    A_MATRIZ := A_MATRIZ();
	
BEGIN

	V_TEXTO := UTL_FILE.FOPEN(PE_DIRETORIO, PE_TXT,'||''''||'W'||''''||');
	
        FOR RC_PK IN C_PK LOOP

        A_TEXTO.EXTEND;
        V_LINHA := V_LINHA + 1;';
	str2:='a_texto(v_linha) := rc_pk.';
   for rc_cons in c_cons(pe_tabela) loop
	if contador = 1 then
		str2:= str2||rc_cons.coluna;
		contador:=contador + 1;
	else
	str2:=str2||'||'||''''||' '||''''||'||'||'rc_pk.'||rc_cons.coluna;
	end if;
   end loop;
   str2:=str2||';';
   str:=str||'
	'||str2||'
	'||'
	IF V_LINHA > 100000 THEN

         FOR I IN 1..V_LINHA LOOP
             UTL_FILE.PUT_LINE(V_TEXTO, A_TEXTO(I) );
         END LOOP;

         V_LINHA := 0;
                  
      END IF;

  END LOOP;

  IF V_LINHA > 0 THEN

     FOR I IN 1..V_LINHA LOOP
         UTL_FILE.PUT_LINE(V_TEXTO, A_TEXTO(I) );
     END LOOP;
                 
  END IF;

  UTL_FILE.FCLOSE( V_TEXTO );

EXCEPTION
  WHEN OTHERS THEN
    UTL_FILE.PUT_LINE(V_TEXTO,'||''''||'PROBLEMA NA GERACAO DO ARQUIVO'||''''||');
    UTL_FILE.FCLOSE(V_TEXTO);

END;
/';


  V_TEXTO := UTL_FILE.FOPEN( PE_DIRETORIO, PE_TXT, 'W' );
  UTL_FILE.PUT_LINE(V_TEXTO, str);
  UTL_FILE.FCLOSE( V_TEXTO );

END;
/
SHOW ERRORS
