select 'F' || lpad(to_char(co.con_cdicontratado),
                   5,
                   '0') "GRANTEE"

       ,co.con_cdicontratado "MATRICULA"
       ,co.con_dssnome "NOME"
       ,ce.ccu_d1scentrocustores "AREA"  
       ,co.con_dtdrescisao
--,trunc(co.con_vlnsalario) S

  from own_apdat.contratados   co
      ,own_apdat.centroscustos ce
 where
 /*
  ce.ccu_d1scentrocustores not in ('ATD', 'ATI')
   and co.con_cdicontratado in
       (select to_number(substr(username,
                                2,
                                5))
          from dba_users
         where username like 'F0%'
           and account_status not like '%LOCK%')
   and 
   */
   co.con_cdicentrocusto = ce.ccu_cdicentrocusto
and co.con_dtdrescisao < sysdate
--and co.con_dtdrescisao is null
--and ce.ccu_d1scentrocustores  in ('ATD', 'ATI')
--and co.con_dtdrescisao is null
--to_char(co.con_dtdrescisao,'DDMMYYYY') = 0
--and ce.ccu_d1scentrocustores = 'Nenhum'
order by nome





--own_apdat.contratados   co
--      ,own_apdat.centroscustos ce
