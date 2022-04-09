@REM ---------------------------------------------------------------------------
@REM  			archive_backup.cmd
@REM ---------------------------------------------------------------------------

@setlocal ENABLEEXTENSIONS
@echo off

@REM ---------------------------------------------------------------------------
@REM Determine the log file and delete that backup information does
@REM not accumulate.
@REM ---------------------------------------------------------------------------

@set RMAN_LOG_FILE="%~dpn0.out"

@if exist %RMAN_LOG_FILE% del %RMAN_LOG_FILE%

@REM ---------------------------------------------------------------------------
@REM Log the start of this scripts.
@REM ---------------------------------------------------------------------------

@for /F "tokens=1*" %%p in ('date /T') do @set DATE=%%p %%q
@for /F %%p in ('time /T') do @set DATE=%DATE% %%p

@echo ==== started on %DATE% ==== >> %RMAN_LOG_FILE%
@echo Script name: %0 >> %RMAN_LOG_FILE%

@REM ---------------------------------------------------------------------------
@REM Oracle and Rman informations.
@REM ---------------------------------------------------------------------------

@set ORACLE_SID=PPI
@set ORACLE_HOME=E:\oracle\PPI\102
@set RMAN=%ORACLE_HOME%\bin\rman.exe
@set NLS_LANG=american
@set NLS_DATE_FORMAT=YYYY-MM-DD:hh24:mi:ss

@set CATALOG_TNS=bungeppi/bungeppi@rman
@set TARGET_TNS='/'
@set POLICY_NAME=bung76orawin_arch_PPI
@set SCHED_NAME=Default-Application-Backup-PPI-arch

@REM ---------------------------------------------------------------------------
@REM Print out environment variables set in this script.
@REM ---------------------------------------------------------------------------

@echo #                                       >> %RMAN_LOG_FILE%
@echo   RMAN  :  %RMAN%                       >> %RMAN_LOG_FILE%
@echo   NLS_LANG  :  %NLS_LANG%               >> %RMAN_LOG_FILE%
@echo   ORACLE_HOME  :  %ORACLE_HOME%         >> %RMAN_LOG_FILE%
@echo   ORACLE_SID  :  %ORACLE_SID%           >> %RMAN_LOG_FILE%
@echo   NLS_DATE_FORMAT  :  %NLS_DATE_FORMAT% >> %RMAN_LOG_FILE%
@echo   RMAN_LOG_FILE  :  %RMAN_LOG_FILE%     >> %RMAN_LOG_FILE%

@REM ---------------------------------------------------------------------------
@REM Print out environment variables set in bphdb.
@REM ---------------------------------------------------------------------------

@echo   NB_ORA_SERV  :  %NB_ORA_SERV%                     >> %RMAN_LOG_FILE%
@echo   NB_ORA_FULL  :  %NB_ORA_FULL%                     >> %RMAN_LOG_FILE%
@echo   NB_ORA_INCR  :  %NB_ORA_INCR%                     >> %RMAN_LOG_FILE%
@echo   NB_ORA_CINC  :  %NB_ORA_CINC%                     >> %RMAN_LOG_FILE%
@echo   NB_ORA_CLASS  :  %NB_ORA_CLASS%                   >> %RMAN_LOG_FILE%
@echo	NB_ORA_POLICY:	%POLICY_NAME%			  >> %RMAN_LOG_FILE%
@echo	NB_ORA_SCHED:	%SCHED_NAME%			  >> %RMAN_LOG_FILE%

@if "%NB_ORA_FULL%" EQU "1" @set BACKUP_TYPE=INCREMENTAL Level=0
@if "%NB_ORA_INCR%" EQU "1" @set BACKUP_TYPE=INCREMENTAL Level=1
@if "%NB_ORA_CINC%" EQU "1" @set BACKUP_TYPE=INCREMENTAL Level=1 CUMULATIVE
@if NOT DEFINED BACKUP_TYPE @set BACKUP_TYPE=INCREMENTAL Level=0

@(
echo RUN {
echo sql 'alter system archive log current';
echo ALLOCATE CHANNEL ch00 TYPE 'SBT_TAPE';
echo send 'NB_ORA_POLICY=%POLICY_NAME%';
echo send 'NB_ORA_SCHED=%SCHED_NAME%';
echo BACKUP
echo       FILESPERSET 60
echo       FORMAT 'bkp_arch-s%%s-p%%p_t%%t'
echo       ARCHIVELOG ALL delete input;
echo RELEASE CHANNEL ch00;
echo ALLOCATE CHANNEL ch00 TYPE 'SBT_TAPE';
echo send 'NB_ORA_POLICY=%POLICY_NAME%';
echo send 'NB_ORA_SCHED=%SCHED_NAME%';
echo BACKUP
echo       FORMAT 'bkp_cntrl-s%%s-p%%p_t%%t'
echo       CURRENT CONTROLFILE;
echo RELEASE CHANNEL ch00;
echo }
) | %RMAN% target %TARGET_TNS% catalog %CATALOG_TNS% msglog '%RMAN_LOG_FILE%' append

@set ERRLEVEL=%ERRORLEVEL%

@if %ERRLEVEL% NEQ 0 @goto err

@set LOGMSG=ended successfully
@if "%STATUS_FILE%" EQU "" goto end
@echo 0 > "%STATUS_FILE%"
@goto end

:err
@set LOGMSG=ended in error
@if "%STATUS_FILE%" EQU "" @goto end
@echo 1 > "%STATUS_FILE%"

:end

@REM ---------------------------------------------------------------------------
@REM Log the completion of this script.
@REM ---------------------------------------------------------------------------

@for /F "tokens=1*" %%p in ('date /T') do @set DATE=%%p %%q
@for /F %%p in ('time /T') do @set DATE=%DATE% %%p

@echo #  >> %RMAN_LOG_FILE% 
@echo %==== %LOGMSG% on %DATE% ==== >> %RMAN_LOG_FILE%
@endlocal
@REM End of Main Program -----------------------------------------------------
