alter system archive log all
alter system switch logfile;                  ( forca a troca de grupo )
alter system flush shared_pool;               ( reseta a SGA )
alter system checkpoint;                      ( forcar um checkpoint eh gravar os conteudo de memoria nos datafiles )
alter database backup controlfile to trace;   ( copia ASCII do controlfile ou seja script de criacao )
alter session set optimizer_goal=rule/choose; ( metodo de trabalho da sessao )
alter session set sql_trace=true;             ( gerar um ficheiro de trace da sessao para analise )
alter rollbak segment rb01 shrink to 20m      ( liberta espaco utilizado desnecessariamente pelo segmento de rollback )
alter system set timed_statistics=true/false  ( habilitar o recolhimentos de dados estatisticos das visoes V$SYSSTAT, V$SESSTAT que fornecem informacoes sobre a DATABASE BUFFER CACHE
set autotrace on/off  ( liga/desliga a geracao do trace files )
alter session set sql_trace=true  ( recolher estatisticas da sessao, gerando um arquivo no diretorio USER_DUMP_DEST )
execute dbms_system.set_sql_trace_in_session(sid,serial#,true) ( recolher estatisticas da sessao )
alter system disconnect session 'sid,serial#' post_transaction; ( esperar a sessao terminar a transacao para desconecta-la da base )

