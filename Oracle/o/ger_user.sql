rem 
rem  nome        : ger_user.sql
rem  objetivo    : Script de criacao de usuarios
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem 

col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint

define p_sql       = ger_user
define p_titulo    = 'Script de Criacao de Usuarios'
define p_tam_linha = 1000
define p_linhas    = 0
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
define p_termout   = on

set termout off
select '&&p_dir_spool.&&p_sql.'||'.'||lower(name)  p_temp4
      ,lower(name)                                 p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')               p_temp1
      ,rpad('*', 80 ,'*')                          p_temp2	
  from v$database
/

set termout on

rem
rem	Identificacao do relatorio
rem

clear screen
prompt
prompt Script : &&p_sql.
prompt Titulo : &&p_titulo.
prompt
prompt Spool  : &&p_spool.
prompt Report : &&p_tam_linha. colunas
prompt &&p_traco.
prompt 

rem
rem	Solicitacao de parametros
rem
accept p_user    prompt "Username........ ? [%] "

rem
rem	Inicio do relatorio
rem
clear screen
prompt Aguarde...

rem
rem	Configurar SQL*PLUS
rem
set serveroutput on size 1000000
set pages &&p_linhas. 
set lines &&p_tam_linha.
set verify off
set feedback off
set trimspool on 
clear screen
set termout &&p_termout.

spool &&p_spool.

declare

cursor cursor_user is 
  select username
        ,password
        ,default_tablespace
        ,temporary_tablespace
        ,profile
    from dba_users
   where username not in ('SYS','PUBLIC','SYSTEM')
     and username like upper(decode('&&p_user','','%','&&p_user'));

cursor cursor_role (p_user varchar) is
  select granted_role
        ,admin_option
        ,default_role
    from dba_role_privs
   where grantee = p_user;

cursor cursor_quotas (p_user varchar) is
  select tablespace_name
        ,max_bytes
    from dba_ts_quotas
   where username = p_user;

cursor cursor_sys_privs (p_user varchar) is
   select privilege
         ,admin_option
     from dba_sys_privs
    where grantee = p_user;

v_default_role varchar2(2000);

begin

  for reg_user in cursor_user loop

      v_default_role :='';

      dbms_output.put_line('---');
      dbms_output.put_line('---');
      dbms_output.put_line('rem');
      dbms_output.put_line('rem User '||reg_user.username);
      dbms_output.put_line('rem');
      dbms_output.put_line('create user '||reg_user.username||' identified by values '||''''||reg_user.password||'''');
      dbms_output.put_line('default tablespace '||reg_user.default_tablespace);
      dbms_output.put_line('temporary tablespace '||reg_user.temporary_tablespace);
      dbms_output.put_line('profile '||reg_user.profile||';');

      dbms_output.put_line('rem');
      dbms_output.put_line('rem Privilegios por role');
      dbms_output.put_line('rem');

      for reg_role in cursor_role (reg_user.username) loop

          if reg_role.admin_option = 'YES' then 
             dbms_output.put_line('grant '||reg_role.granted_role||' to '||reg_user.username||' wint admin option;' );
          else
             dbms_output.put_line('grant '||reg_role.granted_role||' to '||reg_user.username||';' );
          end if;

          if reg_role.default_role = 'YES' then
             v_default_role := v_default_role || reg_role.granted_role || ',';
          end if;

      end loop;

      dbms_output.put_line('rem');
      dbms_output.put_line('rem Privilegios diretos');
      dbms_output.put_line('rem');
      for reg_sys in cursor_sys_privs (reg_user.username) loop
          dbms_output.put_line('grant '||reg_sys.privilege||' to '||reg_user.username||';');
      end loop;

      dbms_output.put_line('rem');
      dbms_output.put_line('rem Quotas');
      dbms_output.put_line('rem');
      for reg_quota in cursor_quotas (reg_user.username) loop 
          dbms_output.put_line('alter user '||reg_user.username||' quota '||to_char(reg_quota.max_bytes)||' on '||reg_quota.tablespace_name||';');
      end loop;

      dbms_output.put_line('rem');
      dbms_output.put_line('rem Default Role');
      dbms_output.put_line('rem');
      dbms_output.put_line('alter user '||reg_user.username||' default role '||substr(v_default_role,1,length(v_default_role)-1)||';');

  end loop;

end;
/

rem
rem	Fim do relatorio
rem
spool off
clear break
clear columns
clear compute
ttitle off
set termout on
set verify on
set feedback on
set trimspool off
