SELECT	to_char(end_time,'dd/mm/yyyy hh24:mi') end_time,
	undoblks,
	ssolderrcnt
FROM	v$undostat
ORDER BY end_time;