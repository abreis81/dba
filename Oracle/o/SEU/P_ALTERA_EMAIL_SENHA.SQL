create or replace procedure seu.p_altera_email_senha (
IDEMPRESA     in number         
,MATRICULA    in varchar2          
,EMAIL        in varchar2 default null        
,SENHA        in varchar2 default null
,SAIDA				out varchar2)

is

v_flag_email number :=0;
v_flag_senha number :=0;
ret varchar(20);

begin
  if email is not null then
    case idempresa
    	when '4' then
				update siga.sra040 set ra_email = email where ra_mat=matricula;
				v_flag_email := v_flag_email + sql%rowcount;
			when '6' then                       
				update siga.sra020 set ra_email = email where ra_mat=matricula;
				v_flag_email := v_flag_email + sql%rowcount;
			when '7' then                       
				update siga.sra030 set ra_email = email where ra_mat=matricula;
				v_flag_email := v_flag_email + sql%rowcount;
			else                                                 
				update siga.sra010 set ra_email = email where ra_mat=matricula;
				v_flag_email := v_flag_email + sql%rowcount;
		end case;
	end if;
	
	if v_flag_email > 0 then
		ret := 'EMAIL';
	end if;
	
	if senha is not null then
    case idempresa
    	when '4' then
				update siga.sra040 set ra_senha = senha where ra_mat=matricula;
				v_flag_senha := v_flag_senha + sql%rowcount;
			when '6' then                       
				update siga.sra020 set ra_senha = senha where ra_mat=matricula;
				v_flag_senha := v_flag_senha + sql%rowcount;
			when '7' then                       
				update siga.sra030 set ra_senha = senha where ra_mat=matricula;
				v_flag_senha := v_flag_senha + sql%rowcount;
			else                                
				update siga.sra010 set ra_senha = senha where ra_mat=matricula;
				v_flag_senha := v_flag_senha + sql%rowcount;
		end case;
	end if;
	
	if v_flag_senha > 0 then
		ret := ret||' SENHA';
	end if;
	
	if email is null and senha is null then
		null;
	end if;
	
	if ret is null then
		 ret := '0';
	end if;
	commit;
	saida := ret;
end ;
/
	
                                 
                                 