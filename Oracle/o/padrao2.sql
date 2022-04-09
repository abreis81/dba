set serveroutput on size 200000

declare

 cursor cons is select a.owner usuario
		,a.table_name tabela
		,a.constraint_name constraint
		,b.column_name coluna
	 from dba_constraints a, dba_cons_columns b
	 where b.owner='EDGE'
            and a.constraint_name=b.constraint_name
            and constraint_type='C'
ORDER BY TABELA,CONSTRAINT;

C_CONS CONS%ROWTYPE;

 contador number :=1;
 str varchar2(50);
 nm_coluna varchar2(30);
 begin

    OPEN CONS;
    FETCH CONS INTO C_CONS;  

--        for c_cons in cons 
  --	loop   

STR:=C_CONS.TABELA;

LOOP

EXIT WHEN CONS%NOTFOUND;

    		nm_coluna:=c_cons.coluna;

   		dbms_output.put_line(' ');
   		dbms_output.put_line('alter table '||c_cons.usuario||'.'||c_cons.tabela||
   		' drop constraint '||RTRIM(LTRIM(c_cons.constraint))||' ;');
   		dbms_output.put_line(' ');
   		dbms_output.put_line('alter table '||c_cons.usuario||'.'||c_cons.tabela||
   		' modify '||nm_coluna||' CONSTRAINT NN_'||c_cons.tabela||'_0'||contador||
   		' not null;'); 


FETCH CONS INTO C_CONS;

          	if str<>c_cons.tabela then
      			contador:=0;
         		str:=c_cons.tabela;

DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');

   		end if;
	contador:=contador + 1;

  	end loop;
 end;
/
