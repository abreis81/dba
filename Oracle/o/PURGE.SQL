undef transacao
alter session set "_smu_debug_mode" = 4; 

EXEC DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('&&TRANSACAO');

COMMIT;
