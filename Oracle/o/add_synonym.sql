/*
  script:   add_synonym.sql
  objetivo: criar sinonimos para os objetos que ainda nao tem
  autor:    Josivan
  data:     
*/
--
set echo off
set verify off
set feedback off
set heading off
--
clear screen
--
accept v_owner prompt "Proprietario do Objeto ? "
accept v_user  prompt "Utilizador do Objeto   ? "
--
spool add_synonym
--
select 'create synonym '||upper('&&v_user')||'.'||o.object_name||' for '||o.owner||'.'||o.object_name||';'
  from sys.dba_objects o
 where o.owner       = upper('&v_owner')
   and o.object_type in ('TABLE','VIEW','SEQUENCE','FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY')
   and not exists (select 'x'
                     from sys.dba_synonyms s
                    where s.synonym_name = o.object_name
                      and s.owner        = 'PUBLIC' );
spool off

set verify on
set feedback on
set heading on
set echo on


connect system/manager
create synonym galp.trans_abast to galpdba.trans_abast
/

  SELECT  'CREATE SYNONYM '
         ||'GALP.'
         ||OBJECT_NAME
         ||' FOR GALPDBA.'
         ||OBJECT_NAME
         ||';'
    FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'PROCEDURE'
ORDER BY OBJECT_NAME
/


--
SET PAGESIZE 200
--
  SELECT  'CREATE SYNONYM '
        ||'GALP.'
        ||OBJECT_NAME
        ||' FOR GALPDBA.'
        ||OBJECT_NAME
        ||';'
    FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'TABLE'
ORDER BY OBJECT_NAME
/

