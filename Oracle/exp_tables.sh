#VARIÁVEIS

#caminho do arquivo DUMP
PATH_DUMP=/oracle/dump/20071029

# SID da instância
ORACLE_SID=LODBP03

#nome do arquivo dump (este será compactado)
DUMP_NAME=exp_tab_XX_PRESTACOES_NV.dmp

# nome das tabelas a serem exportadas separadas por virgula
TABLE_NAME=rcvry.XX_PRESTACOES_NV

#nome do arquivo de log
LOG_NAME=exp_tab_XX_PRESTACOES_NV.log


#EXPORT

date
cd ${PATH_DUMP}
rm exp_nod
mkfifo exp_nod p
gzip < exp_nod > ${DUMP_NAME}.gz&
exp file=exp_nod tables=${TABLE_NAME} STATISTICS=none direct=y buffer=6553565 RECORDLENGTH=65535 feedback=100000 log=${LOG_NAME} <<- EOF
/ as sysdba
EOF
date
