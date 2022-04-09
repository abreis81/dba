rem 
rem  nome        : lst_role_obj.sql
rem  objetivo    : Roles x privilegios de objeto
rem  uso         : sqlplus ou similar 
rem  limitacoes  : dba
rem 

rem
rem     Configurar Relatorio
rem

col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint
--
define p_sql       = lst_role_obj
define p_titulo    = 'Roles x privilegios de objeto'
define p_tam_linha = 90
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
--
set termout off
--
select '&&p_dir_spool.&&p_sql.'||'.'||lower(name) p_temp4
      ,lower(name)                                p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')              p_temp1
      ,rpad('*', 80,'*')                          p_temp2	
  from v$database
/
set termout on

rem
rem	Identificacao do relatorio
rem
prompt
prompt Script : &&p_sql.
prompt Titulo : &&p_titulo.
prompt
prompt Spool  : &&p_spool.
prompt Report : &&p_tam_linha. colunas
prompt &&p_traco.
prompt 
clear screen

rem
rem	Solicitacao de parametros
rem
accept p_role    prompt "Role............ ? [%] "
accept p_linhas  prompt "Nr. de linhas... ? [0] "
accept p_termout prompt "Termout (on/off) ? [ ] "

rem
rem	Configurar SQL*PLUS
rem
set pages &&p_linhas 
set lines &&p_tam_linha 
set verify off
set feedback off
set termout &&p_termout.
set serveroutput on size 1000000
--
spool &&p_spool.
--
rem
rem	Header e Footer
rem
ttitle left p_traco skip -
       left p_data -
       right format 999 'Pag.: ' sql.pno skip 2 -
       center '&&p_titulo' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off

declare 

cursor cursor_leitura is
  select grantee
        ,owner
        ,table_name
        ,grantor
        ,privilege
        ,grantable
    from sys.dba_tab_privs a
        ,dba_roles b
   where a.grantee = b.role 
     and a.grantee like upper(decode('&&p_role','','%','&&p_role'))
order	by grantee
        ,owner
        ,table_name
        ,privilege;

v_col_table 	number := 27;
v_col_owner	      number := 10;
v_col_grantee	number := 20;
v_col_priv        number := (&&p_tam_linha-3)-(v_col_grantee+v_col_owner+v_col_table);

v_table_name	dba_tab_privs.table_name%type := 'dummy';
v_grantee         dba_tab_privs.grantee%type    := 'dummy';
v_owner		dba_tab_privs.owner%type      := 'dummy';

begin

  dbms_output.put(rpad('Usuario',v_col_grantee)||' ');
  dbms_output.put(rpad('Owner',v_col_owner)||' ');
  dbms_output.put(rpad('Tabela',v_col_table)||' ');
  dbms_output.put_line(rpad('Privilegios',v_col_priv));

  dbms_output.put(rpad('-',v_col_grantee,'-')||' ');
  dbms_output.put(rpad('-',v_col_owner,'-')||' ');
  dbms_output.put(rpad('-',v_col_table,'-')||' ');
  dbms_output.put_line(rpad('-', v_col_priv,'-'));

  for reg in cursor_leitura loop

      if v_grantee != reg.grantee then
         v_grantee    := reg.grantee;
         v_table_name := 'dummy';
         v_owner      := reg.owner;
         v_table_name := reg.table_name;

         dbms_output.put_line(' ');
         dbms_output.put(rpad(v_grantee,v_col_grantee)||' ');
         dbms_output.put(rpad(v_owner,v_col_owner)||' ');
         dbms_output.put(rpad(v_table_name,v_col_table)||' ');
      end if;

      if v_owner != reg.owner then
         v_owner := reg.owner;
         v_table_name := reg.table_name;

         dbms_output.new_line;
         dbms_output.put(rpad('.',v_col_grantee)||' ');
         dbms_output.put(rpad(v_owner,v_col_owner)||' ');
         dbms_output.put(rpad(v_table_name,v_col_table)||' ');
      end if;

      if v_table_name != reg.table_name then
         v_table_name := reg.table_name;

         dbms_output.new_line;
         dbms_output.put(rpad('.',v_col_grantee+1));
         dbms_output.put(rpad('.',v_col_owner+1));
         dbms_output.put(rpad(v_table_name,v_col_table)||' ');
      end if;

      dbms_output.put(substr(reg.privilege,1,3)||' ');
	
  end loop;

  dbms_output.new_line;
  dbms_output.put(rpad('.',v_col_grantee+1));
  dbms_output.put(rpad('.',v_col_owner+1));
  dbms_output.put(rpad(v_table_name,v_col_table)||' ');

end;
/

rem
rem	Fim do Relatorio
rem
spool off
clear columns
clear break
clear compute
set termout on
set verify on
set feedback on
ttitle off

