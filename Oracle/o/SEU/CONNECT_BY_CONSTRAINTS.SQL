CREATE TABLE DBA_CONSTRAINTS_TMP AS SELECT OWNER, TABLE_NAME, CONSTRAINT_NAME, R_OWNER, R_CONSTRAINT_NAME
FROM DBA_CONSTRAINTS WHERE OWNER='SEU';

SELECT lpad(' ',2*level-1)||SYS_CONNECT_BY_PATH(a.tabela,'/')full_path
	from (SELECT CONNECT_BY_ROOT table_name root , table_name tabela
	FROM dba_constraints_tmp a
	WHERE A.owner='SEU'
	AND R_OWNER='SEU'
	and level > 1
	CONNECT BY PRIOR constraint_name = r_constraint_name ) a
START WITH a.tabela = 'SEUAAA'
CONNECT BY PRIOR a.tabela=a.root;