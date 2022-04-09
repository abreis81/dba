select 'grant '||privilege||' on siga.'||table_name||' to '||grantee||

decode(grantable,'YES',' WITH GRANT OPTION;',';')

from dba_tab_privs

where owner='SIGA'

and table_name like 'SR%'
