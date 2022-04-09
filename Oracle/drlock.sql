SELECT *
from drlock7.tb_usuar a
WHERE A.USUAR_LOGNAME='F01191';

SELECT usuar_senha
from drlock.tb_usuar a
WHERE A.USUAR_LOGNAME='F01191';

update drlock.tb_usuar
set usuar_senha='YZQi2RtRq.lock5', usuar_sit='A'
where USUAR_LOGNAME='F01191';

commit;


select * --usuar_logname LOGIN, usuar_nome NOME , usuar_sit SITUACAO, usuar_datcad "DATA CAD", usuar_ultimologin "ULTIMO LOGIN"
from drlock.tb_usuar a
order by 1
/


select * 
from drlock7.tb_aplbd


--select table_name from dba_Tables where owner='DRLOCK7'

SELECT *
from drlock.tb_usuar a
WHERE A.USUAR_LOGNAME='F01191';

SELECT *
from drlock7.tb_usuar a
WHERE A.USUAR_LOGNAME='F01191';



create index att.fcesp_parcela_opp_thiago on 
Att.tb_parcela (ANO_RECEB_PARTICIP, NUM_SEQ_RECEB_PARTIC,DAT_VENCIMENTO , SIT_PARCELA )
tablespace ts_att_ix_03 
/
