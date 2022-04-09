/*

sort segments, sao segmentos temporarios criados somente em tablespace temporario

v$sort_usage   - informacao sobre os sort segments ativos
v$sort_segment - informacao sobre os sort segments que estao criados, so eh preenchido para segmentos temporarios criados em tablespace temporario

*/

na criacao de tablespace temporarios observar as:
1-o valor de initial deve ser igual ao valor do next
2-o valor pctincrease deve ser igual a zero
3-o tamanho dos extents ( initial e next ) deve ser um valor multiplo do 
  parametro SORT_AREA_SIZE, acrescido de um bloco ( DB_BLOCK_SIZE )


create tablespace temp
datafile '/db/oradata/ocpe/temp/t01tmp.dbf' size 20m
autoextend on next 10m maxsize 50m
default storage( initial x
                    next x
              minextents x
              maxextents x
             pctincrease 0 )
temporary;

ou

create temporary tablespace temp
datafile '/db/oradata/ocpe/temp/t01tmp.dbf' size 20m
autoextend on next 10m maxsize 50m
default storage( initial x
                    next x
              minextents x
              maxextents x
             pctincrease 0 );



create rollback segments rb01
tablespace temp
storage( initial x
            next x
       minextent x
      maxextents x
         optimal x );

alter rollback segment rb01 online;

