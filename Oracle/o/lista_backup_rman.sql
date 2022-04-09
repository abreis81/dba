col media   format a8
col tag     format a12 trunc
col minutes format 990

select d.name, p.tag, p.handle, p.media,
       s.incremental_level "LEVEL",
       to_char(s.start_time, 'DD-MON-YY HH24:MI') start_time,
       s.elapsed_seconds/60 "MINUTES"
from  RC_DATABASE d, RC_BACKUP_PIECE p, RC_BACKUP_SET s
where trunc(s.start_time) = trunc(sysdate)
  and trunc(s.completion_time) = trunc(sysdate)
  and p.backup_type     = 'D' -- D=Database, L=Log
  and d.db_key = p.db_key
  and s.db_key = p.db_key
  and p.bs_key = s.bs_key
/

select d.name, p.tag, p.handle, p.media,
       s.incremental_level "LEVEL",
       to_char(s.start_time, 'DD-MON-YY HH24:MI') start_time,
       s.elapsed_seconds/60 "MINUTES"
from  RC_DATABASE d, RC_BACKUP_PIECE p, RC_BACKUP_SET s
where trunc(s.start_time) = trunc(sysdate)
  and trunc(s.completion_time) = trunc(sysdate)
  and p.backup_type     = 'S' -- D=Database, L=Log
  and d.db_key = p.db_key
  and s.db_key = p.db_key
  and p.bs_key = s.bs_key
/

select d.name, p.tag, p.handle, p.media,
       s.SEQUENCE#,
       to_char(s.COMPLETION_TIME, 'DD-MON-YY HH24:MI') completition_time
from  RC_DATABASE d, RC_BACKUP_PIECE p, RC_BACKUP_REDOLOG s
where trunc(s.completion_time) = trunc(sysdate)
  and d.db_key = p.db_key
  and s.db_key = p.db_key
  and p.bs_key = s.bs_key
/
