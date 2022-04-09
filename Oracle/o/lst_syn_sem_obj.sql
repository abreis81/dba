select s.synonym_name
      ,s.owner
  from sys.dba_synonyms s
 where not exists (select 'x'
                     from sys.dba_objects o
                    where o.object_name = s.synonym_name)
/
