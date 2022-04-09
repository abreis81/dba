compute sum of num_sess on report
break on report
select count(1) num_sess, username from v$session group by username
/