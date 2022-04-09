set feedback off
set verify off
set echo off
--
col object_name format a20
--
clear screen
--
accept v_owner prompt "Proprietario do Objeto ? "
--
select o.owner
      ,o.object_name
  from sys.dba_objects o
 where object_type in ('TABLE','VIEW','SEQUENCE','FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY')
   and o.owner = upper('&&v_owner')
   and not exists (select 'x'
                     from sys.dba_synonyms s
                    where o.object_name = s.synonym_name)
/
set feedback on
set verify on
set echo on

