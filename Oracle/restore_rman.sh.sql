#!/usr/bin/ksh
ORACLE_SID=gollog
export ORACLE_SID
NB_ORA_CLIENT=goll0021b
export NB_ORA_CLIENT
rman target / catalog gol21rman/gol21rman@rman92 msglog restore.log<<EOF
run {
allocate channel ch01 type 'SBT_TAPE';
set until time "TO_DATE('21/12/2007 18:00','dd/mm/yyyy hh24:mi')";
restore controlfile;
alter database mount;
restore database;
recover database;
release channel ch01;
}
EOF
exit;
