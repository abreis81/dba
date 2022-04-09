SELECT 
DECODE(o.type# 
, 1,'INDEX' 
, 2,'TABLE' 
, 3,'CLUSTER' 
, 4,'VIEW' 
, 5,'SYNONYM' 
, 6,'SEQUENCE' 
, 7,'PROCEDURE' 
, 8,'FUNCTION' 
, 9,'PACKAGE' 
, 10,'NON-EXISTENT' 
, 11,'PACKAGE BODY' 
, 12,'TRIGGER' 
, 13,'TYPE' 
, 14,'TYPE BODY' 
, 19,'TABLE PARTITION' 
, 20,'INDEX PARTITION' 
, 21,'LOB' 
, 22,'LIBRARY' 
, 'UNKNOWN') BUF_OBJTYPE 
, COUNT(*) BUF_TOTALBLKS 
, SUM(DECODE(BITAND(bh.flag,1),0,0,1)) BUF_DIRTYBLKS 
, SUM(DECODE(BITAND(bh.flag,1),0,1,0)) BUF_CLEANBLKS 
FROM 
sys.x$bh bh 
, sys.obj$ o 
, sys.ts$ ts 
, sys.user$ u 
WHERE 
(bh.obj = o.dataobj# ) 
AND (bh.ts# = ts.ts# ) 
AND (o.owner# = u.user# ) 
GROUP BY 
o.type#
UNION ALL 
SELECT 
'ROLLBACK SEG' BUF_OBJTYPE 
, COUNT(*) BUF_TOTALBLKS 
, SUM(DECODE(BITAND(bh.flag,1),0,0,1)) BUF_DIRTYBLKS 
, SUM(DECODE(BITAND(bh.flag,1),0,1,0)) BUF_CLEANBLKS 
FROM 
sys.x$bh bh 
, sys.undo$ un 
, sys.ts$ ts 
, sys.user$ u 
WHERE 
(bh.class >= 11 ) 
AND (un.us# = FLOOR(bh.class - 11 ) / 2 ) 
AND (bh.ts# = ts.ts# ) 
AND (un.user# = u.user# ) 
union
select 'TOTAL',count(*),SUM(DECODE(BITAND(bh.flag,1),0,0,1)),SUM(DECODE(BITAND(bh.flag,1),0,1,0))
from sys.x$bh bh
/
