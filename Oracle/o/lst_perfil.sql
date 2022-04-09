/*
  script:   lst_perfil.sql
  objetivo: perfil mais utilizado
  autor:    Josivan
  data:     

*/

  select profile
        ,count(profile) "Nro Usuarios"
    from dba_users
group by profile
  having count(profile) = (select max(count(profile))
                             from dba_users
                         group by profile)
/




