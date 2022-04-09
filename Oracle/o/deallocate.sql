/*
  script:   deallocate.sql
  objetivo: desalocar extents nao necessarios ao segmento
  autor:    Josivan
  data:     
  obs:  executar o script dbmsutil.sql
*/

set serveroutput on

declare

  var1 number;
  var2 number;
  var3 number;
  var4 number;
  var5 number;
  var6 number;
  var7 number;

begin
 
  dbms_output.enable(102400);

  dbms_space.unused_space( 'GALPDBA'
                          ,'PK_INFOR_GESTA_TRANS'
                          ,'INDEX'
                          ,var1
                          ,var2
                          ,var3
                          ,var4
                          ,var5
                          ,var6
                          ,var7 );

  dbms_output.put_line('Espacos Utilizados de uma tabela');
  dbms_output.put_line('--------------------------------');
  dbms_output.put_line('TOTAL_BLOCKS              = '||var1);
  dbms_output.put_line('TOTAL_BYTES               = '||var2);
  dbms_output.put_line('UNUSED_BLOCKS             = '||var3);
  dbms_output.put_line('UNUSED_BYTES              = '||var4);
  dbms_output.put_line('LAST_USED_EXTENT_FILE_ID  = '||var5);
  dbms_output.put_line('LAST_USED_EXTENT_BLOCK_ID = '||var6);
  dbms_output.put_line('LAST_USED_BLOCK           = '||var7);

end;
/

--
-- o espaco desalocado e devolvido para a tablespace
-- sera apenas o espaco apos a marca HWM
--
alter table trans_abast
deallocate ts_dados unused keep 5m;

alter index idx_trans_abast_codigo
deallocate ts_index unused keep 2m;

alter cluser clu_infor_gesta
deallocate ts_dados unused keek 8m;

