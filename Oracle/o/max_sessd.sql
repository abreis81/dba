select b.total, c.term, c.machine from 
(select max(count(*)) total from v$session where username='BR_DES' group by terminal, machine) b
,(select count(1) sess, terminal term, machine from v$session where username='BR_DES' group by terminal, machine) c
where b.total=c.sess group by b.total, c.term, c.machine
/
