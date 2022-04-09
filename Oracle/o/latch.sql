select count(*) cnt, event from v$session_wait 
where state='WAITING' group by event ; 

select count(*) cnt , name latchname from v$session_wait, v$latchname 
where event='latch free' and state='WAITING' and p2=latch# 
group by name ; 

/*

SCOPE & APPLICATION 
  
  This article can be used by DBAs on Oracle7.3 , Oracle 8.0 & Oracle 8.1. 
  

PURPOSE 
  
  To assist diagnosing contention with the library cache latch. 
  This note will not explain in detail how the library cache works. 
  

A) DIAGNOSIS 

i) V$LATCH 

Selecting from v$latch will show you which latches have the worst hit rates 
and more importantly which latches are causing a lot of sleeps.  If one of the 
library cache latches is causing the most number of sleeps then you may have 
a problem.  One thing to watch out for here is that this information is 
accumulated since the database starts, and so it may not show problems that 
are intermittent in nature. 
The following query shows the library cache latch information: 

 select name,gets,misses,sleeps 
 from v$latch 
 where name like 'library%'; 

To get the OS process id: 

 select a.name,pid from v$latch a , V$latchholder b 
 where a.addr=b.laddr 
 and a.name = 'library cache%';


ii) V$SESSION_WAIT 

By selecting from v$session_wait during a slowdown period you can usually 
determine very accurately whether you have a problem with latching and which 
latch is causing the problem.  If you see a large number (more then 3 or 4) 
of processes waiting for the library cache or library cache pin latch, then 
there may be a problem.  Run the following query to determine this: 
select count(*) number_of_waiters 
from v$session_wait w, v$latch l 
where w.wait_time = 0 
and  w.event     = 'latch free' 
and  w.p2        = l.latch# 
and  l.name      like 'library%'; 

It is also very useful to just select from v$session_wait to determine what 
else is causing a slowdown: 

select * from v$session_wait 
where event != 'client message' 
and event not like '%NET%' 
and wait_time = 0 
and sid > 5;


B) CORRECTION 

i) FRAGMENTATION 

The  primary cause of library cache latch contention is fragmentation of the 
shared pool. A common symptom is the ORA-04031 error. This can be diagnosed and 
addressed. Please refer to <Note:146599.1> to have detailed information on this topic.

ii) INCREASE SHARING 

By increasing the amount of sharing that occurs on the system you can decrease 
the amount of missing and loading that occurs in the library cache and 
therefore the load on the library cache latch.  This is done by identifying 
statements that are not being shared as described in the fragmentation section 
above. 
To determine the percentage of sql statement parse calls that find a cursor to 
share you can execute the following: 

  select gethitratio from v$librarycache where namespace = 'SQL AREA'; 

This value should be in the high nineties.


iii) REDUCE PARSING 

Any time a SQL statement is executed a PARSE stage must be executed. When a 
PARSING representation can be reused because is already loaded into the shared pool 
a "soft parse" is issued. When is required to compile the statement and create the parse 
representation a "hard parse" is issued. To reduce library cache latch contention you will 
need to monitor and reduce "hard parse" 
To identify the SQL statements that are receiving a lot of parse calls execute 
the following query: 

  select sql_text, parse_calls, executions from v$sqlarea 
  where parse_calls > 100 and executions < 2*parse_calls; 

To identify the total amount of parsing going on in the system execute the 
following: 

Oracle7: 
  select name, value from v$sysstat where name = 'parse count'; 

    NAME                                      &n ----------------------------------------------            ---------- 
    parse count                                      (Oracle8.x keep record of the "hard parse") 
  select name, value from v$sysstat where name like 'parse count%'; 

    NAME                                      &n -----------------------------------------------            ---------- 
    parse count (total)                                   &nbs parse count (hard)                                       &nbs this value increases at a rate greater than about 10 per second then this 
may be a problem.


iv) CURSOR_SPACE_FOR_TIME 

Setting the init.ora parameter cursor_space_for_time to TRUE can reduce the 
load on the library cache latch somewhat.   However, setting this parameter may 
add a lot of memory utilization, so before setting it to true make sure that 
there is a lot of free memory on the system and that the number of hard page 
faults per minute is very low or zero.

v) SESSION_CACHED_CURSORS 
session_cached_cursors can be set that will help in situations where a user repeatedly parses 
the same statements.  This can occur in many applications including FORMS based 
application if users often switch between forms.  Every time a user switches to 
a new form all the SQL statements opened for the old form will be closed.  The 
session_cached_cursors parameter will cause closed cursors to be cached within 
the session so that a subsequent call to parse the statement will bypass the 
parse phase.  This is similar to HOLD_CURSORS in the precompilers.  One thing 
to be careful about is that if this parameter is set to a high value, the 
amount of fragmentation in the shared pool may be increased.

vi) USING FULLY QUALIFIED TABLE NAMES 
It can help to reduce the load on the library cache latch somewhat to use fully 
qualified names for tables in SQL statements.  That is, instead of saying 
'select * from emp', say 'select * from scott.emp'.  This is especially helpful 
for SQL statements that are parsed very frequently.  If all users log onto the 
database using the same userid then this may be of little or no use.

*/