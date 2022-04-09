
select  distinct /*+ rule */ a.sid, a.serial# , a.username, 
a.LOCKWAIT, a.status, a.SCHEMANAME, a.osuser, a.MACHINE, a.PROGRAM, 
a.LOGON_TIME
from v$session a, v$access b
where b.OBJECT like '%PKG_CRITICA_AUTOMATICA%'
and a.sid = b.sid; 




select /*+ rule */  *
from v$access a
WHERE
a.OBJECT='PKG_CRITICA_AUTOMATICA';
