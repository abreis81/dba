declare

cursor kill is select * from v$session 
	where username not in ('SYSTEM','SYS','BACKUP','DBSNMP');
mata kill%rowtype;
str varchar2(500);
begin
	open  kill;
	loop
		fetch kill into mata;
		exit when kill%notfound;
		str:='alter system kill session '||''''||mata.sid||','||mata.serial#||'''';
		execute immediate str;
	end loop;
	close kill;
end;
/			
	