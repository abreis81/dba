set doc off

CREATE OR REPLACE VIEW "ORDER_OBJECT_BY_DEPENDENCY"
AS
select max(level) DLEVEL, object_id from public_dependency
connect by object_id = prior referenced_object_id
group by object_id
/

--GRANT SELECT ON ORDER_OBJECT_BY_DEPENDENCY TO PUBLIC;
--CREATE PUBLIC SYNONYM ORDER_OBJECT_BY_DEPENDENCY FOR SYS.ORDER_OBJECT_BY_DEPENDENCY;



--accept n prompt "Nome do objeto ou (Enter)=Todos.................: "
--accept se prompt "Mostra erro da compilacao (S)=Sim ou (Enter)=Nao: "
--accept p prompt "Proprietario do objeto, (Enter)=Todos...........: "
--accept t prompt "Tipo do objeto para compilar, (Enter)=Todos.....: "
def n=''
def se=''
def p=''
def t=''
set ver off pause off feed off head off lines 200
col a format a80
col x noprint
set term on pause off
set trim on trims on
spool compilar.sql
select 'set pause off' from dual;
select 'spool compilar.lst' from dual;
select /*+ rule */ 
  'alter '||decode(object_type,'PACKAGE BODY','PACKAGE',object_type)||
  ' '||owner||'."'||object_name||'" compile'||
  decode(object_type,'PACKAGE',' PACKAGE','PACKAGE BODY',' BODY')||';'||chr(10) a
 ,decode(upper('&se'),'S','show errors '||object_type||' '||owner||'.'||object_name)
from order_object_by_dependency p, dba_objects a
where a.status = 'INVALID'
and   a.object_type in ('VIEW','FUNCTION','PROCEDURE','PACKAGE','PACKAGE BODY','TRIGGER')
and a.object_name like nvl(upper('&n'),'%')
and p.object_id = a.object_id
and a.owner like nvl(upper('&p'),'%')
and a.owner not in ('SYS','LIXO')
and a.object_type like nvl(upper('&t'),'%')
order by dlevel desc
/
select 'spool off' from dual;
spool off
prompt
select 'Execute "compilar.sql"' from dual;

drop view ORDER_OBJECT_BY_DEPENDENCY;

@compilar.sql
