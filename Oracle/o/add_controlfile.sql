/*

  add_controlfile.sql
  josivan

*/

Eh possivel ter ate 8 controlfile na base de dados especificados no parametro CONTROL_FILES.
Se for necessario adicionar ou alterar a localizacao de um controlfile faca:
1-desative o banco
2-copie o arquivo de controle atual usando comandos do sistema operacional
3-adicione os novos nomes ou alterações no parametro CONTROL_FILES do init.ora
4-inicialize a base de dados

os parametros abaixo podem ser alterados na recriacao do controlfile
MAXLOGFILES
MAXLOGMEMBERS
MAXLOGHISTORY
MAXDATAFILES
MAXINSTANCES

visoes importantes:

V$CONTROLFILE ( localizacao e nomes dos controlfiles )
V$CONTROLFILE_RECORD_SECTION ( informacoes sobre diferentes seções do controlfile )

-----------------------------------------------------------------------------------------------

ALTER SYSTEM BACKUP CONTROLFILE TO TRACE;
ALTER SYSTEM BACKUP CONTROLFILE TO '/usr.....'


-----------------------------------------------------------------------------------------------

1-shutar a base em modo NORMAL
  SHUTDOWN NORMAL

2-iniciar em modo MOUNT
  STARTUP MOUNT

3-recriar o controlfile
  @recria_controlfile.sql

4-abriar a base
  ALTER DATABASE OPEN

5-shutar normal e levantar novamente


-----------------------------------------------------------------------------------------------

exemplo das seçoes do controlfiles:


TYPE              RECORD_SIZE RECORDS_TOTAL RECORDS_USED FIRST_INDEX LAST_INDEX LAST_RECID
----------------- ----------- ------------- ------------ ----------- ---------- ----------
DATABASE                  192             1            1           0          0          0
CKPT PROGRESS            4084             1            0           0          0          0
REDO THREAD               104             1            1           0          0          0
REDO LOG                   72            60           30           0          0         92
DATAFILE                  180           300          118           0          0        351
FILENAME                  524           421          122           0          0          0
TABLESPACE                 68           300           64           0          0        100
RESERVED1                   1             1            0           0          0          0
RESERVED2                   1             1            0           0          0          0
LOG HISTORY                36          2722         2722         680        679      32661
OFFLINE RANGE              56           437           11           1         11         11
ARCHIVED LOG              584          1230         1230         320        319      30665
BACKUP SET                 40           408            0           0          0          0
BACKUP PIECE              736           610            0           0          0          0
BACKUP DATAFILE           116           633            0           0          0          0
BACKUP REDOLOG             76           214            0           0          0          0
DATAFILE COPY             660           606          336           1        336        336
BACKUP CORRUPTION          44           371            0           0          0          0
COPY CORRUPTION            40           408            0           0          0          0
DELETED OBJECT             20           408          335           1        335        335
RESERVED3                   1          8168            0           0          0          0
RESERVED4                   1          8168            0           0          0          0
