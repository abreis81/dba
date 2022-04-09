create or replace procedure SP_ANALYZE is

--
-- Rodar antes (se ainda nao rodou) o script DBMSUTIL do ORACLE SERVER
--
cursor c1 is
  select distinct
         owner
    from dba_objects
   where object_type = 'TABLE'
     and owner not like 'SYS%';

begin

  dbms_transaction.use_rollback_segment('RBS1');

  for x  in c1 loop
      dbms_utility.analyze_schema(x.owner,'COMPUTE');
  end loop;

end;
/
