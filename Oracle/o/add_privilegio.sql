/*
  script:   add_privilegio.sql
  objetivo: conceder privilegios
  autor:    Josivan
  data:     

  bibliotecas:


                sistema  ( +- 83 ) ( grant create session, ... to USUARIO )
               /
              /
  privilegio /
             \
              \
               \objeto  ( grant select,insert,update,delete on OBJETO to USUARIO )

*/

--
-- privilegio de sistema
--
grant create session, create any table to josivan
with admin option
/

revoke create session, create any table from josivan
revoke all_privileges on trans_abast from josivan
/

--
-- privilegio de objeto
--
grant select,update,delete on galpdba.trans_abast to josivan
with grant option
/

revoke select,update,delete on galpdba.trans_abast from josivan
cascade constraints
/

