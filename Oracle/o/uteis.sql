-- saber o tamanho dos objetos do banco

select segment_name, segment_type, extents,
bytes/1024 totsize, initial_extent/1024 init, next_extent/1024 next,
pct_increase incr
from dba_segments
where owner = 'SIGA'
order by totsize desc;

--saber todos os processo ativos

select p.spid pid, s.username, s.osuser, s.status, s.program
from v$session s, v$process p
where s.status like 'ACTIVE'
and s.paddr = p.addr;


-- informações do usuário
select * 
from sys.DBA_USERS
where username='ALAN';


-- informações sobre as role que o usuário tem acesso
SELECT *
from dba_role_privs
where grantee = 'ALAN';

-- informações sobre direitos de systema
SELECT *
from dba_sys_privs
where grantee = 'ALAN'

-- informações sobre direitos sobre tabelas
SELECT *
from dba_tab_privs
where grantee = 'PERCY'

-- RELACIONA TODAS AS ROLES
SELECT * 
FROM DBA_ROLES

--

-- cria um job;
BEGIN
sys.dbms_scheduler.create_job(
job_name => '"APLIC"."ALERTA_CATRACA"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
  EXEC  APLIC.P_ALERTA_CATRACA
end;',
repeat_interval => 'FREQ=SECONDLY;INTERVAL=50',
start_date => systimestamp at time zone 'America/Sao_Paulo',
job_class => '"DEFAULT_JOB_CLASS"',
comments => 'manda email para infra-estrutura sobre passagem de aluna na catraca',
auto_drop => FALSE,
enabled => TRUE);
END;


