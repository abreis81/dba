alter session set sort_area_size=102400000;
select 'alter index '||owner||'.'||index_name||' rebuild ONLINE;' from dba_indexes where status<>'VALID';