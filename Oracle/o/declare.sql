declare
 contador number:=0;
 begin
  while contador < 10 LOOP
   INSERT INTO scott.epm_aux(EMPNO) VALUES (CONTADOR +1);
    CONTADOR := CONTADOR+1;
  END LOOP;
 END;
 /




declare
contador number:=0;
begin
  while contador < 1 loop
    insert into scott.epm_aux(select * from scott.emp);
    contador:=contador+1;
  end loop;
end;

