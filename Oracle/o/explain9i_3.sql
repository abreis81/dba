REM  rodar o script UTLXPLAN.sql sob o schema SYS

Set echo off
Set verify off

Delete from plan_table;
commit;

col operation   format A40
col options     format A15
col object_name format A25
col PARTITION_START format A25
col PARTITION_STOP format A25
set echo on
explain plan for
 select gcc1.code_combination_id
        , gcc1.chart_of_accounts_id
        , fsfa.alias_name
        , fsfa.description
        , hr.organization_id
        , hr.name
        , gcc1.segment2
        , (DECODE(gcc1.CHART_OF_ACCOUNTS_ID, 101, gcc1.SEGMENT1 || '.' ||
                                                  gcc1.SEGMENT2 || '.' ||
                                                  gcc1.SEGMENT3 || '.' ||
                                                  gcc1.SEGMENT4 || '.' ||
                                                  gcc1.SEGMENT5 || '.' ||
                                                  gcc1.SEGMENT6 || '.' ||
                                                  gcc1.SEGMENT7, NULL))  concatenated_segments
        , (DECODE(gcc1.CHART_OF_ACCOUNTS_ID, 101, RPAD(NVL(gcc1.SEGMENT1, ' '), 5) || '.' ||
                                                  RPAD(NVL(gcc1.SEGMENT2, ' '), 5) || '.' ||
                                                  RPAD(NVL(gcc1.SEGMENT3, ' '), 8) || '.' ||
                                                  RPAD(NVL(gcc1.SEGMENT4, ' '), 4) || '.' ||
                                                  RPAD(NVL(gcc1.SEGMENT5, ' '), 5) || '.' ||
                                                  RPAD(NVL(gcc1.SEGMENT6, ' '), 5) || '.' ||
                                                  RPAD(NVL(gcc1.SEGMENT7, ' '), 4), NULL))  padded_concatenated_segments
        , gcc1.description
     from apps.gl_code_combinations                gcc1
        , apps.gl_code_combinations                gcc
        , hr.hr_all_organization_units             hr
        , inv.mtl_parameters                       mtl
        , ( select /*+ index (a FND_SHORTHAND_FLEX_ALIASES_U1) */ distinct concatenated_segments, alias_name, description
              from APPLSYS.fnd_shorthand_flex_aliases a
             where application_id          = 101
               And id_flex_code            = 'GL#'
               And id_flex_num             = 101 ) fsfa
    where FSFA.CONCATENATED_SEGMENTS like '%.%.' || GCC1.SEGMENT3 || '.'
                                                 || GCC1.SEGMENT4
                                                 || '.%.%.%'
      and sysdate                between nvl( gcc1.start_date_active, sysdate )
                                     and nvl( gcc1.end_date_active, sysdate )
      And nvl(gcc1.enabled_flag, 'Y') <> 'N'
      AND upper(GCC1.SEGMENT1)         = GCC.SEGMENT1
      AND upper(GCC1.SEGMENT6)         = GCC.SEGMENT6
      and gcc.code_combination_id      = mtl.material_account
      and nvl(hr.date_to, sysdate)    >= sysdate
      AND hr.organization_id           = mtl.organization_id
      and mtl.process_orgn_code       is null
      and mtl.organization_id         <> mtl.master_organization_id
      And mtl.process_enabled_flag || '' = 'N'
/

set echo off 
spool explain.lis
select * from table(dbms_xplan.display('PLAN_TABLE',null,'ALL'));
spool off

