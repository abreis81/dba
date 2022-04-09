SELECT SUM(s.value/(86400*(SYSDATE - TO_DATE(i.THREAD#,'J')))) "tps"
  FROM V$SYSSTAT s
      ,V$INSTANCE i
 WHERE s.NAME in ('user commits','transaction rollbacks')
   AND i.THREAD# = 1
/
