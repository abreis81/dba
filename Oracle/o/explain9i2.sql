REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off
set pages 1000
set lines 300

Delete from plan_table;
commit;

col operation   format A500
col options     format A15
col object_name format A25
col PARTITION_START format A25
col PARTITION_STOP format A25
set echo on
explain plan for
select  a1_curso CURSO, z1_descri DESCRICAO, 
       case a1_semestr 
         when '2' then lpad(to_char(to_number(a1_serie)-1),2,'0')
         else trim(a1_serie)
       end SERIE,
       case a1_unidade
          when '09' then 'Memorial'
          when '11' then 'Vila Maria'
          when '04' then 'Vergueiro'
          when '01' then 'Mooca'
          when '02' then 'Lapa'
          else 'Outros' end CAMPUS, 
       case substr(a1_turma,2,1)
          when '1' then 'Manhã'
          when '2' then 'Tarde'
          when '3' then 'Noite'
          else 'Outros' end TURNO, count(*) QTDE,
       sum(case when e1_baixa <> ' ' then 1 else 0 end) PAGOS,
       sum(case when e1_baixa = ' ' then 1 else 0 end) NPAGOS,
       round((sum(case when e1_baixa = ' ' then 1 else 0 end)/count(*))*100,2) TAXA
  from siga.sa1010 a, siga.se1010 b, siga.sz1010 c
 where a1_filial=' '
   and a1_ano='2007'
   and a1_semestr in ('1', '2')
   and a1_naturez in ('M', 'Dep')
   and a.d_e_l_e_t_<>'*'
   and e1_filial=' '
   and e1_prefixo='MES'
--   and a1_unidade in ('01','02','04','09','11')
   and e1_vencrea between '20070201' and '20070630'
   and substr(e1_numra,1,1) in ('3', '4', '9')
   and b.d_e_l_e_t_<>'*'
   and a1_numra = e1_numra
   and z1_filial=' '
   and z1_cod = a1_curso
   and c.d_e_l_e_t_<>'*'
--   and a1_numra NOT IN ( SELECT A1_NUMRA FROM paulo_rw.dados_inad_valida WHERE serie = '00' )
--   and trim(a1_numra) NOT IN ( select RA from TMP_ALUNOS_ABRIL_200701 )
group by a1_curso, z1_descri, case a1_semestr when '2' then lpad(to_char(to_number(a1_serie)-1),2,'0') else trim(a1_serie) end , a1_unidade, substr(a1_turma,2,1)
order by a1_unidade, a1_curso, z1_descri, case a1_semestr when '2' then lpad(to_char(to_number(a1_serie)-1),2,'0') else trim(a1_serie) end, substr(a1_turma,2,1)
/

set echo off 
spool explain.lis
select * from table(dbms_xplan.display('PLAN_TABLE',null,'ALL'));
spool off








