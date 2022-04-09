/*
SELECT LOCAL_TRAN_ID, STATE, COMMIT#   FROM DBA_2PC_PENDING;

SELECT LOCAL_TRAN_ID, STATE, COMMIT#   FROM DBA_2PC_PENDING;
*/
/*
LOCAL_TRAN_ID          STATE            COMMIT#
---------------------- ---------------- ----------------
31.17.20794            forced rollback  10668342234717
5.13.144754            forced rollback  8245791461950
33.20.9706                              8245791463415  ? transação pendente

Solução: rollback  force ‘33.20.9706’

ou

select * from dba_2pc_pending;

select * from sys.pending_trans$;
*/
