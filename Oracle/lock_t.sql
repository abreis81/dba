select b.sid, c.username, c.osuser, c.terminal, c.status, a.owner, decode (NVL (b.id2, 0), 0, a.object_name, 'Trans-'||to_char(b.id1)) object_name, b.type,
decode (NVL (b.lmode, 0), 0, '--Waiting--',
1, 'Null',
2, 'Row Share',
3, 'Row Excl',
4, 'Share',
5, 'Sha Row Exc',
6, 'Exclusive',
'Other') "Lock Mode",
decode(NVL (b.request, 0), 0, ' - ',
1, 'Null',
2, 'Row Share',
3, 'Row Excl',
4, 'Share',
5, 'Sha Row Exc',
6, 'Exclusive',
'Other') "Req Mode"
from dba_objects a,
v$lock b,
v$session c
where a.object_id (+) = b.id1
and b.sid = c.sid
and c.username is not null
order by b.sid, b.id2;