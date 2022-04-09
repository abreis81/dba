--
-- outra opcao é consultar a view dba_tables 
--
select avg(nvl(vsize(cod_vendedor),0)) +
       avg(nvl(vsize(nom_vendedor),0)) +
       avg(nvl(vsize(divisao),0)) " AVG of ROW "
  from sales.bdvend
/
