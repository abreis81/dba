declare
  v_x number := 0;

  procedure prc_edentar(vm1 varchar2, vm2 varchar2)
  is
   i     number := 1;
   v_ind number := 0;
   v_len number := 0;
   v_str varchar2(3200);
   vc number := 0;
   vn number := 0;
  begin
    v_len := length(vm2);
    while i < v_len loop
      if v_ind = 0 then
         dbms_output.put_line(rpad(nvl(vm1,' '),60)||' *'||substr(vm2,1,60));
         v_ind := 1;
      else
         dbms_output.put_line(lpad(' ',60)     ||'  '||substr(vm2,i,60));
      end if;
      i := i + 60;
    end loop;
  end prc_edentar;


begin


  ------------------------------------------------------------------------------------------------------
  ------------------------------------------------------------------------------------------------------
--    Login não mapeado
  declare
    vc number := 0;
    vn number := 0;
  begin
    select count(1) into vc
    from dba_users a
    where username not in 
    (
    select username
    from DBA_CHKLIST.LOGINS
    )
    order by username;
    if vc = 0 then
       null; -- dbms_output.put_line('Nenhum usuario nao mapeado................:  0');
     else
       for  r in (
                  select 
                  'insert into DBA_CHKLIST.LOGINS values (''NAO ESQUECER DE INCLUIR DADOS DO USUARIO.....'','''||
                  USERNAME ||''',null,'''|| ACCOUNT_STATUS ||''','''|| LOCK_DATE ||''','''||	EXPIRY_DATE
                  ||''','''|| DEFAULT_TABLESPACE ||''','''|| TEMPORARY_TABLESPACE ||''','''|| CREATED
                  ||''','''|| PROFILE ||''','''|| INITIAL_RSRC_CONSUMER_GROUP ||''');' logins
                  from dba_users
                  where username in (
                  select username
                  from dba_users a
                  where username not in 
                      (
                       select username
                       from DBA_CHKLIST.LOGINS
                       )
                       )order by username
                       )
                       loop
                 
             if vn = 0 then
               vn := 1;
               dbms_output.put_line('*** Usuario nao mapeado ***');
               dbms_output.put_line(' ');
               dbms_output.put_line('*** Por favor realizar o insert abaixo ***');
               dbms_output.put_line(' ');
--               prc_edentar('Nr. de login nao mapeado................: '|| lpad(vc,2),trim(r.logins));
               dbms_output.put_line(trim(r.logins));
            elsif vn < vc then
               dbms_output.put_line(trim(r.logins));
               vn := vn + 1;
            end if;  
            --) loop
        end loop;
    end if;
--  end ; 
      
       
        ----------------
        dbms_output.put_line('----------------------------------------------------------------------------------------------------------------');
        dbms_output.put_line(' Status de logins diferente ao da tabela LOGINS ');
        dbms_output.put_line(' Quantidade: '||lpad(vc,2) );
        ----------------
  end ;
  ------------------------------------------------------------------------------------------------------
--*/

  exception
  when others then
    dbms_output.put_line(sqlcode || ' - '|| sqlerrm);


--    end;
--end;    
    
end;

