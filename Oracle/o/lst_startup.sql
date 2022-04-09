column sttime format a30
--
set heading off feedback off
--
select 'Database : '||name
      ,'started at '
      ,to_date(a.value, 'J')||' '||floor(b.value/3600)||':'||(floor(b.value/60) - (floor(b.value/3600) * 60))||':'||(b.value - (floor (b.value/60) * 60)) STTIME
  from v$instance a
      ,v$instance b
      ,v$database c
 where b.key like 'STARTUP TIME - S%'
   and a.key like 'STARTUP TIME - J%'
/

set heading on feedback on
