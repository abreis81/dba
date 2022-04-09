
SET FEED OFF TERM OFF
ALTER SESSION SET NLS_DATE_LANGUAGE = 'BRAZILIAN PORTUGUESE';
SET FEED ON TERM ON

set lines 999
set trim on trims on ver off pause off pages 50 newpage 0 recsep off
col status          format a9         heading 'STATUS'
col tablespace      format a15        heading 'TABLESPACE_NAME' WRA
col tablespace_name format a15        heading 'TABLESPACE_NAME' WRA
col partition_name  format a15        heading 'PARTITION_NAME'  WRA
COL partition       format a15        heading 'PARTITION_NAME'  WRA
col owner           format a12        heading 'OWNER'           WRA
col object_type     format a11        heading 'OBJECT_TYPE'     TRU
col object_name     format a30        heading 'OBJECT_NAME'     WRA
col base            format a8         heading 'BASE'            WRA
col pct_free        format 990.0      heading 'PCT|FREE'
col largest         format 99990.0    heading 'LARGEST'
col pct_ext         format 990        heading 'PCT|EXT'
col pct_incr        format 990        heading 'PCT|INCR'
col kb_initial      format 99999990   heading 'KBYTES|INITIAL'
col kb_next         format 99999990   heading 'KBYTES|NEXT'
col kbytes          format 99999990   heading 'KBYTES'
col mbytes          format 9990.00    heading 'MBYTES'
col mb_initial      format 9990.00    heading 'MBYTES|INITIAL'
col mb_next         format 9990.00    heading 'MBYTES|NEXT'
col max_extents     format 9999999990 heading 'MAX_EXTENTS'
col extents         format 999990     heading 'EXTENTS'
col histdate noprint
col datacorr new_value datacorr noprint

accept data_system prompt "Data da consulta DD/MM/YYYY ou (Enter)=Hoje: "
set term off feed off head off
select NVL(TO_DATE('&&DATA_SYSTEM','DD/MM/YYYY'),TRUNC(SYSDATE)) datacorr from dual;
set head on feed on term on
spool tablespaces_criticas.log
BTITLE OFF
TTITLE LEFT '                                        *** TABLESPACES COM POUCO ESPAÄO ***' SKIP 1 -
       LEFT '                                                      &DATACORR'              SKIP 2
SELECT * FROM FREESPACE_CRITICAL WHERE HISTDATE = NVL(TO_DATE('&&DATA_SYSTEM','DD/MM/YYYY'),TRUNC(SYSDATE));

PROMPT
TTITLE LEFT '                              *** TABELAS QUE O PR‡XIMO SEGMENTO ê MAIOR DO QUE A TABLESPACE ***' SKIP 1 -
       LEFT '                                                      &DATACORR'                                  SKIP 2
SELECT base,owner,object_name,object_type,partition_name,tablespace_name,kbytes/1024 mbytes,kb_initial/1024 mb_initial,kb_next/1024 mb_next,pct_incr,pct_ext,extents,max_extents
FROM FREENEXT_CRITICAL WHERE HISTDATE = NVL(TO_DATE('&&DATA_SYSTEM','DD/MM/YYYY'),TRUNC(SYSDATE));

PROMPT
TTITLE LEFT '                              *** TABELAS QUE O NÈMERO DE EXTENTS ESTA PR‡XIMO DO MAX_EXTENTS ***' SKIP 1 -
       LEFT '                                                      &DATACORR'                                   SKIP 2
SELECT base,owner,object_name,object_type,partition_name,tablespace_name,kbytes/1024 mbytes,kb_initial/1024 mb_initial,kb_next/1024 mb_next,pct_incr,pct_ext,extents,max_extents
FROM FREEEXTENT_CRITICAL WHERE HISTDATE = NVL(TO_DATE('&&DATA_SYSTEM','DD/MM/YYYY'),TRUNC(SYSDATE)) AND STATUS = 'EXTENT';

PROMPT
TTITLE LEFT '                              *** TABELAS QUE O NÈMERO DE MAX_EXTENTS ESTA ABAIXO DO M÷NIMO ***' SKIP 1 -
       LEFT '                                                      &DATACORR'                                 SKIP 2
SELECT base,owner,object_name,object_type,partition_name,tablespace_name,kbytes/1024 mbytes,kb_initial/1024 mb_initial,kb_next/1024 mb_next,pct_incr,pct_ext,extents,max_extents
FROM FREEEXTENT_CRITICAL WHERE HISTDATE = NVL(TO_DATE('&&DATA_SYSTEM','DD/MM/YYYY'),TRUNC(SYSDATE)) AND STATUS = 'MAXEXTENT';

TTITLE OFF
spool off

@init





