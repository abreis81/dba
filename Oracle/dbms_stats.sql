Comando utilizado p/ driblar um bug da release do nosso Oracle
Alter session set NLS_NUMERIC_CHARACTERS='.,';

Inicia a coleta de estat�stica do sistema no dicion�rio de dados
exec DBMS_STATS.gather_system_stats(gathering_mode  =>'START');

Encerra a coleta de estat�stica do sistema no dicion�rio de dados
exec DBMS_STATS.gather_system_stats(gathering_mode  =>'STOP');

Coleta as estat�sticas de todas as colunas das tabelas do schema especificado exec DBMS_STATS.gather_schema_stats('schema',estimate_percent=>dbms_stats.auto_sample_size,method_opt=>'for all columns size auto');
Coleta as estat�sticas de todos �ndces do schema especificado exec DBMS_STATS.gather_schema_stats('schema',estimate_percent=>dbms_stats.auto_sample_size,method_opt=>'for all indexes');
