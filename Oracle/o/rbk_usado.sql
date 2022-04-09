set pages 5000

select sid, username , round(used_ublk/1024/1024,2) RBK_MB 
	from v$session a,
			 v$transaction b
	where b.addr = a.taddr
/ 