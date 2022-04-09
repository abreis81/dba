spool /u00/oracle/scripts/hotbackup
!> /u00/oracle/log/hotbkp.log
!date | tee -a /u00/oracle/log/hotbkp.log
!echo Inicio backup Airmax | tee -a /u00/oracle/log/hotbkp.log
!bdf | grep archive| tee -a /u00/oracle/log/hotbkp.log
alter system flush shared_pool;
!find /archive/log -name lf_*.arc -print > /u00/oracle/log/rmlist
alter system switch logfile;
!tar -cvfb - 64 /archive/log/*.arc | compress > /export/archive.tar.Z 2> /u00/oracle/log/archive.log

alter tablespace AIRMAX_MISC_01 begin backup;
!tar -cvfb - 64 /kkdb05/kkdborafiles/tables/misc_tables_01.dbf | compress > /export/misc_tables_01.dbf.Z  2> /u00/oracle/log/misc_tables_01.dbf.log
alter tablespace AIRMAX_MISC_01 end backup;

alter tablespace AIRMAX_MISC_01_IDX begin backup;
!tar -cvfb - 64 /kkdb05/kkdborafiles/indexes/airmax_misc_01_idx_01.dbf | compress > /export/airmax_misc_01_idx_01.dbf.Z  2> /u00/oracle/log/airmax_misc_01_idx_01.dbf.log
alter tablespace AIRMAX_MISC_01_IDX end backup;

alter tablespace LEG_DATA1 begin backup;
!tar -cvfb - 64 /kkdb01/kkdborafiles/tables/leg_data1_01.dbf | compress > /export/leg_data1_01.dbf.Z  2> /u00/oracle/log/leg_data1_01.dbf.log
!tar -cvfb - 64 /kkdb02/kkdborafiles/tables/leg_data1_02.dbf | compress > /export/leg_data1_02.dbf.Z  2> /u00/oracle/log/leg_data1_02.dbf.log
alter tablespace LEG_DATA1 end backup;

alter tablespace LEG_DATA2 begin backup;
!tar -cvfb - 64 /kkdb03/kkdborafiles/tables/leg_data2_01.dbf | compress > /export/leg_data2_01.dbf.Z  2> /u00/oracle/log/leg_data2_01.dbf.log
!tar -cvfb - 64 /kkdb04/kkdborafiles/tables/leg_data2_02.dbf | compress > /export/leg_data2_02.dbf.Z  2> /u00/oracle/log/leg_data2_02.dbf.log
alter tablespace LEG_DATA2 end backup;

alter tablespace LEG_IDX_1 begin backup;
!tar -cvfb - 64 /kkdb03/kkdborafiles/indexes/leg_idx1_01.dbf | compress > /export/leg_idx1_01.dbf.Z  2> /u00/oracle/log/leg_idx1_01.dbf.log
!tar -cvfb - 64 /kkdb04/kkdborafiles/indexes/leg_idx1_02.dbf | compress > /export/leg_idx1_02.dbf.Z  2> /u00/oracle/log/leg_idx1_02.dbf.log
alter tablespace LEG_IDX_1 end backup;

alter tablespace LEG_IDX_2 begin backup;
!tar -cvfb - 64 /kkdb01/kkdborafiles/indexes/leg_idx2_01.dbf | compress > /export/leg_idx2_01.dbf.Z  2> /u00/oracle/log/leg_idx2_01.dbf.log
!tar -cvfb - 64 /kkdb02/kkdborafiles/indexes/leg_idx2_02.dbf | compress > /export/leg_idx2_02.dbf.Z  2> /u00/oracle/log/leg_idx2_02.dbf.log
alter tablespace LEG_IDX_2 end backup;

alter tablespace NEW_LEG_SEG begin backup;
!tar -cvfb - 64 /kkdb01/kkdborafiles/tables/new_leg_seg_01.dbf | compress > /export/new_leg_seg_01.dbf.Z  2> /u00/oracle/log/new_leg_seg_01.dbf.log
!tar -cvfb - 64 /kkdb02/kkdborafiles/tables/new_leg_seg_02.dbf | compress > /export/new_leg_seg_02.dbf.Z  2> /u00/oracle/log/new_leg_seg_02.dbf.log
alter tablespace NEW_LEG_SEG end backup;

alter tablespace NEW_LEG_SEG_IDX begin backup;
!tar -cvfb - 64 /kkdb04/kkdborafiles/indexes/new_leg_seg_idx_01.dbf | compress > /export/new_leg_seg_idx_01.dbf.Z  2> /u00/oracle/log/new_leg_seg_idx_01.dbf.log
alter tablespace NEW_LEG_SEG_IDX end backup;

alter tablespace ROLLBACK begin backup;
!tar -cvfb - 64 /kkdb03/kkdborafiles/rollback/rollback01_1.dbf | compress > /export/rollback01_1.dbf.Z  2> /u00/oracle/log/rollback01_1.dbf.log
!tar -cvfb - 64 /kkdb04/kkdborafiles/rollback/rollback01_2.dbf | compress > /export/rollback01_2.dbf.Z  2> /u00/oracle/log/rollback01_2.dbf.log
!tar -cvfb - 64 /kkdb05/kkdborafiles/rollback/rollback01_3.dbf | compress > /export/rollback01_3.dbf.Z  2> /u00/oracle/log/rollback01_3.dbf.log
alter tablespace ROLLBACK end backup;

alter tablespace SEG_DATA1 begin backup;
!tar -cvfb - 64 /kkdb03/kkdborafiles/tables/seg_data1_01.dbf | compress > /export/seg_data1_01.dbf.Z  2> /u00/oracle/log/seg_data1_01.dbf.log
!tar -cvfb - 64 /kkdb04/kkdborafiles/tables/seg_data1_02.dbf | compress > /export/seg_data1_02.dbf.Z  2> /u00/oracle/log/seg_data1_02.dbf.log
!tar -cvfb - 64 /kkdb03//kkdborafiles/tables/seg_data1_03.dbf | compress > /export/seg_data1_03.dbf.Z  2> /u00/oracle/log/seg_data1_03.dbf.log
!tar -cvfb - 64 /kkdb03//kkdborafiles/tables/seg_data1_04.dbf | compress > /export/seg_data1_04.dbf.Z  2> /u00/oracle/log/seg_data1_04.dbf.log
alter tablespace SEG_DATA1 end backup;

alter tablespace SEG_DATA2 begin backup;
!tar -cvfb - 64 /kkdb01/kkdborafiles/tables/seg_data2_01.dbf | compress > /export/seg_data2_01.dbf.Z  2> /u00/oracle/log/seg_data2_01.dbf.log
!tar -cvfb - 64 /kkdb02/kkdborafiles/tables/seg_data2_02.dbf | compress > /export/seg_data2_02.dbf.Z  2> /u00/oracle/log/seg_data2_02.dbf.log
!tar -cvfb - 64 /kkdb01//kkdborafiles/tables/seg_data2_03.dbf | compress > /export/seg_data2_03.dbf.Z  2> /u00/oracle/log/seg_data2_03.dbf.log
!tar -cvfb - 64 /kkdb02//kkdborafiles/tables/seg_data2_04.dbf | compress > /export/seg_data2_04.dbf.Z  2> /u00/oracle/log/seg_data2_04.dbf.log
alter tablespace SEG_DATA2 end backup;

alter tablespace SEG_IDX_1 begin backup;
!tar -cvfb - 64 /kkdb01/kkdborafiles/indexes/seg_idx1_01.dbf | compress > /export/seg_idx1_01.dbf.Z  2> /u00/oracle/log/seg_idx1_01.dbf.log
!tar -cvfb - 64 /kkdb02/kkdborafiles/indexes/seg_idx1_02.dbf | compress > /export/seg_idx1_02.dbf.Z  2> /u00/oracle/log/seg_idx1_02.dbf.log
alter tablespace SEG_IDX_1 end backup;

alter tablespace SEG_IDX_2 begin backup;
!tar -cvfb - 64 /kkdb03/kkdborafiles/indexes/seg_idx2_01.dbf | compress > /export/seg_idx2_01.dbf.Z  2> /u00/oracle/log/seg_idx2_01.dbf.log
!tar -cvfb - 64 /kkdb04/kkdborafiles/indexes/seg_idx2_02.dbf | compress > /export/seg_idx2_02.dbf.Z  2> /u00/oracle/log/seg_idx2_02.dbf.log
alter tablespace SEG_IDX_2 end backup;

alter tablespace SYSTEM begin backup;
!tar -cvfb - 64 /kkdb01/kkdborafiles/system/kkdbss01_01.dbf | compress > /export/kkdbss01_01.dbf.Z  2> /u00/oracle/log/kkdbss01_01.dbf.log
alter tablespace SYSTEM end backup;

alter tablespace TEMP begin backup;
!tar -cvfb - 64 /kkdb03/kkdborafiles/temp/temp01_01.dbf | compress > /export/temp01_01.dbf.Z  2> /u00/oracle/log/temp01_01.dbf.log
!tar -cvfb - 64 /kkdb04/kkdborafiles/temp/temp01_02.dbf | compress > /export/temp01_02.dbf.Z  2> /u00/oracle/log/temp01_02.dbf.log
alter tablespace TEMP end backup;

alter tablespace USERS begin backup;
!tar -cvfb - 64 /kkdb02/kkdborafiles/tables/user1_01.dbf | compress > /export/user1_01.dbf.Z  2> /u00/oracle/log/user1_01.dbf.log
alter tablespace USERS end backup;

alter database backup controlfile to trace;
alter database backup controlfile to '/export/control.arc' reuse;

!date | tee -a /u00/oracle/log/hotbkp.log
!echo Removendo os Archives | tee -a /u00/oracle/log/hotbkp.log
!remsh kkairmax -l oracle -n /u00/oracle/scripts/rem_arc.sh
!bdf | grep archive| tee -a /u00/oracle/log/hotbkp.log
!echo Termino do Backup Airmax | tee -a /u00/oracle/log/hotbkp.log
!date | tee -a /u00/oracle/log/hotbkp.log
spool off
exit;
