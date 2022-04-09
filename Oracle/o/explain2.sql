REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;


set pages 1000
set lines 200
col operation   format A60
col options     format A15
col object_name format A25
col OPTIMIZER format a20
set echo on
explain plan for
select A.UNIDADE,
       A.COD_CURSO,
       A.CURSO,
       A.TURNO,
       A.N_TURMAS,
       B.TOTAL_PAGOS,
       C.TOTAL_NPAGOS
  from (select es."nome" UNIDADE,
               al."cr_codigo" COD_CURSO,
               cr."nome" CURSO,
               case substr(al."turma", 2, 1)
                 when '1' then
                  'MANHÃ'
                 when '2' then
                  'TARDE'
                 when '3' then
                  'NOITE'
               end TURNO,
               count(al."turma") N_TURMAS,
               '' TOTAL_PAGOS,
               '' TOTAL_NPAGOS
          from "Aluno"@preseu_r  al,
               "Curso"@preseu_r  cr,
               "Escola"@preseu_r es
         where al."aass" in ('20072', '2007D')
           and al."sit" in ('M', 'Dep')
           and al."codigo" = '903101124'
           and al."cr_codigo" = cr."codigo"
           and al."es_codigo" = es."es_codigo"
         group by es."nome",
                  al."cr_codigo",
                  cr."nome",
                  substr(al."turma", 2, 1)) A,
       (select es."nome" UNIDADE,
               al."cr_codigo" COD_CURSO,
               cr."nome" CURSO,
               case substr(al."turma", 2, 1)
                 when '1' then
                  'MANHÃ'
                 when '2' then
                  'TARDE'
                 when '3' then
                  'NOITE'
               end TURNO,
               '' N_TURMAS,
               count(status_parcela) TOTAL_PAGOS,
               '' TOTAL_NPAGOS
          from "Aluno"@preseu_r al,
               "Curso"@preseu_r cr,
               "Escola"@preseu_r es,
               vcr_consulta_titulo
         where al."aass" in ('20072', '2007D')
           and al."sit" in ('M', 'Dep')
           and al."codigo" = '903101124'
           and al."cr_codigo" = cr."codigo"
           and al."es_codigo" = es."es_codigo"
           and al."codigo" = numra
           and id_empresa = 1
           and to_char(vencto, 'yyyymmdd') between '20070701' and '20071231'
           and status_parcela = 'P'
         group by es."nome",
                  al."cr_codigo",
                  cr."nome",
                  substr(al."turma", 2, 1)) B,
       (select es."nome" UNIDADE,
               al."cr_codigo" COD_CURSO,
               cr."nome" CURSO,
               case substr(al."turma", 2, 1)
                 when '1' then
                  'MANHÃ'
                 when '2' then
                  'TARDE'
                 when '3' then
                  'NOITE'
               end TURNO,
               '' N_TURMAS,
               '' TOTAL_PAGOS,
               count(status_parcela) TOTAL_NPAGOS
          from "Aluno"@preseu_r al,
               "Curso"@preseu_r cr,
               "Escola"@preseu_r es,
               vcr_consulta_titulo
         where al."aass" in ('20072', '2007D')
           and al."sit" in ('M', 'Dep')
           and al."codigo" = '903101124'
           and al."cr_codigo" = cr."codigo"
           and al."es_codigo" = es."es_codigo"
           and al."codigo" = numra
           and id_empresa = 1
           and to_char(vencto, 'yyyymmdd') between '20070701' and '20071231'
           and status_parcela <> 'P'
         group by es."nome",
                  al."cr_codigo",
                  cr."nome",
                  substr(al."turma", 2, 1)) C
 WHERE A.UNIDADE = B.UNIDADE
   AND A.COD_CURSO = B.COD_CURSO
   AND A.CURSO = B.CURSO
   AND A.TURNO = B.TURNO
   AND B.UNIDADE = C.UNIDADE
   AND B.COD_CURSO = C.COD_CURSO
   AND B.CURSO = C.CURSO
   AND B.TURNO = C.TURNO
 ORDER BY A.UNIDADE, A.CURSO, A.TURNO
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

                               