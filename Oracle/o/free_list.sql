
rem Script Description: This script calculates the wait ratio for freelists. 
rem                     The value produced for FL_WAIT_RATIO should be less than 1. 
rem                     If it is greater than 1, then there is an issue with freelist 
rem                     contention that needs to be resolved in the database.
rem
rem                     NOTE: The resolution for freelist contention in the database is 
rem                     for the table to be recreated with a higher value specified for 
rem                     the freelists storage clause parameter.
rem
rem Output file:        flc.lis
rem
rem Prepared By:        TheOracleResourceStop
rem                     www.orsweb.com
rem
rem Usage Information:  SQLPLUS SYS/pswd
rem                     @freelistcontention.sql
rem


select (W.count/sum(s.value))*100 fl_wait_ratio
from v$waitstat w, v$sysstat s
where w.class = 'free list'
and s.name in ('db block gets','consistent gets');

