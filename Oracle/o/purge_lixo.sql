SET LINES 200
SET PAGES 1000
COL ORIGINAL_NAME FORMAT A50
COL TYPE FORMAT A50

SELECT OWNER, ORIGINAL_NAME, TYPE FROM DBA_RECYCLEBIN;

PROMPT "Inicio da limpeza do lixo"
pause

declare

cursor c1 is SELECT OWNER, ORIGINAL_NAME, TYPE FROM DBA_RECYCLEBIN;

begin

	for rc1 in c1 loop
	  begin
			execute immediate 'PURGE '||RC1.TYPE||' '||RC1.OWNER||'.'||RC1.ORIGINAL_NAME; 
		exception when others then null;
		end;
	end loop;

end;
/
