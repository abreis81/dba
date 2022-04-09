#!/bin/sh
# ---------------------------------------------------------------------------
#                       hot_backup.sh
# ---------------------------------------------------------------------------
#  This script uses Recovery Manager to take a hot (inconsistent) database
#  backup. A hot backup is inconsistent because portions of the database are
#  being modified and written to the disk while the backup is progressing.
#  You must run your database in ARCHIVELOG mode to make hot backups. It is
#  assumed that this script will be executed by user root. In order for RMAN
#  to work properly we switch user (su -) to the oracle dba account before
#  execution. If this script runs under a user account that has Oracle dba
#  privilege, it will be executed using this user's account.
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Determine the user which is executing this script.
# ---------------------------------------------------------------------------

CUSER=`id |cut -d"(" -f2 | cut -d ")" -f1`

# ---------------------------------------------------------------------------
# Define the log file and delete so that backup information does
# not accumulate.
# ---------------------------------------------------------------------------

DH=`date +%Y%m%d-%H%M`
RMAN_LOG_FILE=/db00/oracle/app/product/9.2.0/scripts/logs/hot_backup_hsa_prd_$DH.log

if [ -f "$RMAN_LOG_FILE" ]
then
        rm -f "$RMAN_LOG_FILE"
fi

# -----------------------------------------------------------------
# Initialize the log file.
# -----------------------------------------------------------------

echo >> $RMAN_LOG_FILE
chmod 666 $RMAN_LOG_FILE

# ---------------------------------------------------------------------------
# Log the start of this script.
# ---------------------------------------------------------------------------

echo Script $0 >> $RMAN_LOG_FILE
echo ==== started on `date` ==== >> $RMAN_LOG_FILE
echo >> $RMAN_LOG_FILE

ORACLE_USER=oracle

ORACLE_HOME=/db00/oracle/app/product/9.2.0
export ORACLE_HOME
RMAN=$ORACLE_HOME/bin/rman

# ---------------------------------------------------------------------------
# Set the target and catalog connect string.
# ---------------------------------------------------------------------------

CATALOG_TNS="@rman"
CATALOG_USER="hsa_prd/hsa_prd"
TARGET_TNS=""
TARGET_USER="/"
POLICY_NAME="bung02oraseg_hsa"
# ---------------------------------------------------------------------------
# Print out the value of the variables set by this script.
# ---------------------------------------------------------------------------

echo >> $RMAN_LOG_FILE
echo   "RMAN: $RMAN" >> $RMAN_LOG_FILE
echo   "ORACLE_USER: $ORACLE_USER" >> $RMAN_LOG_FILE
echo   "ORACLE_HOME: $ORACLE_HOME" >> $RMAN_LOG_FILE
echo   "CATALOG_TNS: $CATALOG_TNS" >> $RMAN_LOG_FILE
echo   " TARGET_TNS: $TARGET_TNS" >> $RMAN_LOG_FILE

# ---------------------------------------------------------------------------
# Print out the value of the variables set by bphdb.
# ---------------------------------------------------------------------------

echo  >> $RMAN_LOG_FILE
echo   "NB_ORA_FULL: $NB_ORA_FULL" >> $RMAN_LOG_FILE
echo   "NB_ORA_INCR: $NB_ORA_INCR" >> $RMAN_LOG_FILE
echo   "NB_ORA_CINC: $NB_ORA_CINC" >> $RMAN_LOG_FILE
echo   "NB_ORA_SERV: $NB_ORA_SERV" >> $RMAN_LOG_FILE
echo   "NB_ORA_POLICY: $NB_ORA_POLICY" >> $RMAN_LOG_FILE

echo >> $RMAN_LOG_FILE

if [ "$NB_ORA_FULL" = "1" ]
then
        echo "Full backup requested" >> $RMAN_LOG_FILE
	SCHED_NAME="Default-Application-Backup-hsa_prd"
        BACKUP_TYPE="INCREMENTAL LEVEL=0"

elif [ "$NB_ORA_INCR" = "1" ]
then
        echo "Differential incremental backup requested" >> $RMAN_LOG_FILE
        BACKUP_TYPE="INCREMENTAL LEVEL=1"

elif [ "$NB_ORA_CINC" = "1" ]
then
        echo "Cumulative incremental backup requested" >> $RMAN_LOG_FILE
        BACKUP_TYPE="INCREMENTAL LEVEL=1 CUMULATIVE"

elif [ "$BACKUP_TYPE" = "" ]
then
        echo "Default - Full backup requested" >> $RMAN_LOG_FILE
        BACKUP_TYPE="INCREMENTAL LEVEL=0"
fi

CMD_STR="
ORACLE_HOME=$ORACLE_HOME
export ORACLE_HOME
ORACLE_SID=hsa_prd
export ORACLE_SID
$RMAN target ${TARGET_USER}${TARGET_TNS} catalog ${CATALOG_USER}${CATALOG_TNS} msglog ${RMAN_LOG_FILE} append << EOF
RUN {
ALLOCATE CHANNEL ch00 TYPE 'SBT_TAPE';
send 'NB_ORA_POLICY=$POLICY_NAME';
send 'NB_ORA_SCHED=$SCHED_NAME';
BACKUP
    $BACKUP_TYPE
    SKIP INACCESSIBLE
    FILESPERSET 40
    FORMAT 'bkp_dbf_%s_%p_%t'
    DATABASE;
    sql 'alter system archive log current';
RELEASE CHANNEL ch00;
ALLOCATE CHANNEL ch00 TYPE 'SBT_TAPE';
send 'NB_ORA_POLICY=$POLICY_NAME';
send 'NB_ORA_SCHED=$SCHED_NAME';
BACKUP
    FORMAT 'bkp_cntrl_%s_%p_%t'
    CURRENT CONTROLFILE;
RELEASE CHANNEL ch00;
}
EOF
"

# Initiate the command string

if [ "$CUSER" = "root" ]
then
    su - $ORACLE_USER -c "$CMD_STR" >> $RMAN_LOG_FILE
    RSTAT=$?
else
    /bin/sh -c "$CMD_STR" >> $RMAN_LOG_FILE
    RSTAT=$?
fi

# ---------------------------------------------------------------------------
# Log the completion of this script.
# ---------------------------------------------------------------------------

if [ "$RSTAT" = "0" ]
then
    LOGMSG="ended successfully"
else
    LOGMSG="ended in error"
fi

echo >> $RMAN_LOG_FILE
echo Script $0 >> $RMAN_LOG_FILE
echo ==== $LOGMSG on `date` ==== >> $RMAN_LOG_FILE
echo >> $RMAN_LOG_FILE

exit $RSTAT
