select a.table_name
  from user_tables a
 where not exists 
      (select 1 from sys.dba_synonyms b
        where b.synonym_name = a.table_name
          and b.owner = 'PUBLIC')
/
