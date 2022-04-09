create or replace trigger trg_tab_consultores
before update on tab_consultores for each row
declare

cursor c_objeto is
  select column_name
        ,data_type
        ,column_id
    from all_tab_columns
   where table_name='TAB_CONSULTORES'
order by 3;

v_coluna_alterada  varchar2(1000);
v_tipo             varchar2(1);
source_cursor      integer;
destination_cursor integer;
ignore             integer;

begin

  v_coluna_alterada := '';
  
  for rc_objeto in c_objeto loop

      source_cursor := dbms_sql.open_cursor;
      dbms_sql.parse( source_cursor
                     ,'select decode( :new.'||rc_objeto.column_name||','||
                                      ':old.'||rc_objeto.column_name||',1'||',2) into v_tipo;'
                     ,dbms_sql.native );

      v_tipo := 'N';
      ignore := dbms_sql.execute(source_cursor);
      dbms_sql.close_cursor(source_cursor);

      v_coluna_alterada := v_coluna_alterada||''||v_tipo;
      
  end loop;

  if DBMS_REPUTIL.FROM_REMOTE = FALSE then
     :NEW.ULT_ATUALIZ        := SYSDATE;
     :NEW.ST_COLUNA_ALTERADA := v_coluna_alterada;
  end if;

end;
/
show errors
