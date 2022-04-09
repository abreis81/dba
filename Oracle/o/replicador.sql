set lines 200
set pages 1000
/*
SCRIPTS NAME : REPLICADOR.SQL
OBJECTIVE : SCRIPT PARA VERIFICAR REPLICACOES PARA LOJAS
AUTOR: DAVI CAMPOS
MODIFICATIONS: NORIVAL A. FILHO 
DATE CHANGE: 30/10/2003
VERSAO: 1.5 
*/

ACCEPT PRODUTO PROMPT ' DIGITE 201 - PEDIDOS, 202 - N.ATENDIDOS, 203 - DOBRA e  204 - FISCAL --> '

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RRRR HH24:MI:SS';
select s.rep_id            "Replicacao"
      ,sp.site_nm          "Publicador"
      ,ss.site_nm          "Assinante"
      ,p.prod_nm           "Produto"
      ,s.start_dt          "Inicio"
      ,s.finish_dt         "Fim"
      ,st.state_nm         "situacao"
      ,s.amt_rows          "Pedidos"
from  service        s
,site                sp
,site                ss
,product             p
,state               st
where trunc(s.start_dt) = trunc(sysdate) -- (sysdate -4) dia naterior
and s.pub_id                     =s.pub_id --Pedido: loja --> CD; Dobra e N.Atend.: CD --> loja
and sp.site_id                   =s.pub_id 
and s.sub_id                     =s.sub_id
and ss.site_id                   =s.sub_id
and s.prod_id                    in (&PRODUTO)   --- Pedido (201) N.Atendidos (202) Dobra (203) Fiscal(204)
and p.prod_id                    =s.prod_id
and s.amt_rows                   >0
and st.state_id                  =s.state_id
order by 1,2,3;
