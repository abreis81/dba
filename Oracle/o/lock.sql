set linesize 300;
select substr(s.username,1,10) USERNAME	
   	,s.osuser OSUSER
	,substr(s.program,1,15) PROG
	,l.type TYPE
	,decode (l.lmode,1,'Null',
                       2,'Row-S',
                       3,'Row-X',
                       4,'Share',
                       5,'S/Row-X',
                       6,'Exclusive') LMODE
      ,decode (l.request,0,'No','Yes') BLOCKED
      ,substr(o.object_name,1,20) OBJETO
from v$session s
    ,v$lock l
    ,v$locked_object v 
    ,dba_objects o
where s.sid=l.sid 
      and l.sid = v.session_id
      and v.object_id=o.object_id
order by 7,4,5
/	