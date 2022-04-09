set ver off
col tabela new_value tabela
ACCEPT TABLE_NAME PROMPT "TABELA: "
ACCEPT fk PROMPT "FK: "

select table_name  tabela from dba_constraints where OWNER='RONDA' AND constraint_name =(
select r_constraint_name from dba_constraints where table_name='&&TABLE_NAME' and
owner='RONDA' AND CONSTRAINT_TYPE='R' and constraint_name='&&FK')
/


SELECT COLUMN_NAME FROM DBA_CONS_COLUMNS WHERE OWNER='RONDA'
AND TABLE_NAME='&&tabela' AND CONSTRAINT_NAME 
= (SELECT CONSTRAINT_NAME FROM DBA_CONSTRAINTS WHERE TABLE_NAME='&&tabela'
AND CONSTRAINT_TYPE='P' AND OWNER='RONDA')
/