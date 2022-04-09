set serveroutput on size 20000
declare
 cursor cons is select * from dba_constraints where owner='BRDBA'
         and constraint_type='C';
 contador number :=1;
 str varchar2(50) := 'TBDBA_QUERY_CAPTURADA';
 cond varchar2(50);
 begin
  
         for c_cons in cons 
  loop   
    cond:=c_cons.search_condition;
   dbms_output.put_line(' ');
   dbms_output.put_line('alter table '||c_cons.owner||'.'||c_cons.table_name||
   ' drop constraint '||c_cons.constraint_name||' ;');
   dbms_output.put_line(' ');
   dbms_output.put_line('alter table '||c_cons.owner||'.'||c_cons.table_name||
   ' add constraint NN_'||c_cons.table_name||'_0'||contador||
   ' check ('||cond||');'); 
   contador:=contador + 1;
          if str<>c_cons.table_name then
      contador:=1;
   end if;
   str:=c_cons.table_name;
  end loop;
 end;
 /
