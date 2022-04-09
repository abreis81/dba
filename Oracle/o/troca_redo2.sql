col "00" format 99 
col "01" format 99 
col "02" format 99 
col "03" format 99 
col "04" format 99 
col "05" format 99 
col "06" format 99 
col "07" format 99 
col "08" format 99 
col "09" format 99 
col "10" format 99
col "11" format 99
col "12" format 99
col "13" format 99
col "14" format 99
col "15" format 99
col "16" format 99
col "17" format 99
col "18" format 99
col "19" format 99
col "20" format 99
col "21" format 99
col "22" format 99
col "23" format 99


select sum(decode(to_char(FIRST_TIME,'hh24'),0,1,0))  "00"
,sum(decode(to_char(FIRST_TIME,'hh24'),1,1,0)) "01" 
,sum(decode(to_char(FIRST_TIME,'hh24'),2,1,0)) "02" 
,sum(decode(to_char(FIRST_TIME,'hh24'),3,1,0)) "03" 
,sum(decode(to_char(FIRST_TIME,'hh24'),4,1,0)) "04" 
,sum(decode(to_char(FIRST_TIME,'hh24'),5,1,0)) "05" 
,sum(decode(to_char(FIRST_TIME,'hh24'),6,1,0)) "06" 
,sum(decode(to_char(FIRST_TIME,'hh24'),7,1,0)) "07" 
,sum(decode(to_char(FIRST_TIME,'hh24'),8,1,0)) "08" 
,sum(decode(to_char(FIRST_TIME,'hh24'),9,1,0)) "09" 
,sum(decode(to_char(FIRST_TIME,'hh24'),10,1,0)) "10" 
,sum(decode(to_char(FIRST_TIME,'hh24'),11,1,0)) "11" 
,sum(decode(to_char(FIRST_TIME,'hh24'),12,1,0)) "12" 
,sum(decode(to_char(FIRST_TIME,'hh24'),13,1,0)) "13" 
,sum(decode(to_char(FIRST_TIME,'hh24'),14,1,0)) "14" 
,sum(decode(to_char(FIRST_TIME,'hh24'),15,1,0)) "15" 
,sum(decode(to_char(FIRST_TIME,'hh24'),16,1,0)) "16" 
,sum(decode(to_char(FIRST_TIME,'hh24'),17,1,0)) "17" 
,sum(decode(to_char(FIRST_TIME,'hh24'),18,1,0)) "18" 
,sum(decode(to_char(FIRST_TIME,'hh24'),19,1,0)) "19" 
,sum(decode(to_char(FIRST_TIME,'hh24'),20,1,0)) "20" 
,sum(decode(to_char(FIRST_TIME,'hh24'),21,1,0)) "21" 
,sum(decode(to_char(FIRST_TIME,'hh24'),22,1,0)) "22" 
,sum(decode(to_char(FIRST_TIME,'hh24'),23,1,0)) "23" 
from v$log_history where trunc(FIRST_TIME)=trunc(sysdate);