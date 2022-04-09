select 'grant '||privilege||' on '||owner||'.'||table_name||' to '||grantee||decode(grantable,'YES',' WITH GRANT OPTION;',';')

FROM DBA_TAB_PRIVS WHERE GRANTEE IN ('FINPAC_INTERF','FINPAC_WEB');
