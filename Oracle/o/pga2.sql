select trunc ((sum(case when name like 'workarea executions - optimal'                                         
                   then value else 0 end) *100) /(sum(case when name like 'workarea executions - optimal'                                                 
                   then value else 0 end)+sum(case when name like 'workarea executions - one pass'                                                
             	   then value else 0 end)+sum(case when name like 'workarea executions - multipass'                                               
             	   then value else 0 end))) optimal_percent 
from v$sysstat where name like 'workarea executions - %' 
/ 

select *  
from (select workarea_address, operation_type, policy, estimated_optimal_size  
	from v$sql_workarea  order by estimated_optimal_size DESC) where ROWNUM <=10;  

select operation_type, total_executions * 100 /optimal_executions "%cache" 
From v$sql_workarea Where policy='AUTO' And optimal_executions > 0 Order By operation_type;  

select c.sql_text, w.operation_type, top_ten.wasize 
From (Select * 
	From (Select workarea_address, actual_mem_used wasize 
		from v$sql_workarea_active  Order by actual_mem_used)       
	      Where ROWNUM <=10) top_ten, 
	v$sql_workarea w,
	v$sql c
Where  w.workarea_address=top_ten.workarea_address         
And c.address=w.address         
And c.child_number = w.child_number         
And c.hash_value=w.hash_value;            

select  total_used
	, under*100/(total_used+1) percent_under_use
	, over*100/(total_used+1)   percent_over_used 
From ( Select sum(case when expected_size > actual_mem_used then actual_mem_used else 0 end) under
	, sum(case when expected_size<> actual_mem_used then actual_mem_used else 0 end) over
	, sum(actual_mem_used) total_used         
     From v$sql_workarea_active         Where policy='AUTO') usage;   
