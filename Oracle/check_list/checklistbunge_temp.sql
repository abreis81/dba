#####################################################################################################
# Checklist díário das instâncias da BUNGE
# Autor: Elcio Inacio Santos
# Criado em: 27/11/2007
# Atualizado em: 27/11/2007
#
# Pré-requisitos
# - O usuário checklist com grant de dba deve existir nas instâncias destino
# - Deve existir a string de conexão no tnsnames.ora apontando para a instância destino
# - Deve existir o script freespace.sql no diretório $ORACLE_HOME/scripts 
#####################################################################################################

# Setup ORACLE environment
ORACLE_HOME=/db00/oracle/app/product/9.2.0
ORACLE_BASE=/db00/oracle
ORACLE_SID=hsa_prd
ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/openwin/lib
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/dt/lib:/usr/ucblib:/usr/local/libe
PATH=$PATH:/opt/local/bin:/opt/NSCPnav/bin:$ORACLE_HOME/bin
export ORACLE_BASE ORACLE_HOME ORACLE_SID ORA_NLS33 NLS_LANG LD_LIBRARY_PATH LD_LIBRARY_PATH PATH


echo '#############################################'
echo '# Inicio do Checklist BUNGE'
echo '#############################################'

sqlplus -S<< EOF
connect / as sysdba
col data_inicio for a20
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') data_inicio from dual;
quit;
EOF


echo '#######################'
echo '# HSA_PRD'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@hsa_prd
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# BNG_PRD'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@bng_prd
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# GIS_PRD'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@gis_prd
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# WPS_PRD'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@wps_prd
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# CEN06'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@cen06
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# MSBE_PRD'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@msbe_prd
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# MSBA_PRD'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@msba_prd
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF
echo '#######################'
echo '# MSBE_STG'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@msbe_stg
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF
echo '#######################'
echo '# MSBA_STG'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@msba_stg
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# HSA_DSV'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@hsa_dsv
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# BNG_STG'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@bng_stg
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# WPS_STG'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@wps_stg
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# HSA_STG'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@hsa_stg
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# GIS_STG'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@gis_stg
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# DBI'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@dbi
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# DEP'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@dep
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# DDM'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@ddm
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# QBI'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@qbi
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# QEP'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@qep
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# QDM'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@qdm
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# PBI'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@pbi
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# PEP'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@pep
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#######################'
echo '# PDM'
echo '#######################'

sqlplus -S<< EOF
checklist/checklist@pdm
set lines 155
set pages 150
select host_name,instance_name,status,to_char(startup_time,'dd/mm/yyyy hh24:mi') startup_time from v\$instance;
alter system checkpoint;
@freespace

quit;
EOF

echo '#############################################'
echo '# Final do Checklist BUNGE'
echo '#############################################'

sqlplus -S<< EOF
connect / as sysdba
col data_final for a20
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') data_final from dual;
quit;
EOF