select a.sequence_name
  from user_sequences a
 where not exists 
      (select 1 from sys.dba_synonyms b
        where b.synonym_name = a.sequence_name
          and b.owner = 'PUBLIC')
/
