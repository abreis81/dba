set pages 66
set verify off
set feedback off
--
column "Parametro" format a22
column "Valor"     format a50
--
  select rpad(p.name,20,' ')||': ' "Parametro"
        ,p.value                   "Valor"
    from sys.v_$parameter p
   where p.num in (10, 16, 23, 43, 45, 50, 69, 78, 88, 91, 98, 101, 113, 141, 
                   156, 160, 161, 166, 167, 168, 169, 171, 174, 198, 199, 200, 201, 206)
order by p.num;

set verify on
set feedback on

set heading off;
set feedback off;
set pagesize 0;
set linesize 80;
set verify off;
set serveroutput on size 20000;
--
-- Levantamento Tablespace
--
declare 

  cursor cur1 is
    select tablespace_name
      from sys.dba_tablespaces
  order by tablespace_name;

  wvl_subaloca      number(14,2) := 0;
  wvl_sublivre      number(14,2) := 0;
  wvl_totaloca      number(14,2) := 0;
  wvl_totlivre      number(14,2) := 0;

begin 

  dbms_output.put_line (
  'Tablespace                       Alocado(MB)   Ocupado(MB)     Livre(MB)');
  dbms_output.put_line (
  '------------------------------  ------------  ------------  ------------');

  for reg1 in cur1 loop

    begin
      select (sum(bytes)/1024/1024)
        into wvl_subaloca
        from sys.dba_data_files
       where tablespace_name = reg1.tablespace_name;

      select sum(bytes)/1024/1024
        into wvl_sublivre
        from sys.dba_free_space
       where tablespace_name = reg1.tablespace_name;

      wvl_totaloca    := wvl_totaloca    + nvl(wvl_subaloca,0);
      wvl_totlivre    := wvl_totlivre    + nvl(wvl_sublivre,0);

      dbms_output.put_line (rpad(reg1.tablespace_name,30,' ')||
        to_char(round(nvl(wvl_subaloca,0),2),'99,999,990.00')||
        to_char(round(nvl(wvl_subaloca-wvl_sublivre,0),2),'99,999,990.00')||
        to_char(round(nvl(wvl_sublivre,0),2),'99,999,990.00'));
    end;

  end loop;

  dbms_output.put_line (
  '------------------------------  ------------  ------------  ------------');
  dbms_output.put_line ('Total                         '||
        to_char(round(wvl_totaloca,2),'99,999,990.00')||
        to_char(round(wvl_totaloca-wvl_totlivre,2),'99,999,990.00')||
        to_char(round(wvl_totlivre,2),'99,999,990.00'));

end;
/

set serveroutput off;
set verify on;
set feedback on;
set pagesize 14;
set heading on;
set term on;


set pages 66
set linesize 80
set verify off
set feedback off

clear break
break on "Tot" on "Owner" skip 1
compute sum on "Tot" of "Ocupado(MB)"
compute sum on "Owner" of "Ocupado(MB)"
column "Owner"       format a15
column "Tablespace"  format a30
column "Ocupado(MB)" format 9,999,990.00

select 'Tot' "Tot"
      ,s.owner "Owner"
      ,s.tablespace_name "Tablespace"
      ,round(sum(s.bytes)/1024/1024,2) "Ocupado(MB)"
  from sys.dba_segments s
 group by s.owner
      ,s.tablespace_name
 order by s.owner 
      ,s.tablespace_name;

set feedback off
set verify on

set pages 10000
set verify off
set feedback off

select count(*) "Qtd Total Users"
from sys.dba_users;

clear break
break on "Tot"
compute sum on "Tot" of "Qtd Users"
select 'Tot' "Tot"
      ,rp.granted_role "Granted Role"
      ,count(*) "Qtd Users"
  from sys.dba_role_privs rp
 group by rp.granted_role
 order by rp.granted_role;

set verify on
set feedback on

--alter database backup controlfile to trace noresetlogs;

--!bdf >>selevant.lst
--! echo ' '                         >>/oracle/dba/selevant.lst
--! echo '------------------------ ' >>/oracle/dba/selevant.lst
--! echo ' '                         >>/oracle/dba/selevant.lst

--! rm `grep -l 'CREATE CONTROLFILE' $ORACLE_BASE/udump/*.trc`
--! cat `grep -l 'CREATE CONTROLFILE' $ORACLE_BASE/udump/*.trc` >> /oracle/dba/ldias/tam/selevant.lst
--! rm `grep -l 'CREATE CONTROLFILE' $ORACLE_BASE/udump/*.trc`
--! cat $ORACLE_BASE/udump/*.trc >> /oracle/dba/ldias/tam/selevant.lst

