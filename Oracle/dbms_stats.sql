Comando utilizado p/ driblar um bug da release do nosso Oracle
Alter session set NLS_NUMERIC_CHARACTERS='.,';

Inicia a coleta de estatística do sistema no dicionário de dados
exec DBMS_STATS.gather_system_stats(gathering_mode  =>'START');

Encerra a coleta de estatística do sistema no dicionário de dados
exec DBMS_STATS.gather_system_stats(gathering_mode  =>'STOP');

Coleta as estatísticas de todas as colunas das tabelas do schema especificado exec DBMS_STATS.gather_schema_stats('schema',estimate_percent=>dbms_stats.auto_sample_size,method_opt=>'for all columns size auto');
Coleta as estatísticas de todos índces do schema especificado exec DBMS_STATS.gather_schema_stats('schema',estimate_percent=>dbms_stats.auto_sample_size,method_opt=>'for all indexes');
