select  b.username, 
	a.buffer_gets gets
         ,a.executions exec
         ,a.buffer_gets / decode(a.executions, 0, 1,a.executions) buff_exec_ratio
         ,a.command_type
         ,a.address 
         ,a.sql_text Statement
     --    ,a.hash_value
    from v$sqlarea a
        ,dba_users b
   where a.parsing_user_id = b.user_id
     --and a.buffer_gets > 1000000 
     and b.username='BRDBA'
order by a.buffer_gets desc
/
