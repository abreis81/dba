COL WAIT_CLASS FORMAT A20
SELECT wait_class#, wait_class, time_waited, total_waits
FROM v$system_wait_class
ORDER BY time_waited;
