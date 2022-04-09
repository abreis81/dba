--
-- Query1: Query para mostrar a fragmentação de uma tablespace
--
Define Nome_da_Tablespace=RBS

Clear Columns
Column xxx new_value bloco noprint

select value xxx 
  from v$parameter 
 where name = 'db_block_size'
/

Clear Computes
Clear Breaks
set pagesize 1000

compute sum of bytes on report
break on report

col tablespace_name     format a17
Col Bytes               format '999,999,999,999'

  select Tablespace_name         /* Nome da Tablespace */
        ,bytes                   /* Tamanho do fragmento em Bytes */
        ,(bytes/&&bloco) blocos  /* Tamanho do fragmento em Blocos */
        ,file_id                 /* Número de identificação do datafile */
    from dba_free_space
   where Tablespace_name = Upper('&Nome_da_Tablespace')
order by 1,2,4
/



Undefine Nome_da_Tablespace

-- QUERY 2
-- Query para computar os totais de espaços disponível e usado por
-- datafiles por tablespace

Clear Columns
Clear Computes
Clear Breaks
col DataFile            format a30
col Id                  format '999'
Col TableSpace          format a30
Col Bytes_Total         format '9999,999,999'
Col Bytes_Livres        format '9999,999,999'
Col Max_Bytes           format '9999,999,999'
Col Min_Bytes           format '9999,999,999'
col File_name           format a75
Col Frag                format '9999'
set linesize 300
set pagesize 300

  select substr(a1.FILE_NAME,(instr(a1.file_name,'bpcs/',5,1)+5),17) DataFile,  /* Nome do Datafile */
         a1.FILE_ID                      Id,            /* Número de identificação do datafile */
         a1.TABLESPACE_NAME              TableSpace,    /* Nome da Tablespace */
         a1.BYTES                        Bytes_Total,   /* Tamanho total do Datafile */
         sum(a2.bytes)                   Bytes_Livres,  /* Espaço Total livre do Datafile */
         max(a2.bytes)                   Max_Bytes,     /* Maior segmento contíguo no Datafile */
         min(a2.bytes)                   Min_Bytes,     /* Menor segmento contíguo no Datafile */
         count(*)                        Frag,          /* Quantidade de fragmentos do Datafile */
         a1.STATUS,
         a1.File_Name                                   /* Path completo do Datafile */
    from dba_data_files a1
        ,dba_free_space a2
   where a1.file_id = a2.file_id
group by a1.file_id
     ,a1.tablespace_name
     ,a1.bytes
     ,a1.status
     ,a1.file_name
union
  select substr(a1.FILE_NAME,(instr(a1.file_name,'bpcs/',5,1)+5),17) DataFile,
         a1.FILE_ID                      Id,
         a1.TABLESPACE_NAME              TableSpace,
         a1.BYTES                        Bytes_Total,
         0                               Bytes_Livres,
         0                               Max_Bytes,
         0                               Min_Bytes,
         0                               Frag,
         a1.STATUS,
         a1.File_Name
    from dba_data_files a1
   where a1.file_id not in (select distinct file_id from dba_free_space)
order by 3,1
/

-- QUERY 3
-- Query para computar os totais de espaços disponível e usado
-- por Tablespace. Necessário existir a VIEW "vw_space_in_tablespaces"
-- que é baseada na QUERY 2.

Clear Columns
Clear Computes
Clear Breaks
Col Tablespace          format a11
Col DFile               format '99'
Col Bytes_Total         format '99,999,999,999'
Col Bytes_Livres        format '99,999,999,999'
Col Max_Bytes           format '99,999,999,999'
Col Min_Bytes           format '99,999,999,999'
Col Fragtos             format '9,999'
set linesize 200
set pagesize 60
compute sum of Bytes_Total      on report
compute sum of Bytes_Livres     on report
compute sum of Fragtos          on report
break on report
  select TABLESPACE,                             /* Nome da Tablespace */
         count(*)                DFile,          /* Numero de Datafiles da Tablespace */
         sum(BYTES_TOTAL)        Bytes_total,    /* Tamanho total do Tablespace */
         sum(BYTES_LIVRES)       Bytes_livres,   /* Espaço Total livre do Tablespace */
         max(max_bytes)          Max_bytes,      /* Maior segmento contíguo no Tablespace */
         min(to_number(decode(min_bytes,0,null,
         min_bytes)))            Min_bytes,      /* Menor segmento contíguo no Tablespace */
         sum(Fragmentos)         Fragtos         /* Quantidade de fragmentos do Tablespace */
    from vw_space_in_tablespaces
group by tablespace
order by tablespace
/

-- QUERY 4
-- Query para identificar todos os extents de um segmento
-- (Tabela/Índice), ordem e tamanho de criação.

Clear Columns
Clear Computes
Clear Breaks
col owner               format a10
col segment_name        format a35
set pagesize 65
  SELECT substr(owner,1,20)        owner,  /* Owner do Segmento (Tabela/Índice) */
         substr(segment_name,1,32) segment_name,   /* Nome do Segmento */
         EXTENT_ID,        /* Sequencia de identificação do extent */
         file_id,          /* Código de Identificação do arquivo */
         blocks,           /* Tamanho do Extent */
         block_id          /* Identificação do extent dentro da Tablespace */
    FROM dba_extents
   WHERE tablespace_name = upper('&&Nome_da_Tablespace') and
         segment_name like upper('%&Nome_Segto%')
ORDER BY 2,3,4,5
/

-- QUERY 5
-- Query para averiguar os 'NEXT_EXTENTS' dos segmentos por tablespaces
-- que podem vir a estourar o espaço disponível de uma tablespace.
-- (Fórmula baseada na média dos tamanhos máximos contíguo por datafile por tablespace)

Clear Columns
Column xxx new_value bloco noprint
Select value xxx from v$parameter where name = 'db_block_size'
/
col owner               format a10
col segment_name        format a35
col tablespace_name     format a17
Col Blocos              format '999999'
select  a.tablespace_name,
        a.owner,
        a.segment_name,
        a.next_extent,
        (a.next_extent/&&bloco) blocos
from    dba_segments a
where   a.next_extent > (select avg(max_bytes) from vw_space_in_tablespaces d
                        where d.tablespace = a.tablespace_name)
order by a.tablespace_name,a.owner,a.segment_name
/
col owner               format a10
col segment_name        format a35
col tablespace_name     format a17
Col Blocos              format '999999'
select  a.tablespace_name,
        a.owner,
        a.segment_name,
        a.next_extent,
        (a.next_extent/&&bloco) blocos
from    dba_segments a
where   a.next_extent > (select avg(next_extent) from dba_segments c
                        where next_extent > 1500000 and
                        c.tablespace_name = a.tablespace_name)
order by a.tablespace_name,a.owner,a.segment_name
/
Undefine Nome_da_Tablespace

-- QUERY 6
-- Query para mapear os blocos usados e livres (extents) nos datafiles
-- de qualquer tablespace por File_id, Block_id

Clear Columns Computes Breaks
Set pagesize 120
Set linesize 132
Set verify off
Column file_id heading "File|Id"
Undefine Nome_da_Tablespace

SELECT
      'free space' owner,     /* Nome do "owner" */
      '     ' object,         /* Nome do segmento */
      file_id,                /* Codigo do 'datafile' para o 'extent' */
      block_id,               /* ID inicial do block  para o 'extent' */
      blocks                  /* Tamanho do extent, em  blocos */
FROM dba_free_space
WHERE tablespace_name = upper('&&Nome_da_Tablespace')
UNION
SELECT
      substr(owner,1,10),
      substr(segment_name,1,32),
      file_id,
      block_id,
      blocks
FROM dba_extents
WHERE tablespace_name = upper('&&Nome_da_Tablespace')
ORDER BY 3,4

-- spool &arquivo
/
-- spool off
Undefine Nome_da_Tablespace

-- QUERY 7
--
--

select  owner,
        tablespace_name,
        count(*)||'     tables' objects
from    dba_tables
group by owner, tablespace_name
union
select  owner,
        tablespace_name,
        count(*)||'     indexes' objects
from    dba_indexes
group by owner, tablespace_name
/

