/*

   Backup do CONTROLFILE   ( Binario e Texto )

   Este ficheiro deve ser guardado sempre que:

   - ocorrer alteracao na configuracao fisica
   - reconstrucao do controlfile
   - backups a quente

*/


-- copia binaria, fiel
alter database backup controlfile to '/appsdes/oracle/oradata/oratst/controlf01.ora' reuse;


-- copia texto
-- este comando gera um script com recriacao do controlfile, o arquivo e gravado
-- no destino do parametro BACKGROUND_DUMP_DEST
-- Este so pode ser utilizado na recuperacao da base de dados se for desde o inicio
-- pois o mesmo nao guarda informacoes como o LSN ( log sequence number ), SCN ( sequence change number )
-- e outros
--
alter database backup controlfile to trace resetlogs

