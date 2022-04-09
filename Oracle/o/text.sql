set pages 5000
COL SQL_TEXT FORMAT A64
accept sid prompt "digite o sid:"
select sql_text from v$sqltext where address = (select sql_address from v$session
						where sid = &&sid)
order by piece
/