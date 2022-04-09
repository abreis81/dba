rem Automatizando Hot Backups
rem Este script automatiza hot backup (somente disponivel em modo archivelog).
rem Sera criado o script chamado hotbackup.sql, onde sera automaticamente 
rem backupiado as tablespaces e control files.

set serveroutput on
set heading off
set feedback off
set trimspool on
set lines 500

spool /u00/oracle/scripts/hotbackup.sql

declare
 fname       varchar2(80);
 file_name3  varchar2(80);
 tname       varchar2(80);
 tname1      varchar2(80);
 file_id1    number;

cursor tspaces is
  select tablespace_name
        ,file_name
        ,file_id
    from v$datafile
        ,sys.dba_data_files
   where enabled like '%WRITE%'
     and file# = file_id
order by sys.dba_data_files.tablespace_name
        ,sys.dba_data_files.file_id;

cursor c1 is
  select substr(a.file_name
        ,instr(file_name,decode('S','N','\','n','\','/'),-1)+1) file_name2
    from dba_data_files a
        ,sys.sm$ts_free c
--  from dba_data_files a, sys.filext$ b, sys.sm$ts_free c
-- where a.file_id = file# (+)
--   and a.tablespace_name = c.tablespace_name (+) 
   where a.tablespace_name = c.tablespace_name (+) 
order by a.tablespace_name
        ,a.file_id;

begin

  dbms_output.enable(32000);
  dbms_output.put_line('spool /u00/oracle/scripts/hotbackup');
  dbms_output.put_line('!> /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!date | tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!echo Inicio backup Airmax | tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!bdf | grep archive| tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('alter system flush shared_pool;');
  dbms_output.put_line('!find /archive/log -name lf_*.arc -print > /u00/oracle/log/rmlist');
  dbms_output.put_line('alter system switch logfile;');
  dbms_output.put_line('!tar -cvfb - 64 /archive/log/*.arc | compress > /export/archive.tar.Z 2> /u00/oracle/log/archive.log');    

  open tspaces;
  fetch tspaces into tname,fname,file_id1;

  open c1;
  fetch c1 into file_name3;

  tname1 := tname;
  dbms_output.put_line('alter tablespace '||tname||' begin backup;');

  while tspaces%FOUND loop

    if tname1 != tname then
       dbms_output.put_line('alter tablespace '||tname1||' end backup;');
       dbms_output.put_line('alter tablespace '||tname||' begin backup;');
       tname1 := tname;
    end if;        

    -- Colocar o filesystem abaixo para o diretorio destino do backup.
    dbms_output.put_line
    -- Se precisar incluir o file_id no nome do arquivo
    --('!tar -cvfb - 64 '||fname||' | compress > /export/'||file_name3||file_id1||'.Z'||'  2> /u00/oracle/log/'||file_name3||file_id1||'.log');
    ('!tar -cvfb - 64 '||fname||' | compress > /export/'||file_name3||'.Z'||'  2> /u00/oracle/log/'||file_name3||'.log');

    fetch tspaces into tname,fname,file_id1;

    fetch c1 into file_name3;

  end loop;

  dbms_output.put_line('alter tablespace '||tname1||' end backup;');
  close tspaces;
  close c1;
 
  dbms_output.put_line('alter database backup controlfile to trace;');
  dbms_output.put_line('alter database backup controlfile to '||''''||'/export'||'/control.arc'||''''||' reuse; ');
  dbms_output.put_line('!date | tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!echo Removendo os Archives | tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!remsh kkairmax -l oracle -n /u00/oracle/scripts/rem_arc.sh');
  dbms_output.put_line('!bdf | grep archive| tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!echo Termino do Backup Airmax | tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('!date | tee -a /u00/oracle/log/hotbkp.log');
  dbms_output.put_line('spool off');
  dbms_output.put_line('exit;');

end;
/
spool off
set heading on
set feedback on
set trimspool off
set lines 80
set serveroutput off
-- Retirar o comentario da linha a seguir se quiser executar o script
-- ou voce podera executa-lo do prompt do sqlplus.
start /u00/oracle/scripts/hotbackup 
