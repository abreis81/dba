ORACLE_HOME=/home/oracle/OraHome1
LD_LIBRARY_PATH=$ORACLE_HOME/lib
PATH=$PATH:$ORACLE_HOME/bin
ORACLE_SID=SATQ
export ORACLE_SID ORACLE_HOME LD_LIBRARY_PATH PATH

echo "
@Chamado_488025.sql
" | sqlplus -S "lf/lfvb" | sqlplus -S "lf/lfvb"

