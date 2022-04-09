REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;

col operation   format A40
col options     format A15
col object_name format A25
set echo on
explain plan for
select count(*)
select count(git_cod_item) from aa3citem a where exists
(select 'x' from aa2cestq b where b.get_cod_produto=a.git_cod_item||a.git_digito)
/
set echo off 
spool explain.lis
Select   lpad( ' ', 2*( level - 1 ) )||operation||'  '||
         decode(id, 0, 'Cost = '||position ) "OPERATION",
         options,
         object_name,
	 OPTIMIZER
  from   plan_table
 start with  id = 0
 connect by prior id = parent_id;
spool off

