select o.sid, osuser, machine,
count(*) num_curs
from v$open_cursor o, v$session s
where o.sid=s.sid
group by o.sid, osuser, machine
order by num_curs;

---- connection pool

select o.sid, osuser, machine,
count(*) num_curs
from v$open_cursor o, v$session s
where o.sid=s.sid and
user_name = 'USUARIO_BANCO' and
machine = 'NOME_MAQUINA_APLICACAO'
group by o.sid, osuser, machine
order by  o.sid;

---- sid

select q.sql_text, count(*)
from v$open_cursor o, v$sql q
where q.hash_value=o.hash_value and o.sid IN (<SIDs>)
group by q.sql_text
order by 2;

---
select *
from v$open_cursor;
