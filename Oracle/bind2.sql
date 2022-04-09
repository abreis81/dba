SELECT
   a.sql_text,
   b.name,
   b.position,
   b.datatype_string,
   b.value_string
FROM
  v$sql_bind_capture b,
  v$sqlarea          a
WHERE
   b.sql_id = '7f2f8jdp9u4jb'
AND
   b.sql_id = a.sql_id;

---------------------- Tiago --------------------------
 select b.position
       ,b.datatype_string
      ,b.VALUE_STRING       
      ,b.sql_id
  from v$sql              t
      ,v$sql_bind_capture b
      ,v$session          a
 where t.sql_id = b.sql_id
   and a.sql_id = b.sql_id
       and a.sid=
