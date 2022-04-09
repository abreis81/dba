/*
  script:   add_role.sql
  objetivo: criar roles
  autor:    Josivan
  data:     

  bibliotecas: DBA_SYS_PRIVS        - todos os privilegios de sistema concedidos a usuarios e roles
              (SESSION_PRIVS        - nome de todos os privilegios e roles atribuidos a sessao
               SESSION_ROLES)   
               DBA_TAB_PRIVS (PAI)  - todos os privilegios de objetos atribuidos a usuarios e roles
               DBA_COL_PRIVS (FILHO)- nome de todas as colunas envolvidas em privilegios de objetos atribuidos a usuarios e roles
               DBA_ROLES            - nome de todas as roles criados na base
               DBA_ROLE_PRIVS       - nome de todos os roles e usuarios a quem foram atribuidos roles
               ROLE_ROLE_PRIVS      - nome de todos os roles que foram atribuidos a roles que o usuario pode acessar
               ROLE_SYS_PRIVS       - privilegio de sistema que foram atribuidos a roles a que o usuario pode acessar
               ROLE_TAB_PRIVS       - privilegio de objeto que foram atribuidos a roles a que o usuario pode acessar

  role padrao: CONNECT              - CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE SYNONYM, CREATE DATABASE LINK, CREATE CLUSTER E ALTER SESSION 
               RESOURCE             - CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER e acesso ilimitado sobre todos os tablespaces 
               DBA                  - todos os privilegios de sistema e quota ilimitada sobre todos os tablespaces 
               EXP_FULL_DATABASE    - SELECT ANY TABLE, BACKUP ANY TABLE e INSERT, DELETE, UPDATE nas tabelas SYS.INCVID, SYS.INCFIL e SYS.INCEXP 
               IMP_FULL_DATABASE    - importar um ficheiro exportado de qualquer base atraves do privilegio BECOME USER 
               SELECT_CATALOG_ROLE  - permite consulta de todas as tabelas e vistas do dicionario de dados mesmo as que comecam por DBA_
               DELETE_CALATOG_ROLE  - permite remover registros em tabelas dos dicionario de dados
               EXECUTE_CATALOG_ROLE - permite execucao de qualquer package do dicionario de dados
               CREATE_TYPE          - so possivel quando instalado o OBJECT OPTION. permite a criacao de tipos, CREATE TYPE, EXECUTE ANY TYPE, ADMIN OPTION, GRANT OPTION  
               
   observacao: para criar uma ROLE devera cumprir 3 etapas
              1-criar a role
              2-carregar com os privilegios
              3-atribuir ao usuario ou role
*/

create role rl_usuario
identified by teste   /  EXTERNALLY   /  globally
/

grant create session to rl_usuario;
grant select,update,delete on galpdba.trans_abast to rl_usuario
with admin option
/

grant rl_usuario to josivan
/

alter user josivan
default role role3
/

alter user josivan
default role all except role 5
/

alter user josivan
default role none
/

set role all except role 7
/

alter role role5 not identified
/

drop role role5
/

