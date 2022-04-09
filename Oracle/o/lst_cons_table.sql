/*
  script:   lst_cons_table.sql
  objetivo: Relatorio diario
  autor:    Josivan
  data:     
*/
--
set feedback off
set pages 54
set pause off
set verify off
--
column constraint_name format a15 heading 'CONSTRAINT_NAME'
column table_name      format a25 heading 'TABELA'
column column_name     format a25 heading 'PRIMARY_KEY'
column position        format 99  heading 'POS'
column status          format a2  heading 'ST'
--
ttitle center 'Relacao de detalhes da tabela &&Tabela' skip 1 -
       center ========================================  
--
set heading off
--
spool cit.txt
--
select to_char(sysdate,'YYYY-MON-DD HH24:MI:SS') from dual;
--
set heading on
--
ttitle center 'Primary Key' skip 1 -
       left '================================================================================' skip 1
--
  select a.constraint_name
        ,a.table_name 
        ,a.column_name
        ,a.position
        ,substr(b.status,1,2)
    from sys.dba_cons_columns a
        ,sys.dba_constraints b
   where a.constraint_name = b.constraint_name
     and b.constraint_type = 'P' 
     and a.table_name      = upper('&&Tabela')
order by position
/

column constraint_name format a15 heading 'CONSTRAINT_NAME'
column table_name      format a25 heading 'TABELA'
column column_name     format a25 heading 'UNIQUE_KEY'
column position        format 99  heading 'POS'
column status          format a2  heading 'ST'
--
ttitle center 'Unique Keys' skip 1 -
       left '================================================================================' skip 1
--
break on constraint_name 
--
  select a.constraint_name
        ,a.table_name 
        ,a.column_name
        ,a.position
        ,substr(b.status,1,2)
    from sys.dba_cons_columns a
        ,sys.dba_constraints b
   where a.constraint_name = b.constraint_name
     and b.constraint_type = 'U'
     and a.table_name      = upper('&&Tabela')
order by position
/

column TABELA_FOREIGN format a36
column PRIMARY_KEY    format a36
--
ttitle center 'Relacao dos References' skip 1 -
       left '================================================================================' skip 1
--
break on a.table_name 
--
column constraint_name format a15 heading CONSTRAINT
column table_name      format a30 heading TABELA
column column_name     format a20 heading COLUNA
--
break on a.table_name 
--
column r_constraint_name format a15 heading rconstraint
--
select a.table_name
      ,b.column_name
      ,a.constraint_name
      ,substr(a.status,1,1) st
  from sys.dba_constraints a
      ,sys.dba_cons_columns b
 where a.constraint_name = b.constraint_name
   and a.r_constraint_name in (select constraint_name
                                 from sys.dba_cons_columns
                                where table_name = upper('&&Tabela'))
/

ttitle center 'Relacao das Foreign keys' skip 1 -
       left '================================================================================' skip 1
--
column lrc         format a13 heading 'LOC->REM CONSTRAINT'
column primary     format a42 heading 'TABELA(COLUNA) REFERENCIADA'
column column_name format a17 heading COLUNA 
--
select a.constraint_name||'->'||r_constraint_name lrc
      ,b.column_name
      ,c.table_name||'('||c.column_name||')' primary
      ,substr(a.status,1,1) s
  from sys.dba_constraints a
      ,sys.dba_cons_columns b
      ,sys.dba_cons_columns c
 where a.constraint_name   = b.constraint_name
   and a.r_constraint_name = c.constraint_name
   and a.constraint_type   = 'R'
   and a.table_name        = upper('&Tabela')
/


column index_name      format a21 heading 'INDEX_NAME'
column table_name      format a25 heading 'TABELA'
column column_name     format a25 heading 'COLUNA'
column column_position format  99 heading 'POS'
column uniqueness      format  a1 heading 'U'
--
ttitle center 'Relacao dos indices' skip 1 -
       left '================================================================================' 
--
break on index_name on table_name            
--
  select a.index_name
        ,a.table_name
        ,a.column_name
        ,a.column_position
        ,substr(b.uniqueness,1,1)
    from sys.dba_ind_columns a
        ,sys.dba_indexes b
   where a.table_name = upper('&&Tabela')
     and b.index_name = a.index_name
order by index_name
        ,column_position
/

spool off
undefine Tabela
clear breaks
set feedback on
set verify on
set heading on
set pages 24
ttitle off
btitle off
