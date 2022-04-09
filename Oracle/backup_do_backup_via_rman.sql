--##############################################
--Faz o backup em fita do backup feito em disco

RMAN>RUN {
ALLOCATE CHANNEL ch00 TYPE 'SBT_TAPE';
BACKUP BACKUPSET COMPLETED BEFORE 'SYSDATE-1' DELETE INPUT;
RELEASE CHANNEL ch00;
}

--###############################################
--Deleta os archives que já foram backupeados 

RMAN>delete noprompt archivelog all completed before 'sysdate-1'