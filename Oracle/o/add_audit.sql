/*
  script:   add_audit.sql
  objetivo: auditoria no banco
  autor:    Josivan
  data:     

  o oracle guarda o resultado da auditoria realizada no dicionario de dados, tendo como
  principal DBA_AUDIT_TRAIL. as demais sao variacoes desta view.

  bibliotecas: DBA_AUDIT_TRAIL
                   USER_AUDIT_SESSION
                   DBA_AUDIT_SESSION
                   USER_AUDIT_STATEMENT
                   DBA_AUDIT_STATEMENT
                   USER_AUDIT_OBJECT
                   DBA_AUDIT_OBJECT
                   --
                   USER_OBJ_AUDIT_OPTS
                   DBA_OBJ_AUDIT_OPTS
                   USER_TAB_AUDIT_OPTS
                   DBA_STMT_AUDIT_OPTS
                   AUDIT_ACTIONS
                   ALL_DEF_AUDIT_OPTS
                   DBA_AUDIT_EXISTS
                   STMT_AUDIT_OPTION_MAP
 
  observacao:  no INIT.ORA alterar o parametro:
               AUDIT_TRAIL = DB / TRUE
               AUDIT_FILE_DEST = '/usr/.......'    para UNIX
               para apagar as vistas auxiliares deve executar o script 
               CATNOAUD.SQL sobre o usuario SYS

            privilegio sobre comando de sistema
           /
          /
auditoria/______ opcao de sistema   ou   atalho
         \
          \
           \privilegio sobre objeto


*/

--
-- auditoria sobre privilegios de sistema
--
audit drop any table
     ,create any table 
   by access
   by jjsantos
     ,erdias
     ,elazevedo
whenever not successful
/

noaudit drop any table
       ,create any table 
     by access
     by jjsantos
       ,erdias
       ,elazevedo
/

noaudit all
 by cta_facil
/

--
-- auditoria sobre privilegios de objetos
--
audit all | select,update,delete
 on galpdba.trans_abast | on directory <nome_do_diretorio_os> | on default
by access | by session
whenever not successul
/

noaudit all
  on galpdba.trans_abast
by access
/
 
