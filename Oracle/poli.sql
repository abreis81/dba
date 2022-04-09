SELECT COD_USU,   decode(PRI.PRIVILEGIADO,'S','SIM') "PRIVILEGIADO",
       SER.DESC_SERV ||' ('||PRI.SERVICO||')' "SERVICO", 
       decode(PRI.LEITURA,'S','Leitura')||
       decode(PRI.ATUALIZACAO,'S',',Atualização')||
       decode(PRI.EXCLUSAO,'S',',Exclusão') "ACESSO"
 FROM own_poli.SE_PRIVILEGIO PRI,
           own_poli.SE_SERVICO SER
WHERE COD_USU = 'F02292'  -- INFORME AQUI O COD_USU (LOGIN), DA CONSULTA
AND PRI.SERVICO = SER.SERVICO
ORDER BY SERVICO
/


SELECT *
 FROM own_poli.SE_PRIVILEGIO
 WHERE COD_USU = 'F02292'
 
select *
from own_poli.se_usuario
WHERE COD_USU = 'F02292'
 
UPDATE own_poli.se_usuario SET
senha='Mšg½^vì'
,dt_expira=null
,bloqueada='N'
WHERE COD_USU = 'F02292' 

SELECT *
 FROM  own_poli.SE_SERVICO SER
 WHERE COD_USU = 'F02292'
