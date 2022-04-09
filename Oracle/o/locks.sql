REM  Display locks currently held and requested. Displays which session a
REM  blocked lock is waiting for.

set pages 1000
set lines 300
col uname     head "Username"  form a15
col sid       head "SID"       form 999
col ltype     head "Type"      form a4
col lmode     head "Mode"      form a10
col blocked   head "Wait"      form a4 
col details   head "Detalhes"   form a40

set verify off

accept user prompt  "Username [%]: "
 
select s.sid sid
      ,osuser
      ,s.username uname
      ,'DML' ltype
      ,decode (l.lmode,1,'Null',
                       2,'Row-S',
                       3,'Row-X',
                       4,'Share',
                       5,'S/Row-X',
                       6,'Exclusive') lmode
      ,decode (l.request,0,'No','Yes') blocked
      ,u.name||'.'||o.name details
  from v$session s
      ,v$lock l
      ,sys.obj$ o
      ,sys.user$ u
 where s.username like nvl(upper('&user'||'%'),'%')
   and s.sid    = l.sid
   and l.id1    = o.obj#
   and l.type   = 'TM'
   and o.owner# = u.user#(+)
union all
  select s.sid sid
        ,osuser
        ,s.username uname
        ,decode (l.type,'TX','TX','UL','USR','SYS') ltype
        ,decode(l.lmode,1,'Null',
                        2,'Row-S',
                        3,'Row-X',
                        4,'Share',
                        5,'S/Row-X',
                        6,'Exclusive') lmode
        ,decode (l.request,0,'No','Yes') blocked
        ,decode (l.request,0,null,'Waiting on session '||to_char(b.sid)) details
    from v$session s
        ,v$lock l
        ,v$lock b
   where s.username like nvl(upper('&user'||'%'),'%')
     and s.sid = l.sid
     and l.type != 'TM'
     and l.id1 = b.id1(+)
     and b.request(+) = 0
order by 6 desc,4 desc,3,1
/
set verify on

REM  End of file





