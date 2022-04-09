accept g prompt "Nome do trigger ou (Enter)=Todos.............: "
accept t prompt "Nome da tabela ou (Enter)=Todas..............: "
accept o prompt "Nome do proprietario ou (Enter)=Usuario......: "
accept a prompt "Arquivo de criacao ou (Enter)=nome do trigger: "
prompt
col a new_value a noprint
col b format a80 wor
set ver off feed off pause off pages 0 long 131072 longc 131072 arrays 5 lines 32767
set term off wrap on recsep off 
set trim on trims on
select lower(nvl('&a',nvl(replace('&g','%'),'trig'))) a from dual;
set term on
set trim on trims on
col b form a32767
col c form a32767 wra
col d form a32767
spool &a..sql
select /*+ rule */ 'CREATE OR REPLACE TRIGGER '|| rtrim(description,' '||chr(9)||chr(10))||chr(10)||
       DECODE(rtrim(when_clause,' '||chr(9)||chr(10)),null,null,'WHEN ('|| rtrim(when_clause,' '||chr(9)||chr(10)) ||')' ) b
     , trigger_body c
     , '/' d
from &&dba._triggers
where owner like decode(upper('&o'),'ALL','%',null,user,upper('&o'))
  and table_name like nvl(upper('&t'),'%')
  and trigger_name like nvl(upper('&g'),'%')
order by owner, trigger_name
/
select /*+ rule */ 'ALTER TRIGGER '||'"'|| trigger_name || '" ' ||
       decode(status,'ENABLED','ENABLE','DISABLE') || ';' d
from &&dba._triggers
where owner like decode(upper('&o'),'ALL','%',null,user,upper('&o'))
  and table_name like nvl(upper('&t'),'%')
  and trigger_name like nvl(upper('&g'),'%')
order by owner, trigger_name
/
spool off