export TERM=vt100
$ORACLE_HOME/bin/sqlplus -s /nolog <<eof
connect monitora/monsite
set serveroutput on size 1000000
set feedback off
set verify   off
undefine PID
Exec Prc_Exibe_Informacoes_Sessao (to_number('$1'),1);
Exec Prc_Exibe_Informacoes_Sessao (to_number('$1'),2);
Exec Prc_Exibe_Informacoes_Sessao (to_number('$1'),3);
eof


