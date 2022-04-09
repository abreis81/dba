/*
  script:   segmentos_prox_extent.sql
  objetivo: Detecta quais os segmentos cujo proximo extent será maior que o espaco disponivel
            na tablespace
  autor:    Rogerio
  data:     10/05/2001
*/

set lines 500
column usuario format a10
column segmento format a30



select a.owner Usuario, a.segment_name SEGMENTO,
       b.tablespace_name Tablespace,
       decode(ext.extents,1,b.next_extent,
       a.bytes*(1+b.pct_increase/100)/1024) NEXT_EXTENT,
       (freesp.largest/1024) Livre
from dba_extents a,dba_segments b, 
      (select owner,segment_name,max(extent_id) extent_id,
      count(*) extents
      from dba_extents
      group by owner,segment_name )ext,
        (select tablespace_name,max(bytes) largest
         from dba_free_space
         group by tablespace_name) freesp
where a.owner=b.owner
and   a.segment_name = b.segment_name
and   a.owner = ext.owner
and   a.segment_name = ext.segment_name
and   a.extent_id = ext.extent_id
and   b.tablespace_name = freesp.tablespace_name
and   decode(ext.extents,1,b.next_extent,
      a.bytes*(1 + b.pct_increase/100)) > freesp.largest
/



--alter table EDGE.TBEDGE_LOG_BACK STORAGE (NEXT 100M);