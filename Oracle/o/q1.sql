declare

q number := 0;

begin

  for n in 8101..8200 loop

      insert into ocpedba.clientes
      values('P',lpad(n,6,'0'),n);

      q := q + 1;

      if q > 100 then
         commit;
         q:=0;
      end if;


  end loop;

end;
/
