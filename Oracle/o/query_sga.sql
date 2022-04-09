SELECT substr(sql_text,1,40) "SQL", 
                 count(*) , 
                 sum(executions) "TotExecs"
            FROM v$sqlarea
           WHERE executions < 5
           GROUP BY substr(sql_text,1,40)
          HAVING count(*) > 30
           ORDER BY 2


SELECT substr(sql_text,1,40) "Stmt", count(*),
                sum(sharable_mem)    "Mem",
                sum(users_opening)   "Open",
                sum(executions)      "Exec"
          FROM v$sql
         GROUP BY substr(sql_text,1,40)
HAVING sum(sharable_mem) > 1000000   
     
SELECT * FROM x$ksmlru
WHERE ksmlrnum>0

SELECT address, hash_value,
                version_count ,
                users_opening ,
                users_executing,
                substr(sql_text,1,40) "SQL"
          FROM v$sqlarea
         WHERE version_count > 10


 SELECT hash_value, count(*)
          FROM v$sqlarea 
         GROUP BY hash_value 
        HAVING count(*) > 5
