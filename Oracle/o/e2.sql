Clear Columns Computes Breaks
@init
Col Id              format '999'
Col Tipo            format a04
Col TableSpace      format a18
Col Bytes_Total     format '9,999,999,999,999'
Col Bytes_Livres    format '999,999,999,999'
Col Max_Bytes       format '999,999,999,999'
Col Min_Bytes       format '999,999,999,999'
col File_name       format a55
Col Frag            format '99,999'
set linesize 200
set pagesize 60
Select a1.FILE_ID            Id,            /* Número de identificação do Datafile */
       a1.TABLESPACE_NAME    TableSpace,    /* Nome da Tablespace */
       a1.BYTES              Bytes_Total,   /* Tamanho total do Datafile */
       sum(a2.bytes)         Bytes_Livres,  /* Espaço Total livre do Datafile */
       max(a2.bytes)         Max_Bytes,     /* Maior segmento contíguo no Datafile */
       min(a2.bytes)         Min_Bytes,     /* Menor segmento contíguo no Datafile */
       count(*)              Frag,          /* Quantidade de fragmentos do Datafile */
       a1.STATUS,                           /* Status Datafile (Disponível ou não) */
       a1.File_Name                         /* Path completo do Datafile */
from  dba_data_files a1, dba_free_space a2
where a1.file_id = a2.file_id
group by a1.file_id,a1.tablespace_name,a1.bytes,a1.status,a1.file_name
union
Select a1.FILE_ID            Id,
       a1.TABLESPACE_NAME    TableSpace,
       a1.BYTES              Bytes_Total,
       0                     Bytes_Livres,
       0                     Max_Bytes,
       0                     Min_Bytes,
       0                     Frag,
       a1.STATUS,
       a1.File_Name
from  dba_data_files a1
where a1.file_id not in (select distinct file_id from dba_free_space)
union
Select /*+ choose */
       t1.FILE_ID                      Id,
       t1.TABLESPACE_NAME              TableSpace,
       t1.BYTES                        Bytes_Total,
       (t1.Sum_Bytes-t2.Bytes_Used )   Bytes_Livres,
       case when t1.Sum_Bytes = t2.Bytes_Cached
       then t1.Max_Bytes
       else (t1.Sum_Bytes - t2.Bytes_Cached )
       end Max_Bytes,
       t1.Min_Bytes,
       t1.Frag,
       t1.STATUS,
       t1.File_Name
from  (Select /*+ ordered */ a1.FILE_ID,
              a1.TABLESPACE_NAME, a1.BYTES,
              sum(a2.bytes) Sum_Bytes,
              min(a2.bytes) Min_Bytes,
              max(a2.bytes) Max_Bytes,
              count(*) Frag,
              a1.STATUS,
              a1.File_Name
       from   dba_temp_files a1, V$TEMP_EXTENT_MAP a2
       where  a1.file_id = a2.file_id
       group by a1.file_id,a1.tablespace_name,
                a1.bytes,a1.status,a1.file_name) t1,
      /* Próxima sub-query utilizada no lugar de V$TEMP_EXTENT_POOL por BUG */
      (select /*+ ordered  */
              ts.name TABLESPACE_NAME, fc.ktstfctfno FILE_ID,
              fc.ktstfcec EXTENTS_CACHED, fc.ktstfceu EXTENTS_USED,
              fc.ktstfcbc BLOCKS_CACHED, fc.ktstfcbu BLOCKS_USED,
              fc.ktstfcbc*ts.blocksize BYTES_CACHED,
              fc.ktstfcbu*ts.blocksize BYTES_USED,
              fc.ktstfcfno RELATIVE_FNO
       from  ts$ ts, x$ktstfc fc
       where ts.contents$ = 1 and ts.bitmapped <> 0 and
             ts.online$ = 1 and ts.ts# = fc.ktstfctsn and
             fc.inst_id=userenv('Instance'))t2
where t1.file_id=t2.file_id
union
Select  a1.FILE_ID            Id,
        a1.TABLESPACE_NAME    TableSpace,
        a1.BYTES              Bytes_Total,
        a1.BYTES              Bytes_Livres,
        a1.BYTES              Max_Bytes,
        0                     Min_Bytes,
        1                     Frag,
        a1.STATUS,
        a1.File_Name
from dba_temp_files a1
where a1.file_id not in (select distinct file_id from V$TEMP_EXTENT_POOL)
order by 2,1
/

Clear Columns Computes Breaks
Col Tablespace     format a18
Col Tipo           format a4
Col TFiles         format '999'
Col Bytes_Total    format '9,999,999,999,999'
Col Bytes_Livres   format '999,999,999,999'
Col Max_Bytes      format '999,999,999,999'
Col Min_Bytes      format '999,999,999,999'
Col Fragtos        format '99,999'
set linesize 200
set pagesize 60
compute sum of Bytes_Total      on report
compute sum of Bytes_Livres     on report
compute sum of Fragtos          on report
break on report
select TABLESPACE,                              /* Nome da Tablespace */
       substr(contents,1,1)||
       substr(EXTENT_MANAGEMENT,1,1)||
       substr(ALLOCATION_TYPE,1,1)Tipo,         /* Tipo da Tablespace - Perm/Temp ,Dict/Local ou User/Unif/Syst */
       count(*)                   TFiles,       /* Numero de Datafiles da Tablespace */
       sum(BYTES_TOTAL)           Bytes_total,  /* Tamanho total da Tablespace */
       sum(BYTES_LIVRES)          Bytes_livres, /* Espaço Total livre da Tablespace */
       max(max_bytes)             Max_bytes,    /* Maior segmento contíguo na Tablespace */
       min(to_number(decode(min_bytes,0,null,
       min_bytes)))               Min_bytes,    /* Menor segmento contíguo na Tablespace */
       sum(Fragmentos)            Fragtos       /* Quantidade de fragmentos da Tablespace */
from (Select a1.FILE_ID           Id,
             a1.TABLESPACE_NAME   TableSpace,
             a1.BYTES             Bytes_Total,
             sum(a2.bytes)        Bytes_Livres,
             max(a2.bytes)        Max_Bytes,
             min(a2.bytes)        Min_Bytes,
             count(*)             Fragmentos
      from  dba_data_files a1, dba_free_space a2
      where a1.file_id = a2.file_id
      group by a1.file_id,a1.tablespace_name,a1.bytes,a1.status,a1.file_name
      union
      Select a1.FILE_ID           Id,
             a1.TABLESPACE_NAME   TableSpace,
             a1.BYTES             Bytes_Total,
             0                    Bytes_Livres,
             0                    Max_Bytes,
             0                    Min_Bytes,
             0                    Fragmentos
      from  dba_data_files a1
      where a1.file_id not in (select distinct file_id from dba_free_space)
      union
      Select /*+ choose */ Id, TableSpace, Bytes_Total,
             (t1.Sum_Bytes - t2.Bytes_Used) Bytes_Livres,
             case when t1.Sum_Bytes = t2.Bytes_Cached
             then Max_Bytes
             else (t1.Sum_Bytes - t2.Bytes_Cached )
             end Max_Bytes,
             Min_Bytes, Fragmentos
      from   (Select /*+ ordered */
                     a1.FILE_ID           Id,
                     a1.TABLESPACE_NAME   TableSpace,
                     a1.bytes             Bytes_total,
                     sum(a2.BYTES)        Sum_Bytes,
                     max(a2.bytes)        Max_Bytes,
                     min(a2.bytes)        Min_Bytes,
                     count(*)             Fragmentos
              from   dba_temp_files a1, V$TEMP_EXTENT_MAP a2
              where  a1.file_id = a2.file_id
              group by a1.file_id, a1.tablespace_name, a1.bytes) t1,
             /* Próxima sub-query utilizada no lugar de V$TEMP_EXTENT_POOL por BUG */
             (select /*+ ordered  */
                     ts.name TABLESPACE_NAME, fc.ktstfctfno FILE_ID,
                     fc.ktstfcec EXTENTS_CACHED, fc.ktstfceu EXTENTS_USED,
                     fc.ktstfcbc BLOCKS_CACHED, fc.ktstfcbu BLOCKS_USED,
                     fc.ktstfcbc*ts.blocksize BYTES_CACHED,
                     fc.ktstfcbu*ts.blocksize BYTES_USED,
                     fc.ktstfcfno RELATIVE_FNO
              from  sys.ts$ ts, sys.x$ktstfc fc
              where ts.contents$ = 1 and ts.bitmapped <> 0 and
                    ts.online$ = 1 and ts.ts# = fc.ktstfctsn and
                    fc.inst_id=userenv('Instance'))t2
      where t1.id=t2.file_id
          union
      Select a1.FILE_ID            Id,
             a1.TABLESPACE_NAME    TableSpace,
             a1.BYTES              Bytes_Total,
             a1.BYTES              Bytes_Livres,
             a1.BYTES              Max_Bytes,
             0                     Min_Bytes,
             1                     Fragmentos
        from dba_temp_files a1
        where a1.file_id not in (select distinct file_id from V$TEMP_EXTENT_POOL)
     ) F,
     dba_tablespaces T
where tablespace = tablespace_name
group by tablespace,substr(contents,1,1)||substr(EXTENT_MANAGEMENT,1,1)||substr(ALLOCATION_TYPE,1,1)
order by tablespace
/
