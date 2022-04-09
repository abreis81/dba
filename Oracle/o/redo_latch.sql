column GHR format 9990 heading 'Get Hit|Ratio' 
column IGHR format 9990 heading 'IGet Hit|Ratio' 
column name format a20 
select name, 
round(( sum(gets) - sum(misses) ) / 
sum(gets),3) * 100 "GHR", 
round(( sum(immediate_gets) - sum(immediate_misses) ) / 
decode( sum(immediate_gets),0,1,sum(immediate_gets)) ,3) 
* 100 "IGHR", 
sum(sleeps) "Sleeps", 
sum(gets) "Gets", 
sum(immediate_gets) "IGets" 
from v$latch 
where name like '%redo%' 
group by name 
/ 

