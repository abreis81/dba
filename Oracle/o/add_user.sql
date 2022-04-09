/*
  script:   add_user.sql
  objetivo: criar usuarios
  autor:    Josivan
  data:     
  bibliotecas: DBA_USERS               - todos usuarios do banco
               DBA_TS_QUOTAS           - quotas estabelecidas para cada usuario
               V$SESSION               - sessoes criadas na base ( dinamicamente )
               V$SESSION_CONNECT_INFO  - metodo de autenticacao usuado para cada usuario ( dinamicamente )  
   
  observacao:  alterar no INIT.ORA o parametro:
               OS_AUTHENT_PREFIX<nome_do_usuario_sistema_operacional>

  aplicacao:   um usuario autenticado pelo sistema operacional no ORACLE pode ser atribuido
               a operacao que a execucao de processos batch durante a noite, este usuario
               nao precisara informar password ao conectar-se ao SQLPLUS para rodar as 
               stored procedures,function,packages,triggers e etc...

               Se a autenticacao for via WINDOWS NT criar um grupo ORA_USER e colocar os
               usuarios como membros deste grupo. E no INIT.ORA do Banco alterar o parametro
               OS_AUTHENT_PREFIX para '' ( apostrofo, apostrofo ) de modo que o banco tera
               o mesmo no que o sistema operativo ( sem a necessidade do OPS$ ).


  VER O ARQUIVO PASSWORDS.SQL


*/

         create user galpdba
       identified by teste    /  EXTERNALLY   /   globally
  default tablespace ts_dados
temporary tablespace ts_temp
  quota unlimited on ts_dados
  quota unlimited on ts_indice
  quota unlimited on ts_temp
             profile default
/

grant create session to galpdba
/

alter user josivan
identified EXTERNALLY
/

grant application_owner to &&username
/

grant application_user to &&username
/

grant update any table to &&username
/

drop user josivan cascade
/
