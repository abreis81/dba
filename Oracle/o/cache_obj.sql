select name, sharable_mem 
     from v$db_object_cache 
    where sharable_mem > 10000 
     and (type = 'PACKAGE' or type = 'PACKAGE BODY' or type = 'FUNCTION' 
          or type = 'PROCEDURE') 
and kept = 'NO'; 
