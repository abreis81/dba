spool upd_sep.out
update leg_read_sep
set BRD_PT='SDU', OFF_PT='CDI'
where FL_NUM='40' and BRD_PT='SDU' and OFF_PT='QXD'
and FDATE between '09/08/1998' and '10/20/1998';

update leg_read_sep
set BRD_PT='CDI', OFF_PT='ITP'
where FL_NUM='40' and BRD_PT='QXD' and OFF_PT='ITW'
and FDATE between '09/08/1998' and '10/20/1998';

update leg_read_sep
set BRD_PT='ITP', OFF_PT='SDU'
where FL_NUM='41' and BRD_PT='ITW' and OFF_PT='SDU'
and FDATE between '09/08/1998' and '10/20/1998';

update leg_read_sep
set BRD_PT='SDU', OFF_PT='ITP'
where FL_NUM='42' and BRD_PT='SDU' and OFF_PT='ITW'
and FDATE between '09/08/1998' and '10/20/1998';

update leg_read_sep
set BRD_PT='ITP', OFF_PT='CDI'
where FL_NUM='43' and BRD_PT='ITW' and OFF_PT='QXD'
and FDATE between '09/08/1998' and '10/20/1998';

update leg_read_sep
set BRD_PT='CDI', OFF_PT='SDU'
where FL_NUM='43' and BRD_PT='QXD' and OFF_PT='SDU'
and FDATE between '09/08/1998' and '10/20/1998';
spool off
