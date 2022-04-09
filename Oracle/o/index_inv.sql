alter session set sort_area_size=102400000;
select 'alter index '||index_name||' rebuild ONLINE;' from user_indexes where status<>'VALID';