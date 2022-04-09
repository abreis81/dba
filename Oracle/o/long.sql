undef sid
col message format a90

select START_TIME, LAST_UPDATE_TIME, TIME_REMAINING,MESSAGE,target from v$session_longops where sid=&&sid and TIME_REMAINING is not null and TIME_REMAINING<>0
/

