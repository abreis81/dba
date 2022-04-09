Clear Columns Computes Breaks
Set pagesize 120
Set linesize 132
Set verify off
Column file_id heading "File|Id"
col owner format a10
col object format a30
Undefine ID_FILE

SELECT
      'free space' owner,     /* Nome do "owner" */
      '     ' object,         /* Nome do segmento */
      file_id,                /* Codigo do 'datafile' para o 'extent' */
      block_id,               /* ID inicial do block  para o 'extent' */
      blocks                  /* Tamanho do extent, em  blocos */
FROM dba_free_space
WHERE file_id = &&ID_FILE
UNION
SELECT
      substr(owner,1,10),
      substr(segment_name,1,32),
      file_id,
      block_id,
      blocks
FROM dba_extents
WHERE file_id = &&ID_FILE
ORDER BY 3,4
/
