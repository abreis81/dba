SET ECHO OFF
SET PAGES 55 
SET LINES 80
SET FEEDBACK OFF
--
COL GRANTEE          HEADING User_or_Role         FORMAT A30 
COL GRANTED_ROLE     HEADING Role                 FORMAT A20 
COL DEFAULT_ROLE     HEADING Default              FORMAT A7 
COL ADMIN_OPTION     HEADING Admin                FORMAT A5 
COL OBJECT           HEADING SCHEMA.TABLE.COLUMN  FORMAT A50 
COL PRIVILEGE                                     FORMAT A20 
--
col p_temp1 new_value                   p_data      noprint
col p_temp2 new_value                   p_traco     noprint
col p_temp3 new_value                   p_database  noprint
col p_temp4 new_value                   p_spool     noprint
col p_temp5 new_value                   p_block     noprint
--
define p_sql       = lst_privilegio
define p_tam_linha = 80
define p_fmt_data  = '&&p_fmt_data'
define p_dir_spool = &&p_dir_spool
--
set termout off
--
spool lst_privilegio
--
select '&&p_dir_spool.&&p_sql.'||'.'||lower(name)  p_temp4
      ,lower(name)                                 p_temp3
      ,to_char(sysdate,'YYYY-MM-DD')               p_temp1
      ,rpad('*', 80,'*')                           p_temp2	
  from v$database
/
set termout on
--
ttitle left p_traco skip -
       left p_data -
       right format 999 'Pag.: ' sql.pno skip 2 -
       center 'Roles assinaladas para cada usuario' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off
  select grantee
        ,granted_role
        ,default_role
        ,admin_option
    from dba_role_privs 
   where grantee not in ('SYS','SYSTEM')
order by grantee, granted_role; 



ttitle left p_traco skip -
       left p_data -
       right format 99 'Pag.: ' sql.pno skip 2 -
       center 'Usuarios assinalados para cada role' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off
  select grantee
        ,default_role
        ,admin_option
    from dba_role_privs 
   where grantee not in ('SYS','SYSTEM') 
order by granted_role
        ,grantee; 





ttitle left p_traco skip -
       left p_data -
       right format 99 'Pag.: ' sql.pno skip 2 -
       center 'Table grants para roles ou usuarios' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off
select grantee
      ,owner||'.'||table_name||'.'||column_name object
      ,privilege
  from sys.dba_col_privs 
 union
  select grantee
        ,owner||'.'||table_name object
        ,privilege
    from sys.dba_tab_privs 
order by grantee
        ,object; 





ttitle left p_traco skip -
       left p_data -
       right format 99 'Pag.: ' sql.pno skip 2 -
       center 'Table grants dados diretamente para usuarios ou por roles' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off
select grantee
      ,to_char(null) granted_role
      ,owner||'.'||table_name||'.'||column_name object
      ,privilege 
  from sys.dba_col_privs
      ,dba_users 
 where grantee=username
   and grantee not in ('SYS','SYSTEM') 
 union
 select grantee
       ,to_char(null) granted_role
       ,owner||'.'||table_name object
       ,privilege 
  from sys.dba_tab_privs
      ,dba_users 
 where grantee=username
   and grantee not in ('SYS','SYSTEM') 
 union
select r.grantee
      ,granted_role
      ,owner||'.'||table_name||'.'||column_name object
      ,privilege 
  from sys.dba_col_privs p
      ,sys.dba_role_privs r 
 where p.grantee=r.granted_role
   and r.grantee not in ('SYS','SYSTEM') 
 union
  select r.grantee
        ,granted_role
        ,owner||'.'||table_name object
        ,privilege 
    from sys.dba_tab_privs p
        ,sys.dba_role_privs r 
   where p.grantee=r.granted_role
     and r.grantee not in ('SYS','SYSTEM') 
order by grantee
        ,object; 







ttitle left p_traco skip -
       left p_data -
       right format 99 'Pag.: ' sql.pno skip 2 -
       center 'Table grants assinalados para PUBLIC' skip 2 -
       left '&&p_sql' -
       right sql.user@&&p_database skip -
       left p_traco skip 2
btitle off
select owner||'.'||table_name||'.'||column_name object
      ,privilege 
  from sys.dba_col_privs
 where grantee='PUBLIC' 
 union
  select owner||'.'||table_name object
        ,privilege 
    from sys.dba_tab_privs
   where grantee='PUBLIC' 
order by object; 

spool off
TTITLE OFF
SET ECHO ON
SET PAGES 55 
SET LINES 80
SET FEEDBACK ON

