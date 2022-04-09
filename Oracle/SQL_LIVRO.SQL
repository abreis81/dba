-- acerto de buffer
select sum(decode(name,'physical reads', value, 0)) PHYS,
       sum(decode(name,'db block gets',value,0)) GETS,
       sum(decode(name,'consistent gets',value,0)) CON_GETS,
       (1 - (sum(decode(name,'physical reads', value, 0))/
       (sum(decode(name,'db block gets',value,0)) +
       sum(decode(name,'consistent gets',value,0))))) * 100 "Hit Ratio"
from v$sysstat
/

-- acerto do cache de dicionario
select (1-(sum(getmisses)/sum(gets))) * 100 "Hit Ratio"
from v$rowcache
/


-- acerto do cache de biblioteca
select sum(pins) / (sum(pins) + sum (reloads)) * 100 "Hit Ratio"
from v$librarycache
/
-- para qdo pins < 0
select sum((case  when (pins < 0) then pins + 4294967296 else pins end)) / 
  (sum((case  when (pins < 0) then pins + 4294967296 else pins end)) + sum (reloads)) * 100 "Hit Ratio"
from v$librarycache
/
-- memoria e classificacao de disco
select a.value "Disk Sorts", b.value "Memory Sorts",
       round((100*b.value) / decode ((a.value+b.value),0,1,(a.value+b.value)),2) 
       "Pct Memory Sorts"
from v$sysstat a, v$sysstat b
where a.name = 'sorts (disk)'
  and b.name = 'sorts (memory)'
/

/*
-- buffers de dados livres
-- executar como SYS
select decode (state,0, 'FREE',
       1,decode(lrba_seq,0,'AVAILABLE','BEING USED'),
       3, 'BEING USED', state) "BLOCK STATUS",
       count(*)
from sys.x$bh
group by decode(state,0,'FREE',1,decode (lrba_seq,0,'AVAILABLE','BEING USED'),
                                                   3,'BEING USED',state)  
/
*/

-- percentutal das 10 instrucoes com a maior utilização de memoria 
-- sql alternativo
select sum(pct_bufgets)
from (select rank() over (order by buffer_gets desc) as rank_bufgets,
             to_char(100 * ratio_to_report(buffer_gets) over (), '999.99') pct_bufgets
        from v$sqlarea)
where rank_bufgets < 11
/
/*
-- lista as 25 piores instruções utilizadores de memória
set serveroutput on size 1000000
declare
  top25 number;
  text1 varchar2(4000);
  x number;
  len1 number;
  i number;
cursor c1 is 
  select buffer_gets, substr(sql_text,1,4000)
  from v$sqlarea
  order by buffer_gets desc;
begin
  dbms_output.put_line('Gets    Text');
  dbms_output.put_line('-----   --------------');
  open c1;
  for i in 1..25 loop
    fetch c1 into top25, text1;
    dbms_output.put_line(rpad(to_char(top25),9)||' '||substr(text1,1,66));
    len1 := length(text1);
    x:= 66;
    while len1 > x-1 loop
      dbms_output.put_line('          '||substr(text1,x,66));
      x:= x+ 66;
    end loop;
  end loop; 
end;
/
              


-- percentual das 10 instrucoes com o maior acesso a disco
select sum(pct_bufgets) from
  (select rank() over (order by disk_reads desc) as rank_bufgets,
    to_char(100 * ratio_to_report(disk_reads) over (), '999.99') pct_bufgets
        from v$sqlarea)
where rank_bufgets < 11
/
         
*/
