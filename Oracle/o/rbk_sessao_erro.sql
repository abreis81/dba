/*
  script:   rbk_sessao_erro.sql
  objetivo: explanacao sobre kill em sessoes e transacoes pendentes em V$TRANSACTION
  autor:    Josivan
  data:     
*/

obs: quando matamos uma sessao no oracle se a mesma tiver muitas transacoes pendentes o
RDBMS demorar� um tempo para fazer um rollback das transacoes pendentes. Enquanto existirem
transacoes pendentes ir� existir o usuario na v$session com mesmo ID e SERIAL# variante. Apos
as transacoes em V$TRANSACTION nos atributos USED_UBLK e USED_UREC nao zerarem o processo nao
se resolvera, ou seja, o processo estar� completo quando terminar o rollback.

considera�oes:

CLEANUP_ROLLBACK_ENTRIES = 20 ( default ) este parametro identifica o numero de transacoes que 
serao desfeitas por vez atraves do processo PMON. Um valor muito alto pode impactar em travamento
da instance visto que o RDBMS dar� prioridade total para a recuperacao.

SHUTDOWN ===> fazendo um shutdown na base de dados o mesmo for�a um CLEANUP mas rapido 
              das transacoes pendentes

KILL -9 pid ===> este comando eh recomendado quando existe a necessidade de matar sessoes que
esta realizando processamento muito pessado.


o select abaixo localiza os processos no sistema operacional:


  select r.name                 rollseg
        ,s.username             username
        ,s.sid
        ,s.serial#
        ,p.spid                 UNIX
        ,substr(s.machine,1,15) machine
    from v$transaction t
        ,v$rollname r
        ,v$process p
        ,v$session s
   where t.addr   = s.taddr
     and t.xidusn = r.usn
     and s.paddr  = p.addr
order by 1,2
/
