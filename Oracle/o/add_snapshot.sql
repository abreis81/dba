--
-- criar snapshot
-- a opcao FAST so e permitida se for criado no servidor remoto um SNAPSHOT LOG e se o
-- select nao for complexo com funcoes de grupo
-- o default e FORCE e PRIMARY KEY
--
create snapshot snp_clientes
refresh fast / complete / force
        start with to_date('2000.03.31','yyyy.mm.dd')
         next to_date('2000.03.31','yyyy.mm.dd) + 7
         with rowid / primary key
as select * from db_link@clientes

--
--opcoes:
-- FORCE e FAST:   exigem um snapshot log na base remota
-- COMPLETE: cria/recria o snapshot 
-- rowid / primary key : forma de controle na actualizacao

--Ex.
create snapshot snp_clientes
as select * from db_link@clientes
-- no banco remoto
create snapshot log on clientes
with rowid;

--
-- este snapshot eh para ser criado na servidor remoto e tem por finalidade
-- controlar de tempos em tempos as transacoes enviadas
--
create snapshot log on transacao_eletronica_financ
pctfree 10
tablespace ts_rec_dados01;

create snapshot log on pto_venda_tef
pctfree 10
tablespace ts_rec_dados01;

create snapshot log on pto_venda_tef_aerop
pctfree 10
tablespace ts_rec_dados01;
