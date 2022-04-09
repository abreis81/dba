set lines 125
col machine for a30		
SELECT		status,
		username,
		machine,
		to_char(trunc(logon_time,'hh24'),'dd/mm/yyyy hh24:mi') logon_time,
		count(*)
FROM		v$session
WHERE		username is not null
GROUP BY	username,
		machine,
		status,
		trunc(logon_time,'hh24')
ORDER BY	status,
		username,
		machine,
		logon_time;	
		
select count(*) from v$session where username is not null;

select		'alter system kill session '''||sid||','||serial#||''';'
from		v$session
where		status = 'INACTIVE'
and		logon_time < to_date('17/10/2007','dd/mm/yyyy');

echo '@ killsession.sql' | sqlplus -S "/as sysdba" | sqlplus -S "/as sysdba"


echo 'select sysdate from dual;' | sqlplus -S "/as sysdba" | sqlplus -S "/as sysdba"



set lines 125
col machine for a30		
SELECT		status,
		username,
		machine,
		count(*)
FROM		v$session
WHERE		username is not null
GROUP BY	username,
		machine,
		status
ORDER BY	status,
		username,
		machine;






