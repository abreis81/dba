select J.NEXT_DATE, J.* 
from user_jobs j
where what like '%SNAP%'
/
--
-- atrasar jobs replicacao
SELECT 'dbms_job.next_date(' || job ||',sysdate + 7);'
FROM DBA_JOBS
WHERE WHAT LIKE '%SNAP_REF_GRUPO%'
order by job
/

begin
-- incluir linhas geradas no sql anterior
commit;
end;
/

--
-- reativar jobs replicacao     
SELECT 'dbms_job.run('||job||');'
FROM DBA_JOBS
WHERE WHAT LIKE '%SNAP_REF_GRUPO%'
order by job
/

begin
-- incluir linhas geradas no sql anterior
commit;
end;
/

## para executar refresh
begin
     dbms_refresh.refresh('SNAPADMIN.SNAP_REF_GRUPO_001');
     dbms_refresh.refresh('SNAPADMIN.SNAP_REF_GRUPO_002');
     dbms_refresh.refresh('SNAPADMIN.SNAP_REF_GRUPO_003');
     dbms_refresh.refresh('SNAPADMIN.SNAP_REF_GRUPO_004');
     commit;
end;
/
