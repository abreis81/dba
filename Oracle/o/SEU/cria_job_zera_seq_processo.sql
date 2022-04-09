
BEGIN
 DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'SEU.J_ZERA_SEQ_PROCESSO',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'seu.p_zera_seq_processo',
   start_date         =>  to_timestamp_tz('2008-01-01 06:00:00 -2:00', 'YYYY-MM-DD HH24:MI:SS TZH:TZM'),
   repeat_interval    =>  'FREQ=YEARLY;BYMONTH=JAN;BYMONTHDAY=1;BYHOUR=07;BYMINUTE=0;BYSECOND=0',
   auto_drop 					=> FALSE,
	 enabled 						=> FALSE,
   comments           =>  'teste job');

sys.dbms_scheduler.set_attribute( name => '"SEU"."J_ZERA_SEQ_PROCESSO"', attribute => 'restartable', value => TRUE);
sys.dbms_scheduler.enable( '"SEU"."J_ZERA_SEQ_PROCESSO"' );
END;
/
