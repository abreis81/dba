prompt ====================================================================================================   
prompt .        ALERTA : Objetos que não tem espaço para o NEXT_EXTENT (DBA_SEGMENTS)
prompt ====================================================================================================   

select substr(a.tablespace_name,1,40)       "Tablespaces",
       substr(a.segment_name,1,40)          "Segment",
       to_char(a.next_extent,'999,999,999') "NEXT Needed",
       to_char(b.next_ext,'999,999,999')    "MAX Available"
from sys.dba_segments a, 
     (select f.tablespace_name,max(bytes) next_ext
      from sys.dba_free_space f
      group by tablespace_name
     ) b
where a.tablespace_name=b.tablespace_name
and   b.next_ext < a.next_extent;

prompt ====================================================================================================   
prompt .        ALERTA : Estes segmentos estão > 70% do MAX_EXTENT (DBA_SEGMENTS) 
prompt ====================================================================================================   

select tablespace_name           "Tablespace",
       substr(segment_name,1,40) "Segment",
       extents                   "Used", 
       max_extents               "Max"
from   sys.dba_segments 
where   (extents/decode(max_extents,0,1,max_extents))*100 > 70
  and   max_extents >0;
