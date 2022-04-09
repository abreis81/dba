set verify off
set echo off
set term off
set heading off

spool tmp7_spool.sql
	select 'spool c:\dba\'||name||'_'||to_char(sysdate,'yymonddhhmi')||'.log' 
	from sys.v_$database;
spool off

set heading on
set verify on
set term on
set serveroutput on size 1000000
set wrap off
set linesize 100 
set pagesize 1000

--
-- PACKAGE SPECIFICATION
--
create or replace package TUNE as

procedure lib;
procedure row;
procedure uga;
procedure buffer;
procedure sort_area;
procedure redo;
procedure free_list;
procedure parameter(p_in in number,result out char);

end;
/




--
-- PACKAGE BODY
--
create or replace package body TUNE as

h_char    	varchar2(100);
h_num1	number;
h_num2	number;
h_num3	number;
h_num4	number;
h_num5	number;
h_num6	number;
result1     varchar2(50);
result2     varchar2(50);
result3     varchar2(50);


-----------------------------------------------------------------------------------------------
procedure lib is 

h_char2           varchar2(50);
v_tot_obj         number := 0;
v_tot_sql         number := 0;
v_tot_ses         number := 0;

cursor c1 is
  select   lpad(namespace,17)
         ||': gets(pins)='
         ||rpad(to_char(pins),7)
         ||' misses(reloads)='
         ||rpad(reloads,7)
         ||' Ratio='
         ||decode(reloads,0,0,to_char((reloads/pins)*100,999.999))||'%'
    from sys.v_$librarycache;

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                      SHARED POOL: LIBRARY CACHE (V$LIBRARYCACHE)');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.        GETS : numero de solicitacoes ');
  dbms_output.put_line('.        PINS : numero de execucoes ');
  dbms_output.put_line('.     RELOADS : quantas vezes refez tudo' );
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('.   OBSERVACAO: a hitratio da library cache devera ser < 1%' );
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');

  PARAMETER(23 ,result1);
  PARAMETER(325,result2);

  --
  -- total de memoria em bytes para objetos
  --
  begin
    select sum(SHARABLE_MEM) 
      into v_tot_obj
      from v$db_object_cache;
  exception
    when others then
      v_tot_obj := 0;
  end;

  --
  -- total de memoria em bytes para textos sql
  --
  begin
    select sum(SHARABLE_MEM) 
      into v_tot_sql
      from v$sqlarea
     where executions > 5;
  exception
    when others then
      v_tot_sql := 0;
  end;


  --
  -- total de memoria consumida em sessoes conectadas
  --
  begin
    select sum(USERS_OPENING) 
      into v_tot_ses
      from v$sqlarea;
  exception
    when others then
      v_tot_ses := 0;
  end;

  dbms_output.put_line('. Recomendacao:  aumente SHARED_POOL_SIZE '||rtrim(result1));
  dbms_output.put_line('.                        OPEN_CURSORS '    ||rtrim(result2));
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('. Consumo real em bytes na SHARED POOL');
  dbms_output.put_line('.');
  dbms_output.put_line('.                OBJETOS: '||rtrim(to_char(v_tot_obj)));
  dbms_output.put_line('.            textos SQLs: '||rtrim(to_char(v_tot_sql)));
  dbms_output.put_line('.               CURSORES: '||rtrim(to_char(v_tot_ses)));
  dbms_output.put_line('.                         ---------------------');
  dbms_output.put_line('.  Total utilizada em MB: '||rtrim(to_char((v_tot_obj+v_tot_sql+v_tot_ses)/1024)));
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
 
  open c1;
  loop

    fetch c1 into h_char;
    exit when c1%notfound;

    dbms_output.put_line('.'||h_char);

  end loop;
  close c1;

  dbms_output.put_line('.');

  select  lpad('Total',17)
         ||': gets(pins)='
         ||rpad(to_char(sum(pins)),7)
         ||' misses(reloads)='
         ||rpad(sum(reloads),7)
          ,'.  Sua library cache ratio E: '
         ||decode(sum(reloads),0,0,to_char((sum(reloads)/sum(pins))*100,999.999))
         ||'%'
    into   h_char
          ,h_char2
    from sys.v_$librarycache;

    dbms_output.put_line('.'||h_char);
    dbms_output.put_line('.           ..............................................');
    dbms_output.put_line('.           '||h_char2);

end;


------------------------------------------------------------------------------------------
procedure row is 

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                      SHARED POOL: DATA DICTIONARY (V$ROWCACHE)');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.        GETS : numero de solicitacoes bem sucedidas');
  dbms_output.put_line('.   GETMISSES : numero de solicitacoes mal sucedidas');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('.  OBSERVACAO : o percentual devera ser < 15% ');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

  PARAMETER(23,result1);

  dbms_output.put_line('.');
  dbms_output.put_line('.RECOMENDACAO : Aumente SHARED_POOL_SIZE '||result1);
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

  select sum(gets) "gets"
        ,sum(getmisses) "misses"
        ,round((sum(getmisses)/sum(gets))*100 ,3)
    into h_num1,h_num2,h_num3
    from sys.v_$rowcache;

  dbms_output.put_line('.');
  dbms_output.put_line('.             Gets : '||h_num1);
  dbms_output.put_line('.        Getmisses : '||h_num2);

  dbms_output.put_line('.......................................');
  dbms_output.put_line('Seu ROW CACHE ratio eh '||h_num3||'%');
	
end;

------------------------------------------------------------------------------------------
procedure uga is

v_uga   varchar2(100);

cursor c_uga is
  select sum(VALUE) || ' bytes em (session uga memory)' "Total"
    from v$sesstat s
        ,v$statname n
   where s.statistic# = n.statistic#
     and name = 'session uga memory'
union all
  select sum(VALUE) || ' bytes em (session uga memory max)' "Total"
    from v$sesstat s
        ,v$statname n
   where s.statistic# = n.statistic#
     and name = 'session uga memory max';

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                      SHARED POOL: USER GLOBAL AREA ( UGA )');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.  Observacao: utilizado com opcao MTS ');
  dbms_output.put_line('.');

  open c_uga;

  loop
  
    fetch c_uga into v_uga;
    exit when c_uga%notfound;
    dbms_output.put_line('.  '||v_uga);

  end loop;
  close c_uga;

end;


------------------------------------------------------------------------------------------
procedure buffer is 

v_name	varchar2(200);
v_LRU       number := 0;

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                                       BUFFER CACHE (V$SYSSTAT)');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.  OBSERVACAO : a buffer cache ratio sempre > 90% ');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

  PARAMETER(125,result1);
  PARAMETER(131,result2);

  dbms_output.put_line('.');
  dbms_output.put_line('.RECOMENDACAO : aumente DB_BLOCK_BUFFERS     '||result1); 
  dbms_output.put_line('.                       DB_BLOCK_LRU_LATCHES '||result2);
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('. ANALISE OS EVENTOS DE ESPERA ABAIXO QUANDO O RATIO FOR BAIXO:');
  dbms_output.put_line('.');
  dbms_output.put_line('. free buffer inspected : (qtos buffers ocup. foram percor. p/ encontrar um livre)');
  dbms_output.put_line('. free buffer waits     : (numero de esperas por um bloco livre na buffer cache  )');
  dbms_output.put_line('. buffer busy waits     : (esperas por buffer que estava em memoria, porem em uso)');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');

  select lpad(name,15)
        ,value
    into h_char
        ,h_num1 
    from sys.v_$sysstat
   where name ='db block gets';

  dbms_output.put_line('.         '||h_char||': '||h_num1);
  dbms_output.put_line('.');

  select lpad(name,15)  
        ,value
    into h_char
        ,h_num2
    from sys.v_$sysstat
   where name ='consistent gets';

  dbms_output.put_line('.         '||h_char||': '||h_num2);
  dbms_output.put_line('.');

  select lpad(name,15)  
        ,value
    into h_char
        ,h_num3
    from sys.v_$sysstat
   where name ='physical reads';

  dbms_output.put_line('.         '||h_char||': '||h_num3);

  h_num4:=round(((1-(h_num3/(h_num1+h_num2))))*100,3);

  dbms_output.put_line('.......................................');
  dbms_output.put_line('. Sua buffer cache ratio eh '||h_num4||'%');

  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('. LATCH LRU: quantas vezes um processo tenta obter o LATCH');
  dbms_output.put_line('.            percentual recomendado 99%                   ');
  dbms_output.put_line('.');
  select name
        ,sleeps/gets "LRU Hitratio"
    into v_name
        ,v_LRU
    from v$latch
   where name = 'cache buffers lru chain';
  dbms_output.put_line('.');
  dbms_output.put_line('. name : '||v_name);
  dbms_output.put_line('. ratio: '||v_LRU);
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

end;


------------------------------------------------------------------------------------------
procedure sort_area is

cursor c2 is
  select name,value 
    from sys.v_$sysstat
   where name in ('sorts (memory)','sorts (disk)')
order by 1 desc;

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                      SORT STATUS (V$SYSSTAT)');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.   Observacao : Very low sort (disk)' );
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

  PARAMETER(320,result1);
  PARAMETER(321,result2);
  PARAMETER(322,result3);

  dbms_output.put_line('.');
  dbms_output.put_line('. Recomendacao : aumente SORT_AREA_SIZE '||result1);
  dbms_output.put_line('.               SORT_AREA_RETAINED_SIZE '||result2);
  dbms_output.put_line('.            SORT_MULTIBLOCK_READ_COUNT '||result3);
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line(rpad('Name',30)||'Count');
  dbms_output.put_line(rpad('-',25,'-')||'     -----------');

  open c2;
  loop

    fetch c2 into h_char,h_num1;
    exit when c2%notfound;

    dbms_output.put_line(rpad(h_char,30)||h_num1);
	
  end loop;
  close c2;
	
end;


------------------------------------------------------------------------------------------
procedure redo is 

v_bem    number;
v_mau    number;
v_perc   number;
v_tw1    number;
v_tw2    number;
v_tw3    number;
v_tw4    number;

cursor c3 is
  select a.name
        ,gets
        ,misses
        ,immediate_gets
        ,immediate_misses
    from v$latch a
        ,v$latchname b
   where b.name in ('redo allocation','redo copy')
     and a.latch#=b.latch#;

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                      REDO LOG BUFFER LATCHES (V$LATCH, V$SYSSTAT)');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.  OBSERVACAO: redo log space requests  - indica que a LOG BUFFER esta cheia e que Oracle');
  dbms_output.put_line('.                                         vai aguardar gravacao em disco para depois fazer');
  dbms_output.put_line('.                                         alocar espaco na LOG BUFFER' );
  dbms_output.put_line('.');
  dbms_output.put_line('.       redo buffer allocation retries  - numero de vezes que um processo de usuario');
  dbms_output.put_line('.                                         espera por espaco na LOG BUFFER para copiar');
  dbms_output.put_line('.                                         as novas entradas sobrepondo as que foram  ');
  dbms_output.put_line('.                                         gravadas em disco');
  dbms_output.put_line('.');
  dbms_output.put_line('.                     log buffer space  - indica se ocorreram esperas por espaco na LOG BUFFER');
  dbms_output.put_line('.                                         em decorrencia de uma sessao estar gravando dados na');
  dbms_output.put_line('.                                         LOG BUFFER com mais rapidez do que o LGWR eh capaz de');
  dbms_output.put_line('.                                         suportar');
  dbms_output.put_line('.');
  dbms_output.put_line('.                         redo entries  - indica as tentativas de gravacao na LOG BUFFER com sucesso');
  dbms_output.put_line('.');
  dbms_output.put_line('.           log file switch completion  - identifica se o LOG SWITCH foi completado');
  dbms_output.put_line('.');
  dbms_output.put_line('.log file switch (checkpoint incomplete)- identifica esperas por altern. no arquivo de log ocorridas');
  dbms_output.put_line('.                                         devido a CHECKPOINT INCOMPLETOS');
  dbms_output.put_line('.');
  dbms_output.put_line('.     log file switch (archiving needed)- identifica as esperas por alternancia no arquivo de log');
  dbms_output.put_line('.                                         devido a um problema em arquivar o REDO LOG');

  PARAMETER(195,result1);

  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('. Recomendacao: aumente LOG_BUFFER ( 5% increments )'||result1);
  dbms_output.put_line('.               percentual nao pode ser maior que 1%');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

  begin
    select value 
      into h_num1
      from sys.v_$sysstat
     where name ='redo log space requests';
  exception
   when others then
     h_num1 := 1;
  end;

  --
  -- entradas na LOG BUFFER com sucesso
  --
  begin
    select value
      into v_bem
      from sys.v_$sysstat
     where name = 'redo entries';
  exception
    when others then
       v_bem := 0;
  end;

  --
  -- entradas na LOG BUFFER sem sucesso
  --
  begin
    select value
      into v_mau
      from sys.v_$sysstat
     where name = 'redo buffer allocation retries';
  exception
    when others then
       v_mau := 1;
  end;

  --
  -- percentual
  --
  select v_mau/v_bem into v_perc from dual;

  begin
    select total_waits
      into v_tw1
      from v$system_event
     where event = 'log buffer space';
  exception
    when others then
      v_tw1 := 0;
  end;

  begin
    select total_waits
      into v_tw2
      from v$system_event
     where event = 'log file switch completion';
  exception
    when others then
       v_tw2 := 0;
  end;

  begin
    select total_waits
      into v_tw3
      from v$system_event
     where event = 'log file switch (checkpoint incomplete)';
  exception
    when others then
       v_tw3 := 0;
  end;

  begin
    select total_waits
      into v_tw4
      from v$system_event
     where event = 'log file switch (archiving needed)';
  exception
    when others then
       v_tw4 := 0;
  end;

  dbms_output.put_line('.');
  dbms_output.put_line('.                   redo log space requests: '||h_num1);
  dbms_output.put_line('.                    log buffer space event: '||to_char(v_tw1,'99999'));
  dbms_output.put_line('.     (A)    redo buffer allocation retries: '||to_char(v_mau,'99999'));
  dbms_output.put_line('.     (B)                      redo entries: '||to_char(v_bem,'99999'));
  dbms_output.put_line('.                log file switch completion: '||to_char(v_tw2,'99999'));
  dbms_output.put_line('.   log file switch (checkpoint incomplete): '||to_char(v_tw3,'99999'));
  dbms_output.put_line('.        log file switch (archiving needed): '||to_char(v_tw4,'99999'));
  dbms_output.put_line('.     percentual (A/B) : '||to_char(v_perc,'9999.99') );
  dbms_output.put_line('.');

  open c3;

  loop

    fetch c3 into h_char,h_num1,h_num2,h_num3,h_num4;
    exit when c3%notfound;

    dbms_output.put_line('....................................................................................');
    dbms_output.put_line('.           '||upper(h_char)); 
    dbms_output.put_line('.'); 
    dbms_output.put_line('.   Observacao: Ratio < 1%' );
    dbms_output.put_line('....................................................................................');
    dbms_output.put_line('.'); 
    dbms_output.put_line('. Recomendacao: Cheque Oracle tuning book para mais detalhes ');
    dbms_output.put_line('.');
    dbms_output.put_line('....................................................................................');
    dbms_output.put_line('.');
    dbms_output.put_line('.                              gets: '||h_num1);
    dbms_output.put_line('.                            misses: '||h_num2);
    dbms_output.put_line('.                    immediate_gets: '||h_num3);
    dbms_output.put_line('.                  immediate_misses: '||h_num4);
    dbms_output.put_line('.');

    if h_num1 =0 or h_num2 =0 then
       h_num5:=0;
    else
       h_num5:=round((h_num2/h_num1)*100,4);
    end if;

    if h_num4=0 or (h_num3+h_num4)=0 then
       h_num6:=0;
    else
       h_num6:=round((h_num4/(h_num3+h_num4))*100,4);
    end if;

    dbms_output.put_line('. Ratio                   (miss/gets): '||h_num5||'%');
    dbms_output.put_line('. Ratio (imm_miss)/(imm_get+imm_miss): '||h_num6||'%');
    dbms_output.put_line('.');

  end loop;

  close c3;	

end;


------------------------------------------------------------------------------------------
procedure free_list is 

cursor c_freelist is
  select  substr(s.segment_name,1,30)
        ||s.segment_type
        ||to_char(s.freelists,'99999')
        ||to_char(w.wait_time,'999999')
        ||to_char(w.seconds_in_wait,'999999')
        ||w.state    linha
    from dba_segments s
        ,v$session_wait w
   where w.event = 'buffer busy waits'
     and w.p1    = s.header_file
     and w.p2    = s.header_block;

begin

  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.                      FREE LIST (V$WAITSTAT, V$SYSSTAT)');
  dbms_output.put_line(lpad('=',100,'='));
  dbms_output.put_line('.');
  dbms_output.put_line('.   Observacao: ratio de espera devera ser < 1% ');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');
  dbms_output.put_line('.');
  dbms_output.put_line('. Recomendacao: adicione mais free lists'); 
  dbms_output.put_line('.               re-crie a tabela com um grande valor para FREELISTS');
  dbms_output.put_line('.');
  dbms_output.put_line('....................................................................................');

   select count 
     into h_num1
     from sys.v_$waitstat
    where class ='free list';

   select sum(value)
     into h_num2
     from sys.v_$sysstat
    where name in ('db block gets','consistent gets');

   h_num3:=round((h_num1/h_num2)*100,5);

   dbms_output.put_line('.');
   dbms_output.put_line('.                               Free list: '||h_num1);
   dbms_output.put_line('. soma de db_block_gets e consistent gets: '||h_num2);
   dbms_output.put_line('.');
   dbms_output.put_line('......................................................');
   dbms_output.put_line('.                         Seu Hit Ratio eh '||h_num3||'%');
   dbms_output.put_line('.');
   dbms_output.put_line('....................................................................................');
   dbms_output.put_line('.');
   dbms_output.put_line('. OBJETOS COM DISPUTAS POR FREELISTS');
   dbms_output.put_line('.');
   dbms_output.put_line('.');
   for rc_freelist in c_freelist loop
       dbms_output.put_line('. '||rc_freelist.linha );
   end loop;

end;


------------------------------------------------------------------------------------------
procedure parameter(p_in in number, result out char)  is

h_char2 varchar2(30);
h_char3 varchar2(10); 

begin

  select substr(upper(name),1,40)
        ,substr(value,1,30)
        ,isdefault
    into h_char
        ,h_char2
        ,h_char3
   from sys.v_$parameter
  where num=p_in;

  if h_char3='TRUE' then
     result:='(Current setting: '||h_char2||' DEFAULT)';
  else
     result:='(Current setting: '||h_char2||')';
  end if;

exception when others then
  dbms_output.put_line('Unknown parameter ID:'||p_in);
           
end;


end; -- fim da package body
/








--
-- CRIACAO DAS VISOES TEMPORARIAS
--
create or replace view temprpt_objects as
  select 0 col1
        ,'Oracle Users' obj_name
        ,to_char(count(*) ,'999,999') obj_count 
    from sys.dba_users
   where username not in ('SYS','SYSTEM')
group by 'Oracle Users'
UNION  
  select decode(object_type,'TABLE',1
                           ,'INDEX',2
                           ,'TRIGGER',3 
                           ,'VIEW',5
                           ,'SYNONYM',6
                           ,'PACKAGE',7
                           ,'PACKAGE BODY',8
                           ,'PROCEDURE',9
                           ,'FUNCTION',10 ,100)
        ,decode(object_type,'INDEX','     INDEX','TRIGGER','     TRIGGER',object_type)
        ,to_char(count(*) ,'999,999') 
    from sys.dba_objects
   where owner not in ('SYS','SYSTEM')
     and object_name != 'TUNE'
     and object_name not like 'TEMPRPT_%'
group by object_type	
UNION  
  select 4
        ,'     CONSTRAINT('||decode(constraint_type,'C','Check)'
                                                   ,'P','Primary)'
                                                   ,'U','Unique)'
                                                   ,'R','Referential)'
                                                   ,'V','Check View)'
                                                   ,constraint_type||'(')
        ,to_char(count(*) ,'999,999')
    from sys.dba_constraints
   where owner not in ('SYS','SYSTEM')
group by constraint_type;

create or replace view temprpt_total_Free as
select sum(bytes) free
from sys.dba_Free_space;

create or replace view temprpt_free as 
  select tablespace_name
        ,sum(bytes) free
    from sys.dba_Free_space
group by tablespace_name;

create or replace view temprpt_bytes as
  select tablespace_name
        ,sum(bytes) bytes 
    from sys.dba_data_files
group by tablespace_name;

create or replace view temprpt_status as
select a.tablespace_name
      ,free
      ,bytes
  from temprpt_bytes a
      ,temprpt_free b
 where a.tablespace_name=b.tablespace_name(+);

create or replace view temprpt_frag1 as
  select tablespace_name
        ,count(*) frag
        ,sum(bytes) frag_sum
    from sys.dba_Free_space 
group by tablespace_name;

create or replace view temprpt_frag2 as
  select tablespace_name
        ,max(bytes) max
        ,min(bytes) min
        ,avg(bytes) avg_size
    from sys.dba_Free_space 
group by tablespace_name;

create or replace view temprpt_next_vw as
  select b.tablespace_name
        ,max(bytes) next_ext
    from sys.dba_free_space b
group by tablespace_name;

create or replace view temprpt_total_obj as
select count(*) total 
  from sys.dba_objects;








--
-- INICIO DA EXECUCAO
--
@tmp7_spool.sql

set feedback off
set heading off

select 'Report Date: '||to_char(sysdate,'Monthdd, yyyy hh:mi')
from dual;

set heading on
prompt ====================================================================================================   
prompt .                      DATABASE (V$DATABASE) (V$VERSION)
prompt ====================================================================================================   
select NAME "Database Name"
      ,CREATED "Created"
      ,LOG_MODE "Status"
  from sys.v_$database;

select banner "Current Versions" 
  from sys.v_$version;

prompt .
prompt ====================================================================================================   
prompt .                      SGA SIZE (V$SGA) (V$SGASTAT)
prompt ====================================================================================================   
select decode(name,'Database Buffers'
                  ,'Database Buffers (DB_BLOCK_SIZE*DB_BLOCK_BUFFERS)'
                  ,'Redo Buffers'
                  ,'Redo Buffers     (LOG_BUFFER)',name) "Memory"
      ,to_char(value,'9,999,999,999') "   Size"
  from sys.v_$sga
UNION ALL 
select '------------------------------------------------------'
      ,'---------------'
  from dual
UNION ALL
select 'Total Memory' "Type"
      ,to_char(sum(value),'9,999,999,999') 
  from sys.v_$sga;


prompt .
prompt .
prompt Current Break Down of (SGA) Variable Size 
  select a.name                                   "Name" 
        ,to_char(bytes,'999,999,999')             "   Bytes" 
        ,to_char((bytes/b.value)*100,999.99)||'%' "PCT used" 
        ,to_char(b.value,'999,999,999')           "Var. Size"
    from sys.v_$sgastat a
        ,sys.v_$sga b
   where a.name not in ('db_block_buffers','fixed_sga','log_buffer')
     and b.name='Variable Size'
order by 3 desc;


prompt .
prompt ====================================================================================================   
prompt .                       ATIVIDADE GERAL DA INSTANCE ( CLASS = 1 )
prompt ====================================================================================================   
prompt .
prompt .session pga memory - quantidade de memoria utilizada na PGA ( dedicated server )
prompt .session uga memory - quantidade de memoria utilizada na UGA ( MTS )
prompt .logons cumulative  - quantidade logins acumulado
prompt .
prompt ....................................................................................................
select name
      ,value
  from v$sysstat
 where class=1;

prompt .
prompt ====================================================================================================   
prompt .                       ATIVIDADE DO REDO LOG BUFFER ( CLASS = 2 )
prompt ====================================================================================================   
select name
      ,value
  from v$sysstat
 where class=2;

prompt .
prompt ====================================================================================================   
prompt .                    ATIVIDADE DO DATA BASE BUFFER CACHE ( CLASS = 8 )
prompt ====================================================================================================   
prompt .
prompt .consistent gets - numero de blocos aces. na buffer cache para consultas sem a clausuda FOR UPDATE
prompt .db block gets   - numero de blocos aces. buffer cache para instr. INSERT,UPDATE,SELECT FOR UPDATE
prompt .physical reads  - operacoes de i/o em disco
prompt .
prompt ....................................................................................................
select name
      ,value
  from v$sysstat
 where class=8;

prompt .
prompt ====================================================================================================   
prompt .                    ATIVIDADE DOS ACESSOS AS TABELAS ( CLASS = 64 )  
prompt ====================================================================================================   
select name
      ,value
  from v$sysstat
 where class=64;

prompt .
prompt ====================================================================================================   
prompt .           TEMPOS ACUMULADOS DOS EVENTOS QUE ESPERARAM POR UM RECURSO (V$SYSTEM_EVENT)
prompt ====================================================================================================   
prompt .
prompt .free buffer wait        - espera por um buffer livre
prompt .latch free              - latch livre
prompt .buffer busy waits       - esperas por buffer ocupados
prompt .db file sequential read - leitura sequencial de arquivo na base de dados 
prompt .db file scattered read  - leitura dispersa de arquivo na base de dados
prompt .db file parallel write  - gravacao paralela de arquivo na base de dados
prompt .undo segment tx slot    - desfazer slot de transacao de segmento
prompt .undo segment extension  - desfazer extensao de segmento
prompt .
prompt ....................................................................................................
select event
      ,total_waits
  from v$system_event
order by 2 desc;

prompt .
prompt ====================================================================================================   
prompt .                      SHARED POOL (V$SHARED_POOL_RESERVED)
prompt ====================================================================================================   
prompt .
prompt .request_failures  - numero de vezes que nenhuma memoria foi local. para satisf. uma solic.
prompt .last_failure_size - tamanho da ultima solicitacao que falhou
prompt .request_misses    - numero de vezes que a lista fornecida nao teve uma parc de memoria
prompt .                    livre para satisf. solic. e comecou a descarregar obj da LRU
prompt .
prompt ....................................................................................................
prompt .
prompt .RECOMENDACAO: request_failures deve ser muito baixo, se tiver aumentando aumente SHARED_POOL_SIZE
prompt .
prompt ....................................................................................................
select request_failures
      ,last_failure_size
      ,request_misses
  from v$shared_pool_reserved;

prompt .
prompt ====================================================================================================   
prompt .             SHARED POOL: OBJETOS GRANDES QUE NAO ESTA PINADOS (V$DB_OBJECT_CACHE)
prompt ====================================================================================================   
column owner format a15
column name format a30
select owner
      ,name
      ,loads
      ,executions
      ,pins
  from v$db_object_cache
 where sharable_mem > 100000
   and type=any('PACKAGE','PACKAGE BODY','FUNCTION','PROCEDURE')
   and kept='NO';

prompt .
prompt ====================================================================================================   
prompt .                      SHARED POOL: BLOCOS DE PL/SQL (V$SQLAREA)
prompt ====================================================================================================   
prompt .
prompt .COMENTARIO: blocos de PL/SQL fragmentam a SHARED POOL, converte-los em procedure ou fazer pin 
prompt .
prompt ....................................................................................................
select sql_text 
  from v$sqlarea
 where command_type=47
   and length(sql_text) > 500;

prompt .
prompt ====================================================================================================   
prompt .                                SGA : LARGE POOL
prompt ====================================================================================================   
prompt .
prompt . A large pool eh uma nova area de memoria no Oracle 8, sua finalidade eh:
prompt . memoria para sessao nos servidores MTS
prompt . operacoes de backup e recovery no Oracle
prompt . processos de servidor I/O: DBWR_IO_SLAVES
prompt . A LARGE POOL evita overhead de desempenho causado pela compactacao do cache SQL compartilhado
prompt . configure a LARGE POOL com valores de 2 a 4M
prompt .
prompt ....................................................................................................
select * 
  from v$sgastat
 where pool='large pool';

prompt .
prompt ====================================================================================================   
prompt .                      DATABASE STATISTIC (DBA_DATA_FILES)
prompt ====================================================================================================   
  select count( distinct tablespace_name)                          "Tablespaces"  
        ,count(tablespace_name)-count(distinct tablespace_name)    "Datafiles added"  
        ,to_char(sum(bytes),'999,999,999,999')                     "Total Size" 
        ,to_char(sum(bytes)-free,'999,999,999,999')                "Total Used" 
        ,to_char(sum(bytes)-(sum(bytes)-free),'999,999,999,999')   "Total Free" 
        ,to_char(((sum(bytes)-free)/sum(bytes))*100,'999.99')||'%' "PCT Used"
    from sys.dba_data_files
        ,temprpt_total_Free
group by free;

set feedback ON 

prompt .
prompt ====================================================================================================   
prompt .                      PROFILES (DBA_PROFILES) 
prompt ====================================================================================================   
  select profile "Profile"
        ,resource_name "Resource"
        ,limit "Limit"
    from sys.dba_profiles
order by 1;


prompt ====================================================================================================   
prompt .                                        ROLES (DBA_ROLES) 
prompt ====================================================================================================   
  select role "Role"
        ,password_required "Password"
    from sys.dba_roles
order by 1;


prompt ====================================================================================================   
prompt .                      RESUMO DOS OBJETOS ( EXCETO SYS E SYSTEM ) (DBA_OBJECTS) 
prompt ====================================================================================================   
set feedback off
  select rpad(obj_name,35,'.') "Objects"
        ,obj_count "Count"
    from temprpt_objects
order by col1;


set feedback ON
set heading ON

prompt .
prompt ====================================================================================================   
prompt .                      LISTA DE OWNERS COM > 5% DO TOTAL DE OBJETOS (DBA_OBJECTS)
prompt ====================================================================================================   
  select owner                                        "Owner" 
        ,count(*)                                     "Count"  
        ,to_char(total,'999,999,999')                 "Total Objects" 
        ,to_char((count(*)/total) *100,'999.99')||'%' "Owned"
    from sys.dba_objects a, temprpt_total_obj b
group by owner,total
  having ((count(*)/total) *100 ) > 5
order by 4 desc;


prompt ====================================================================================================   
prompt .                      ROLLBACK SEGMENT LISTINGS (DBA_ROLLBACK_SEGS)
prompt ====================================================================================================   
  select substr(tablespace_name,1,10)          "Tablespaces" 
        ,substr(segment_name,1,10)             "Segments" 
        ,to_char(initial_extent,'999,999,999') "Initial" 
        ,to_char(next_extent,'999,999,999')    "Next" 
        ,to_char(pct_increase,'999,999,999')   "PCT_increase" 
        ,status                                "Status"
    from sys.dba_rollback_Segs
order by 1,2;


execute tune.lib
execute tune.row
execute tune.uga
execute tune.buffer
execute tune.free_list
execute tune.sort_area



prompt ====================================================================================================   
prompt .                      CONTENCAO PARA MULTI THREADED SERVER PROCESSES (V$DISPATCHER)
prompt ====================================================================================================   
prompt .       
prompt .    Observacao:    Busy rate should be < 50%
prompt .
prompt ....................................................................................................
column "Protocol" format a20
column "Total busy rate" format 999.9999 
  select network "Protocol"
        ,sum(busy)
        ,sum(idle)
        ,round((sum(busy)/(sum(busy)+sum(idle)))*100,4)||'%' "Total busy rate"
    from v$dispatcher
group by network;

  select network "Protocol"
        ,decode(sum(totalq),0,'No Responses'
        ,round(sum(wait)/sum(totalq),5)||' hundredths of seconds') "Average Wait Time"
    from v$queue q, v$dispatcher d
   where q.type='DISPATCHER'
     and q.paddr=d.paddr
group by network;




prompt ====================================================================================================   
prompt .                   CONTENCAO PARA COMPARTILHAMENTO DE SERVER PROCESSES (V$QUEUE)
prompt ====================================================================================================   
prompt .
prompt .    Observacao:  Wait time should not increase over time
prompt .
prompt ....................................................................................................
select decode(totalq,0,'No Responses',round(wait/totalq,5)||' hundredths of seconds') "Average Wait Time"
  from sys.v_$queue q
 where q.type='COMMON';

execute tune.redo

prompt ====================================================================================================   
prompt .                      VARREDURAS INTEGRAL DE TABELAS (V$SESSION_LONGOPS)        
prompt ====================================================================================================   
select sid
      ,serial#
      ,to_char(start_time,'hh24:mi:ss') inicio
      ,(sofar/nvl(totalwork,1))*100 "perc completado"
  from v$session_longops;

prompt ====================================================================================================   
prompt .                           MONITORANDO CHECKPOINTS (ARCHIVED LOGS)                
prompt ====================================================================================================   
prompt .
prompt . background checkpoints started   - checkpoints no segundo plano iniciados
prompt . background checkpoints completed - checkpoints no segundo plano concluidos
prompt . DBWR checkpoint write requests   - um numero elevado indica excesso de checkpoints
prompt .
prompt ....................................................................................................
select name
      ,value
  from v$sysstat
 where name = any('background checkpoints started', 
                  'background checkpoints completed',
                  'DBWR checkpoints write requests');

prompt ====================================================================================================   
prompt .                      DATABASE FILE - LEITURA E ESCRITA (V$DATAFILE, V$FILESTAT)
prompt ====================================================================================================   

create or replace view j_filestat_sum (sumphyrds, sumphywrts) as
select sum(phyrds)
      ,sum(phywrts)
  from v$filestat;

column "DATAFILE" format a70
column "PARTITION" format a10
column "PCT_READS" format 999.99
column "PCT_WRITES" format 999.99
--
break on "PARTITION" skip 1
--
compute sum of "READS"      on "PARTITION"
compute sum of "PCT_READS"  on "PARTITION"
compute sum of "WRITES"     on "PARTITION"
compute sum of "PCT_WRITES" on "PARTITION"
--
  SELECT SUBSTR(b.name, 1, INSTR(b.name,'/', 2)) "PARTITION"
        ,substr(b.name,1,70)                     "DATAFILE"
        ,phyrds                                  "READS"
        ,(phyrds/sumphyrds) * 100                "PCT_READS"
        ,phywrts                                 "WRITES"
        ,(phywrts/sumphywrts) * 100              "PCT_WRITES"
    FROM v$filestat a
        ,v$datafile b
        ,j_filestat_sum
   WHERE a.file# = b.file#
ORDER BY SUBSTR(b.name, 1, INSTR(b.name,'/', 2));

DROP VIEW j_filestat_sum;

  select substr(name,1,70) "Datafile"
        ,sum(phyrds)
        ,sum(phyblkrd)
        ,sum(phywrts)
        ,sum(phyblkwrt)
    from v$datafile a
        ,v$filestat b
   where a.file#=b.file#
group by substr(name,1,20);


prompt ====================================================================================================   
prompt .                            I/O DE SESSOES (V$SESS_IO)
prompt ====================================================================================================   
column logical  format 99,999,999 
column physical format 99,999,999
column ratio    format 999.99
select 'SOMATORIA DE I/O EM TODAS AS SESSOES: ' status
      ,sum(consistent_gets)+sum(block_gets) "Logical"
      ,sum(physical_Reads) "Physical"
      ,((sum(consistent_Gets)+sum(block_gets))/(sum(consistent_Gets)+sum(block_Gets)+sum(physical_reads)))*100 "Ratio" 
  from v$sess_io;


prompt ====================================================================================================   
prompt .                      TABLESPACE USAGE (DBA_DATA_FILES, DBA_FREE_SPACE)
prompt ====================================================================================================   
  select substr(tablespace_name,1,30)                      "Tablesapce" 
        ,to_char(bytes,'99,999,999,999')                   "Size" 
        ,to_char(nvl(bytes-free,bytes),'99,999,999,999')   "Used" 
        ,to_char(nvl(free,0),'99,999,999,999')             "Free" 
        ,to_char(nvl(100*(bytes-free)/bytes,100),'999.99')||'%'     "Used"
    from temprpt_status
order by 5 desc;

set feedback off
select rpad('Total',30,'.')                                 " " 
      ,to_char(sum(bytes),'99,999,999,999')                 " " 
      ,to_char(sum(nvl(bytes-free,bytes)),'99,999,999,999') " " 
      ,to_char(sum(nvl(free,0)),'99,999,999,999')           " " 
      ,to_char((100*(sum(bytes)-sum(free))/sum(bytes)),'999.99')||'%' " "
  from temprpt_status;
set feedback on

prompt .
prompt ====================================================================================================   
prompt .                       FRAGMENTACAO DE TABLESPACE (DBA_SEGMENTS)
prompt ====================================================================================================   
  select substr(a.tablespace_name,1,30)       "Tablespace" 
        ,count(*)                             "Segments" 
        ,sum(extents)-count(*)                "Extents" 
        ,sum(extents)                         "Total"  
        ,to_char((decode(sum(extents)-count(*),0,0,(sum(extents)-count(*))/count(*)))*100 ,'99,999')||'%' "Growth" 
    from sys.dba_segments a
group by a.tablespace_name
order by 3 desc;


prompt ====================================================================================================   
prompt .                           ESPACO LIVRE FRAGMENTADO (DBA_FREE_SPACE)
prompt ====================================================================================================   
  select substr(b.tablespace_name,1,30)        "Tablespace" 
        ,to_char(b.frag_sum,'99,999,999,999')  "Available  Size"  
        ,to_char(frag,'99,999')                "Fragmentation"  
        ,to_char(c.avg_size,'9,999,999,999')   "Average_size" 
        ,to_char(max,'9,999,999,999')          "   Max" 
        ,to_char(min,'9,999,999,999')          "   Min"
    from temprpt_Frag1 b, temprpt_frag2 c
   where b.tablespace_name=c.tablespace_name
order by 3 desc ;


prompt ====================================================================================================   
prompt .              SEGMENTOS QUE VAI FALHAR DURANTE O PROXIMO EXTENT (DBA_SEGMENTS)
prompt ====================================================================================================   
select substr(a.tablespace_name,1,40)       "Tablespaces" 
      ,substr(a.segment_name,1,40)          "Segment" 
      ,to_char(a.next_extent,'999,999,999') "NEXT Needed" 
      ,to_char(b.next_ext,'999,999,999')    "MAX Available"
  from sys.dba_segments a
      ,temprpt_next_vw b
 where a.tablespace_name=b.tablespace_name
   and b.next_ext < a.next_extent;


prompt ====================================================================================================   
prompt .                      ATENCAO: ESTES SEGMENTOS > 70% DE MAX EXTENT (DBA_SEGMENTS) 
prompt ====================================================================================================   
select tablespace_name           "Tablespace" 
      ,substr(segment_name,1,40) "Segment" 
      ,extents                   "Used"  
      ,max_extents               "Max"
  from sys.dba_segments 
 where (extents/decode(max_extents,0,1,max_extents))*100 > 50
   and max_extents >0;


prompt ====================================================================================================   
prompt .                    LISTA DE OBJETOS COM MAIS DE 5 EXTENTS (DBA_EXTENTS)
prompt ====================================================================================================   
break on "Tablespace_ext" skip 1   
  select substr(tablespace_name,1,30) "Tablespace_ext"  
        ,substr(segment_name,1,40)    "Segment" 
        ,count(*)                     "Count"
    from sys.dba_extents  
group by tablespace_name
        ,segment_name
  having count(*)>5
order by 1,3 desc;


prompt ====================================================================================================   
prompt .                      LISTA DE PARAMETROS DO INIT.ORA (V$PARAMETER)
prompt ====================================================================================================   
  select substr(name,1,40)              "Parameter" 
        ,substr(value,1,40)             "Value" 
        ,substr(isdefault,1,7)          "Default" 
        ,num                            "ID" 
    from sys.v_$parameter
order by 1;


prompt ====================================================================================================   
prompt End of Report

spool off 



--
-- DROPANDO VISOES TEMPORARIAS
--
drop package tune;
drop view temprpt_objects;
drop view temprpt_total_Free; 
drop view temprpt_Free;
drop view temprpt_bytes;
drop view temprpt_status;
drop view temprpt_frag1;
drop view temprpt_frag2;
drop view temprpt_next_vw;
drop view temprpt_total_obj;

/* run dynamic editor file */
--@tmp7_vi.sql

/* Remove temp spool scripts */
--host rm tmp7_*.sql




