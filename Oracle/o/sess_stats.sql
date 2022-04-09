set pages 1000

SELECT n.NAME, s.value
FROM sys.v_$statname n, sys.v_$sesstat s,
sys.v_$session ss
WHERE n.STATISTIC# = s.STATISTIC#
AND (n.NAME LIKE '%sort%disk%' or
n.name like '%physical reads%' or n.name like '%arallelized%' or
lower(n.name) like '%temp%' or
n.name like '%consistent gets%')
AND ss.AUDSID = USERENV('SESSIONID')
AND s.SID = ss.SID

