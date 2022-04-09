undef dbname
col dbname new_value dbname
select substr(global_name,1,instr(global_name,'.',1) -1 ) dbname from global_name;
set sqlp "&dbname> "
show user
undef dbname