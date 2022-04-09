ACCEPT id
set serveroutput on size 1000000
set feedback off
set verify   off
undefine PID
Exec Sp_Exibe_Informacoes_Sessao (to_number(&id),1);
Exec Sp_Exibe_Informacoes_Sessao (to_number(&id),2);
Exec Sp_Exibe_Informacoes_Sessao (to_number(&id),3);
