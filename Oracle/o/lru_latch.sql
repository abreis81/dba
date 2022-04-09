rem Script Description: To determine whether the database is experiencing latch contention, begin by determining whether 
rem                     there is LRU latch contention for any individual latch. The miss ratio for each LRU latch should be 
rem                     less than 3%. A ratio above 3% for any particular latch is indicative of LRU latch contention and 
rem                     should be addressed. It is possible to determine the buffer pool to which the latch is associated as follows: 
rem
rem                     It is possible to alleviate LRU latch contention by increasing the overall number of latches in the 
rem                     system and the number of latches allocated to the buffer pool indicated in the second query. 
rem
rem                     The maximum number of latches allowed is the lower of: 
rem                          number_of_cpus * 2 * 3 or number_of_buffers / 50 
rem
rem
rem Output file:        childlatches.lis
rem
rem Prepared By:        TheOracleResourceStop Script Archive
rem                     www.orsweb.com
rem
rem Usage Information:  SQLPLUS SYS/pswd
rem                     @childlatches.sql
rem

spool childlatches.lis

SELECT lc.NAME, SLEEPS / GETS RATIO
FROM V$BUFFER_POOL bp, V$LATCH_CHILDREN lc
WHERE lo_setid <= child#
AND hi_setid >= child#
and lc.NAME = 'cache buffers lru chain';

spool off;
