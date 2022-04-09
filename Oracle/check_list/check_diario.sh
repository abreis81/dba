#####################################################
# Checklist diario
# Autor: Helder Carvalho
# Revisor: Elcio Santos
# Data: 12/11/2007
# Finalidade: Checar a disponibilidade das bases existentes no servidor
# Obs.: Este script ira gerar o arquivo <nome do servidor>-<data invertida>-chk.log
#
# Pre-requisitos: 
#       - Existir o diretorio dba abaixo do $HOME do owner do banco de dados
# 

#!/bin/ksh -x
echo Variavies Globais
DATE_SIST=`date '+%y%m%d'`
export DATE_SIST

echo Hostname
HOSTNAME=`hostname`
export HOSTNAME

LOG_FILE=$PWD/$HOSTNAME-$DATE_SIST-chk.log
export LOG_FILE

if [ -f $LOG_FILE ] ; then
   rm $LOG_FILE
fi
touch $LOG_FILE
chmod 666 $LOG_FILE

echo 'Nome do Servidor: ' $HOSTNAME >> $LOG_FILE

echo IP
IP=`ifconfig -a | grep inet | cut -f2 -d ' '`
export IP

echo 'IP do servidor: ' $IP >> $LOG_FILE

echo Versao SO
VERSAOSO=`uname -a | awk {'print $1'}`
export VERSAOSO

echo 'Versao S.O.: ' $VERSAOSO >> $LOG_FILE

export IC_ORATAB=ls /etc/oratab | wc -l
if [ $ IC_ORATAB = 0]; then
	export ORATAB_HOME=/var/opt/oracle
else
	export ORATAB_HOME=/etc
fi

echo  ORACLE_HOME
if [ $VERSAOSO = "Aix" ]; then
   echo $VERSAOSO
   ORACLE_HOME=`cat $ORATAB_HOME/oratab | grep ^$ORACLE_SID: | cut -f2 -d':'`
fi
if [ $VERSAOSO = "SunOS" ]; then
   echo $VERSAOSO
   ORACLE_HOME=`cat $ORATAB_HOME/oratab | grep ^$ORACLE_SID: | cut -f2 -d':'`
fi
if [ $VERSAOSO = "HP-UX" ]; then
   echo $VERSAOSO
   ORACLE_HOME=`cat $ORATAB_HOME/oratab | grep ^$ORACLE_SID: | cut -f2 -d':'`
fi
export ORACLE_HOME
echo  PATH
PATH=$ORACLE_HOME/bin:$PATH
export PATH

echo  Memoria
if [ $VERSAOSO = "Aix" ]; then
   SERVER_MEMORY=`lsattr -El mem0 | grep -v 'good' | awk '{print $2}'`
fi
if [ $VERSAOSO = "SunOS" ]; then
   SERVER_MEMORY=`/usr/platform/sun4u/sbin/prtdiag | grep Memory | grep -v Module | grep -v Configuration | awk '{print $3}'`
fi
export SERVER_MEMORY

echo 'Memoria do servidor: ' $SERVER_MEMORY >> $LOG_FILE

echo CPUs Fisicas
if [ $VERSAOSO = "SunOS" ]; then
   NUM_CPUF=`psrinfo -p`
fi
export NUM_CPUF

echo 'Numero CPUs fisicas: ' $NUM_CPUF >> $LOG_FILE

echo CPUs Logicas
if [ $VERSAOSO = "SunOS" ]; then
   NUM_CPUL=`uname -X | grep NumCPU | cut -f3 -d ' '`
fi
export NUM_CPUL

echo 'Numero CPUs logicas: ' $NUM_CPUL >> $LOG_FILE

echo Instances
if [ $VERSAOSO = "SunOS" ]; then
   INSTANCES=`cat $ORATAB_HOME/oratab | cut -f1 -d ':' | grep -v ^#`
fi
export INSTANCES

echo 'Instances: ' $INSTANCES >> $LOG_FILE

function gera_script
{
if [ -f $HOME_ORACLE/dba/check_diario.sql ] ; then
   echo 'O arquivo sql existe'
else
   touch $HOME_ORACLE/dba/check_diario.sql
   chmod 666 $HOME_ORACLE/dba/check_diario.sql
   chmod 666 $HOME_ORACLE/dba/check_diario.sql
   echo "connect / as sysdba" > $HOME_ORACLE/dba/check_diario.sql
   echo "col tablespace_name for a30" >> $HOME_ORACLE/dba/check_diario.sql
   echo "col value for '999,999,999,999'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "col usado for '999,999,999,999'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "col total for '999,999,999,999'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "col livre for '999,999,999,999'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "col Porc  for '999.99'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "col What for a40" >> $HOME_ORACLE/dba/check_diario.sql
   echo "break on report" >> $HOME_ORACLE/dba/check_diario.sql
   echo "compute sum of total on report" >> $HOME_ORACLE/dba/check_diario.sql
   echo "compute sum of livre on report" >> $HOME_ORACLE/dba/check_diario.sql
   echo "compute sum of usado on report" >> $HOME_ORACLE/dba/check_diario.sql
   echo "set lines 120" >> $HOME_ORACLE/dba/check_diario.sql
   echo "set pages 200" >> $HOME_ORACLE/dba/check_diario.sql
   echo "alter session set nls_date_format='DD/MM/YYYY HH24:MI:SS'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "spool $HOME_ORACLE/dba/check_diario.log" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select 'Instance no ar desde: ', STARTUP_TIME from v\$instance" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select 'SGA Total: ', sum(value) value from v\$sga" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select value ALERT_LOG from v\$parameter where name = 'background_dump_dest'" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select 'Tablespaces' from dual" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select a.tablespace_name Tablespace_Name, b.bytes total, a.bytes livre, b.bytes-a.bytes usado, round((a.bytes/b.bytes)*100,2) Porc" >> $HOME_ORACLE/dba/check_diario.sql
   echo "from (select tablespace_name, sum(bytes) bytes" >> $HOME_ORACLE/dba/check_diario.sql
   echo "      from dba_free_space" >> $HOME_ORACLE/dba/check_diario.sql
   echo "      group by tablespace_name) a," >> $HOME_ORACLE/dba/check_diario.sql
   echo "     (select tablespace_name, sum(bytes) bytes" >> $HOME_ORACLE/dba/check_diario.sql
   echo "      from dba_data_files" >> $HOME_ORACLE/dba/check_diario.sql
   echo "      group by tablespace_name) b" >> $HOME_ORACLE/dba/check_diario.sql
   echo "where a.tablespace_name = b.tablespace_name" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select 'Ultima atualizacao de objeto : '|| max(LAST_DDL_TIME) from dba_objects where owner not in ('SYS','SYSTEM')" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >>$HOME_ORACLE/dba/check_diario.sql
   echo "select 'JOBS' from dual" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "select job, what, last_date ULT_EXEC, next_date PROX_EXEC, broken ATIVO, failures FALHAS from dba_jobs" >> $HOME_ORACLE/dba/check_diario.sql
   echo "/" >> $HOME_ORACLE/dba/check_diario.sql
   echo "spool off" >> $HOME_ORACLE/dba/check_diario.sql 
   echo "exit" >> $HOME_ORACLE/dba/check_diario.sql
fi
}

function fsqlplus
{
su - $ORACLE_OWNER -c "ORACLE_SID=$ORACLE_SID;export ORACLE_SID;sqlplus /nolog @$HOME_ORACLE/dba/check_diario.sql"
cat $HOME_ORACLE/dba/check_diario.log | grep -v \' | cut -f1- -d ' ' >> $LOG_FILE
}

function list_status
{
for i in `ps -ef | grep -i tns | grep -v grep | awk {'print $1 " " $10}' | grep -w $ORACLE_OWNER | cut -f2 -d" "`
do
   su - $ORACLE_OWNER -c "$ORACLE_HOME/bin/lsnrctl status $i" | grep Uptime >> $LOG_FILE
done  
}

function main_prc
{
for i in `cat $ORATAB_HOME/oratab | cut -f1 -d ':' | grep -v \#`
do
   ORACLE_SID=$i
   export ORACLE_SID
   ORACLE_HOME=`cat $ORATAB_HOME/oratab | grep $ORACLE_SID | grep -v \# | cut -f2 -d ':'`
   export ORACLE_HOME
   ORACLE_OWNER=`ps -ef | grep pmon | grep $ORACLE_SID | awk '{print $1}'`
   export ORACLE_OWNER
   HOME_ORACLE=`cat /etc/passwd | cut -f6 -d ':' | grep -w $ORACLE_OWNER`
   export HOME_ORACLE
   LIST_STAT=`ps -ef | grep -i tns | grep -v grep | awk {'print $1 " " $10}' | grep -w $ORACLE_OWNER | cut -f2 -d" "`
   export LIST_STAT
   echo '************************************************************************************************************************' >> $LOG_FILE
   echo 'Instance: ' $ORACLE_SID >> $LOG_FILE
   echo 'ORACLE_HOME: ' $ORACLE_HOME >> $LOG_FILE
   echo 'Usuario SO: ' $ORACLE_OWNER >> $LOG_FILE
   echo 'Listeners : ' $LIST_STAT >> $LOG_FILE
   list_status
   gera_script
   fsqlplus 
done
EOF
}
main_prc
EOF
