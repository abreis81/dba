/*
  script:   lst_conexao.sql
  objetivo: usuarios que podem fazer mais de uma conexao
  autor:    Josivan
  data:     

*/

select u.username
  from dba_users u
      ,dba_profiles p
 where u.profile = p.profile
   and lower(p.resource_name) = 'sessions_per_user'
   and p.limit not in ('1','UNLIMITED')
/


