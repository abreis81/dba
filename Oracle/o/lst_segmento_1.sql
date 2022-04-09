/*
  script:   lst_segmento_1.sql
  objetivo: quantidade de segmentos por tablespace
  autor:    Josivan
  data:     
*/

  select tablespace_name
        ,owner
        ,segment_type
        ,count(*)
    from dba_segments
group by tablespace_name
        ,owner
        ,segment_type;

/
