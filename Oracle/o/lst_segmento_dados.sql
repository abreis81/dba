/*
  script:   lst_ocupacao.sql
  objetivo: listar o espaco ocupado e livre de todos os objetos
  autor:    Josivan
  data:     
*/

set serveroutput on size 1000000

declare
  var1 number;
  var2 number;
  var3 number;
  var4 number;
  var5 number;
  var6 number;
  var7 number;

cursor c1 is
  select distinct
         a.owner
        ,a.segment_name
        ,a.segment_type
        ,a.next_extent
        ,a.tablespace_name
        ,a.extents
        ,a.max_extents
        ,c.bytes
    from dba_segments a
        ,sys.sm$ts_free c
   where a.segment_type = 'TABLE'                 
     and a.owner not in ('SYSTEM','SYS','DBSNMP') 
     and a.tablespace_name = c.tablespace_name(+);

begin

  spool lst_ocupacao

  for x in c1 loop

      dbms_space.unused_space( x.owner
                              ,x.segment_name
                              ,'TABLE'
                              ,var1
                              ,var2
                              ,var3
                              ,var4
                              ,var5
                              ,var6
                              ,var7 );

      dbms_output.put_line('Espacos Utilizados da tabela');
      dbms_output.put_line('----------------------------');
      dbms_output.put_line('Owner / Tabela             = '||x.owner||'/'||x.segment_name);
      dbms_output.put_line('Total de blocos reservados = '||var1);
      dbms_output.put_line('Tamanho da tabela em bytes = '||to_char(var2,'999,999,999,999'));
      dbms_output.put_line('Qtde. de blocos nao usados = '||var3);
      dbms_output.put_line('Total em bytes nao usados  = '||to_char(var4,'999,999,999'));
      dbms_output.put_line('Qtde. de extents           = '||x.extents||'/'||x.max_extents);
      dbms_output.put_line('Valor do proximo extent    = '||to_char(x.next_extent,'999,999,999')); 
      dbms_output.put_line('Espaco livre na tablespace = '||x.tablespace_name||' '||to_char(x.bytes,'999,999,999,999'));
      dbms_output.put_line('============================');

  end loop;



end;

Spool off
/

