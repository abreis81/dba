/**********************************************************************                                
 * File:	sp_oica.sql                                                                                  
 * Type:	SQL*Plus script                                                                              
 * Author:	Tim Gorman (SageLogix, Inc)                                                                
 * Date:	02-Feb 2005                                                                                  
 *                                                                                                     
 * Description:                                                                                        
 *	SQL*Plus script to provide more usable information when deciding                                   
 *	how to set the parameter OPTIMIZER_INDEX_COST_ADJ parameter,                                       
 *	according to the recommendations made in my paper entitled                                         
 *	"Search for Intelligent Life in the Cost-Based Optimizer",                                         
 *	available online at "http://www.EvDBT.com/papers.htm".                                             
 *                                                                                                     
 *	There is a SQL statement in that paper which suggests calculating                                  
 *	the proper value for O_I_C_A using information stored in the                                       
 *	V$SYSTEM_EVENT view.  However, since the information in that                                       
 *	view is summarized over a long period of time, better information                                  
 *	might be obtained from the corresponding STATSPACK table                                           
 *	(STATS$SYSTEM_EVENT, populated from snapshots from V$SYSTEM_EVENT)                                 
 *	to display changes to the timing information over time.                                            
 *                                                                                                     
 *	This report calculates a recommended O_I_C_A value using sampled                                   
 *	information summarized first by day, and then later by hour.                                       
 *                                                                                                     
 *	This version of the script is intended for Oracle9i, which                                         
 *	records timing information in V$SYSTEM_EVENT in micro-seconds                                      
 *	(1/1000000ths of a second), and V$SYSSTAT info in centi-seconds                                    
 *	(1/100ths of a second) like 8i.                                                                    
 *                                                                                                     
 * Modifications:                                                                                      
 *********************************************************************/                                
set pagesize 100 lines 80 trimspool on trimout on verify off recsep off                                
col sort0 noprint                                                                                      
col sort1 noprint                                                                                      
col day heading "Day"                                                                                  
col hr heading "Hour"                                                                                  
col oica format 99,990 heading "Recommended|O_I_C_A value"                                             
                                                                                                       
accept V_INSTANCE prompt "Please enter the ORACLE_SID value: "                                         
accept V_NBR_DAYS prompt "Please enter the number of days to report upon: "                            
                                                                                                       
spool sp_oica_&&V_INSTANCE                                                                             
                                                                                                       
clear breaks computes                                                                                  
break on day skip 1 on report                                                                          
compute avg of oica on report                                                                          
ttitle left 'STATSPACK repository' center 'Calculated values for O_I_C_A' right 'Daily Summary' skip 1 
                                                                                                       
select	to_char(snap_time, 'YYYYMMDD') sort0,                                                          
	to_char(snap_time, 'DD-MON') day,                                                                    
	avg(oica) oica                                                                                       
from	(select	s.snap_time,                                                                             
		nvl(decode(greatest((r1.avg_wait_micro/r2.avg_wait_micro),                                         
				    nvl(lag((r1.avg_wait_micro/r2.avg_wait_micro))                                             
					over (partition by s.dbid,                                                                   
							   s.instance_number                                                                     
						order by s.snap_id),0)),                                                                   
			   (r1.avg_wait_micro/r2.avg_wait_micro),                                                        
			   (r1.avg_wait_micro/r2.avg_wait_micro) -                                                       
				lag((r1.avg_wait_micro/r2.avg_wait_micro))                                                     
					over (partition by s.dbid,                                                                   
							   s.instance_number                                                                     
					order by s.snap_id),                                                                         
				(r1.avg_wait_micro/r2.avg_wait_micro)), 0)*100 oica                                            
	 from   (select dbid,                                                                                
			instance_number,                                                                                 
			snap_id,                                                                                         
			time_waited_micro/total_waits avg_wait_micro                                                     
		 from	stats$system_event                                                                           
		 where	event = 'db file sequential read')	r1,                                                    
	 	(select dbid,                                                                                      
			instance_number,                                                                                 
			snap_id,                                                                                         
			time_waited_micro/total_waits avg_wait_micro                                                     
		 from	stats$system_event                                                                           
		 where	event = 'db file scattered read')	r2,                                                      
		stats$snapshot					s,                                                                         
		(select distinct dbid,                                                                             
			 instance_number,                                                                                
			 instance_name                                                                                   
		 from	stats$database_instance)		i                                                                
	 where	i.instance_name = '&&V_INSTANCE'                                                             
	 and    s.dbid = i.dbid                                                                              
	 and    s.instance_number = i.instance_number                                                        
	 and    s.snap_time between (sysdate - &&V_NBR_DAYS) and sysdate                                     
	 and	r1.dbid = s.dbid                                                                               
	 and	r1.instance_number = s.instance_number                                                         
	 and	r1.snap_id = s.snap_id                                                                         
	 and	r2.dbid = s.dbid                                                                               
	 and	r2.instance_number = s.instance_number                                                         
	 and	r2.snap_id = s.snap_id)                                                                        
group by to_char(snap_time, 'YYYYMMDD'),                                                               
	 to_char(snap_time, 'DD-MON')                                                                        
order by sort0;                                                                                        
                                                                                                       
compute avg of oica on day                                                                             
ttitle left 'STATSPACK repository' center 'Calculated values for O_I_C_A' right 'Hourly Summary' skip 1
                                                                                                       
select	to_char(snap_time, 'YYYYMMDDHH24') sort0,                                                      
	to_char(snap_time, 'DD-MON') day,                                                                    
	to_char(snap_time, 'DD-MON HH24')||':00' hr,                                                         
	avg(oica) oica                                                                                       
from	(select	s.snap_time,                                                                             
		nvl(decode(greatest((r1.avg_wait_micro/r2.avg_wait_micro),                                         
				    nvl(lag((r1.avg_wait_micro/r2.avg_wait_micro))                                             
					over (partition by s.dbid,                                                                   
							   s.instance_number                                                                     
						order by s.snap_id),0)),                                                                   
			   (r1.avg_wait_micro/r2.avg_wait_micro),                                                        
			   (r1.avg_wait_micro/r2.avg_wait_micro) -                                                       
				lag((r1.avg_wait_micro/r2.avg_wait_micro))                                                     
					over (partition by s.dbid,                                                                   
							   s.instance_number                                                                     
					order by s.snap_id),                                                                         
				(r1.avg_wait_micro/r2.avg_wait_micro)), 0)*100 oica                                            
	 from   (select dbid,                                                                                
			instance_number,                                                                                 
			snap_id,                                                                                         
			time_waited_micro/total_waits avg_wait_micro                                                     
		 from	stats$system_event                                                                           
		 where	event = 'db file sequential read')	r1,                                                    
	 	(select dbid,                                                                                      
			instance_number,                                                                                 
			snap_id,                                                                                         
			time_waited_micro/total_waits avg_wait_micro                                                     
		 from	stats$system_event                                                                           
		 where	event = 'db file scattered read')	r2,                                                      
		stats$snapshot					s,                                                                         
		(select distinct dbid,                                                                             
			 instance_number,                                                                                
			 instance_name                                                                                   
		 from	stats$database_instance)		i                                                                
	 where	i.instance_name = '&&V_INSTANCE'                                                             
	 and    s.dbid = i.dbid                                                                              
	 and    s.instance_number = i.instance_number                                                        
	 and    s.snap_time between (sysdate - &&V_NBR_DAYS) and sysdate                                     
	 and	r1.dbid = s.dbid                                                                               
	 and	r1.instance_number = s.instance_number                                                         
	 and	r1.snap_id = s.snap_id                                                                         
	 and	r2.dbid = s.dbid                                                                               
	 and	r2.instance_number = s.instance_number                                                         
	 and	r2.snap_id = s.snap_id)                                                                        
group by to_char(snap_time, 'YYYYMMDDHH24'),                                                           
	 to_char(snap_time, 'DD-MON'),                                                                       
	 to_char(snap_time, 'DD-MON HH24')||':00'                                                            
order by sort0;                                                                                        
                                                                                                       
spool off                                                                                              
ttitle off                                                                                             
                                                                                                       