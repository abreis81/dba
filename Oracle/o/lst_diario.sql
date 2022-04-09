/*
  script:   lst_diario.sql 
  objetivo: Relatorio diario 
  autor:    Josivan
  data:     
*/

set linesize 100
set echo off
set verify off
set feedback off
--
clear screen
--
spool diag
--
--select * from v$database;
--
col rssize    format 999,999,999
col extents   format 999
col hwmsize   format 999,999,999
col optsize   format 999,999,999
col Rollback  format a8
--
ttitle center "Situacao dos Segmentos de RollBack" skip 2
--
select a.segment_name Rollback
      ,b.usn
      ,b.rssize
      ,b.extents
      ,b.hwmsize
      ,b.optsize
      ,b.waits
  from v$rollstat b
      ,dba_rollback_segs a
 where a.segment_id = b.usn
/
create table percent as
  select a.tablespace_name
        ,(a.bytes/1024/1024) a
        ,(b.bytes/1024/1024) b
        ,(c.bytes/1024/1024) c
        ,round((c.bytes/a.bytes)*100) d
    from sys.sm$ts_avail a
        ,sys.sm$ts_used b
        ,sys.sm$ts_free c
   where a.tablespace_name = b.tablespace_name(+)
     and a.tablespace_name = c.tablespace_name(+)
/
--
break on report
--
compute sum of a b c on report
--
col tablespace_name format a35
col a format 99,999.99 heading "Tam|Mbytes"
col b format 99,999.99 heading "Utilizado|Mbytes"
col c format 99,999.99 heading "Livre|Mbytes"
col d format 999.99    heading "%|Livre"
--
ttitle center "Relatorio da Situacao dos Tablespaces" skip 2
--
select tablespace_name
      ,a
      ,b
      ,c
      ,d
      ,decode(d,20,'WARNING'
               ,19,'WARNING'
               ,18,'WARNING'
               ,17,'WARNING'
               ,16,'WARNING'
               ,15,'WARNING'
               ,14,'WARNING'
               ,13,'WARNING'
               ,12,'WARNING'
               ,11,'WARNING'
               ,10,'ALERT'
               , 9,'ALERT'
               , 8,'ALERT'
               , 7,'ALERT'
               , 6,'ALERT'
               , 5,'DANGER' 
               , 4,'DANGER'
               , 3,'DANGER'
               , 2,'DANGER'
               , 1,'DANGER') status
  from percent
/

drop table percent;
--
column table_name       format a26         heading "Table"
column blocks           format 999,999     heading "Blocks"
column empty_blocks     format 999,999     heading "Empties"
column space_full       format 999.99      HEADING "% Full"
column num_rows         format 99,999,999  HEADING "Rows"
column chain_cnt        format 999,999     HEADING "Chains"
column avg_row_len      format 9,999       HEADING "AvgRow"
--
ttitle center "Relatorio das Tabelas com Chain" skip 2
--
  select table_name
        ,num_rows
        ,blocks
        ,empty_blocks
        ,100*((num_rows * AVG_ROW_LEN)/((GREATEST(blocks,1) + empty_blocks)* 4096)) space_full
        ,chain_cnt
        ,avg_row_len
    from dba_tables
   where tablespace_name like('TBS%')
     and chain_cnt > 1
order by table_name
/      

--
ttitle center "Next Extents que nao cabera no TABLESPACE" skip 2
--
  select substr(a.tablespace_name,1,20) Tablespace
        ,substr(a.segment_name,1,25)    Nome_do_Objeto
        ,substr(a.segment_type,1,15)    Tipo_do_objeto
        ,a.next_extent
        ,a.extents
    from dba_segments a
   where (a.next_extent) > (select b.bytes
                              from sys.sm$ts_free b
                             where b.tablespace_name = a.tablespace_name)
order by a.tablespace_name
        ,a.segment_name
/

column tablespace_name format a14
column segment_type    format a8
column segment_name    format a30
column bytes           format 999,999,999,999
column extents         format 999
--
ttitle center "Relatorio Extents > 30" skip 2
--
break on tablespace_name on segment_type
--
  select tablespace_name
        ,segment_type
        ,segment_name
        ,extents
        ,bytes
    from sys.dba_segments
   where extents >30
order by tablespace_name
        ,segment_type
        ,bytes
/
col object_name format a30
col owner       format a10
col status      format a10
--
ttitle center "Relatorio dos Objetos Invalidos " skip 2
--
select owner
      ,object_name
      ,object_type
      ,status
      ,created
 from dba_objects
where status='INVALID'
/

ttitle center "Relacao de Segmentos Cheios" Skip 2
--
  select substr(s.segment_name,1,25)   segment
        ,substr(s.segment_type,1,3)    type
        ,substr(s.owner,1,5)           owner
        ,substr(s.tablespace_name,1,8) tablespa
        ,s.extents                     seg
        ,s.bytes/1024/1024             mbytes
        ,s.initial_extent/1024/1024    minit
        ,s.next_extent/1024/1024       knext
    from sys.dba_segments s
   where not exists (select 1 
                       from sys.dba_free_space f
                      where f.tablespace_name  = s.tablespace_name 
                        and f.bytes           >= s.next_extent )
order by s.next_extent
        ,s.segment_name
        ,s.owner
/

ttitle center "Relacao de Tabelas x Espaco" Skip 2

column table_name       format a30      heading "Table"
column blocks           format 999,999  heading "Blocks" 
column empty_blocks     format 999,999  heading "Empties" 
column space_full       format 999.99   HEADING "% Full" 
column num_rows         format 99,999,999  HEADING "Rows"
column chain_cnt        format 999,999  HEADING "Chains"
column avg_row_len      format 999,999  HEADING "Avg(Bytes)"
--
  select table_name
        ,num_rows
        ,blocks
        ,empty_blocks
        ,100*((num_rows * AVG_ROW_LEN)/((GREATEST(blocks,1) + empty_blocks) * 4096)) space_full
        ,chain_cnt
        ,avg_row_len
    from dba_tables    
   where tablespace_name like('TBS%')
order by table_name
/

ttitle off
--
spool off

