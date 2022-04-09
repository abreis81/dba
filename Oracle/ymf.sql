/*
UPDATE OWN_YMF.SSY_USUARIOS U 
SET U.DT_BLOQUEIO = '',
    U.CD_BLOQUEIO = '', 
    U.SG_STATUS   = 'A',
--  u.senha = 'Ã¼Àº¢¥‰~{',
    U.DT_ULTIMO_ACESSO = SYSDATE, -- '22-DEC-2008' ,
    u.dt_atualizacao_senha=sysdate  -- para não solicitar troca de senha por expiração
WHERE NICK_NAME = 'F01191'
*/

select *
from OWN_YMF.SSY_USUARIOS
WHERE NICK_NAME like 'F01191%'

select *
from dba_users
where username like '%YMF%'

select *
from OWN_YMFBDG.SSY_USUARIOS u
where cod_usuario = 51;
