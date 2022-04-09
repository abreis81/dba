set echo off
set feed on

accept os prompt "OS: "
accept data_inicial prompt "Data Inicial(dd/mm/yyyy hh24:mi): "
accept data_final prompt "Data Final(dd/mm/yyyy hh24:mi): "
accept usuario prompt "Usuario :"
accept permissao prompt "Permissao: "
accept owner prompt "Owner do objeto: "
accept objeto prompt "Objeto: "
accept email prompt "Email de aviso: "

exec aplic.p_grant('&&os',to_date('&&data_inicial','dd/mm/yyyy hh24:mi'),to_date('&&data_final','dd/mm/yyyy hh24:mi'),'&&permissao','&&usuario','&&owner','&&objeto','&&email',null);
