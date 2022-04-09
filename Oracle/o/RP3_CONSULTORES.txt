CREATE OR REPLACE package body TAB_CONSULTORES$RP as

  --
  -- chamada para exclusao
  --
  procedure rep_delete( "CD_CODIGO1_o"    IN NUMBER,
                        "NM_NOME2_o"      IN VARCHAR2,
                        "NM_SOBRENOME3_o" IN VARCHAR2,
                        "ULT_ATUALIZ4_o"  IN DATE,
                        "VLR_SAL5_o"      IN NUMBER,
                        "VLR_UNIT6_o"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR ) is
  begin

    rep_delete( NULL,
               "CD_CODIGO1_o",
               "NM_NOME2_o",
               "NM_SOBRENOME3_o",
               "ULT_ATUALIZ4_o",
               "VLR_SAL5_o",
               "VLR_UNIT6_o",
               site_name,
               propagation_flag);

  end rep_delete;



  --
  -- exclusao replicada
  --
  procedure rep_delete( column_changed$   IN RAW,
                        "CD_CODIGO1_o"    IN NUMBER,
                        "NM_NOME2_o"      IN VARCHAR2,
                        "NM_SOBRENOME3_o" IN VARCHAR2,
                        "ULT_ATUALIZ4_o"  IN DATE,
                        "VLR_SAL5_o"      IN NUMBER,
                        "VLR_UNIT6_o"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR ) is

    column_sent$_varchar2 VARCHAR2(6);

  begin

    column_changed$$ := column_changed$;

    if column_changed$ is not null then
       dbms_reputil.raw_to_varchar2(column_changed$, 2, column_sent$_varchar2);
    end if;

    if propagation_flag = 'N' then
       dbms_reputil.replication_off;
    end if;

    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;

    delete from "TAB_CONSULTORES"
     where "CD_CODIGO1_o" = "CD_CODIGO";

    if sql%rowcount = 0 then

       raise no_data_found;

    elsif sql%rowcount > 1 then

       raise too_many_rows;

    end if;

    dbms_reputil.rep_end;

  exception
    when no_data_found then

      begin

        --
        -- conflito na exclusao
        --
        if not "TAB_CONSULTORES$RR".delete_conflict_handler( "CD_CODIGO1_o",
                                                             "NM_NOME2_o",
                                                             "NM_SOBRENOME3_o",
                                                             "ULT_ATUALIZ4_o",
                                                             "VLR_SAL5_o",
                                                             "VLR_UNIT6_o",
                                                             site_name,
                                                             propagation_flag,
                                                             column_changed$,
                                                             column_sent$_varchar2 ) then
          dbms_reputil.rep_end;
          raise;

        end if;

        dbms_reputil.rep_end;

      exception
        when others then
          dbms_reputil.rep_end;
          raise;

      end;

    when others then

      dbms_reputil.rep_end;
      raise;

  end rep_delete;




  --
  -- inclusao
  --
  procedure rep_insert( "CD_CODIGO1_n"    IN NUMBER,
                        "NM_NOME2_n"      IN VARCHAR2,
                        "NM_SOBRENOME3_n" IN VARCHAR2,
                        "ULT_ATUALIZ4_n"  IN DATE,
                        "VLR_SAL5_n"      IN NUMBER,
                        "VLR_UNIT6_n"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR ) is

  begin

    if propagation_flag = 'N' then
       dbms_reputil.replication_off;
    end if;

    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;

    insert into "TAB_CONSULTORES" ( "CD_CODIGO",
                                    "NM_NOME",
                                    "NM_SOBRENOME",
                                    "ULT_ATUALIZ",
                                    "VLR_SAL",
                                    "VLR_UNIT")
                           values ( "CD_CODIGO1_n",
                                    "NM_NOME2_n",
                                    "NM_SOBRENOME3_n",
                                    "ULT_ATUALIZ4_n",
                                    "VLR_SAL5_n",
                                    "VLR_UNIT6_n" );
    dbms_reputil.rep_end;

  exception
    when dup_val_on_index then

      begin

        --
        -- conflito na inclusao ( chave duplicada )
        --
        if not "TAB_CONSULTORES$RR".unique_conflict_insert_handler( "CD_CODIGO1_n",
                                                                    "NM_NOME2_n",
                                                                    "NM_SOBRENOME3_n",
                                                                    "ULT_ATUALIZ4_n",
                                                                    "VLR_SAL5_n",
                                                                    "VLR_UNIT6_n",
                                                                    site_name,
                                                                    propagation_flag,
                                                                    SQLERRM ) then

          dbms_reputil.rep_end;
          raise;

        end if;

        dbms_reputil.rep_end;

      exception
        when others then
          dbms_reputil.rep_end;
          raise;

      end;

    when others then

      dbms_reputil.rep_end;
      raise;

  end rep_insert;




  --
  -- chamada para update
  --
  procedure rep_update( "CD_CODIGO1_o"    IN NUMBER,
                        "CD_CODIGO1_n"    IN NUMBER,
                        "NM_NOME2_o"      IN VARCHAR2,
                        "NM_NOME2_n"      IN VARCHAR2,
                        "NM_SOBRENOME3_o" IN VARCHAR2,
                        "NM_SOBRENOME3_n" IN VARCHAR2,
                        "ULT_ATUALIZ4_o"  IN DATE,
                        "ULT_ATUALIZ4_n"  IN DATE,
                        "VLR_SAL5_o"      IN NUMBER,
                        "VLR_SAL5_n"      IN NUMBER,
                        "VLR_UNIT6_o"     IN NUMBER,
                        "VLR_UNIT6_n"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR ) is
  begin

    rep_update( NULL,
               "CD_CODIGO1_o",
               "CD_CODIGO1_n",
               "NM_NOME2_o",
               "NM_NOME2_n",
               "NM_SOBRENOME3_o",
               "NM_SOBRENOME3_n",
               "ULT_ATUALIZ4_o",
               "ULT_ATUALIZ4_n",
               "VLR_SAL5_o",
               "VLR_SAL5_n",
               "VLR_UNIT6_o",
               "VLR_UNIT6_n",
               site_name,
               propagation_flag );

  end rep_update;


  --
  -- update
  --
  procedure rep_update( column_changed$   IN RAW,
                        "CD_CODIGO1_o"    IN NUMBER,
                        "CD_CODIGO1_n"    IN NUMBER,
                        "NM_NOME2_o"      IN VARCHAR2,
                        "NM_NOME2_n"      IN VARCHAR2,
                        "NM_SOBRENOME3_o" IN VARCHAR2,
                        "NM_SOBRENOME3_n" IN VARCHAR2,
                        "ULT_ATUALIZ4_o"  IN DATE,
                        "ULT_ATUALIZ4_n"  IN DATE,
                        "VLR_SAL5_o"      IN NUMBER,
                        "VLR_SAL5_n"      IN NUMBER,
                        "VLR_UNIT6_o"     IN NUMBER,
                        "VLR_UNIT6_n"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR ) is

    column_changed$_varchar2  VARCHAR2(6);
    column_sent$_varchar2     VARCHAR2(6);
    registro_no_destino       boolean;
    registro_na_origem        boolean;
    transacao_valida          boolean;
    "ULT_ATUALIZ_x"           TAB_CONSULTORES.ULT_ATUALIZ%TYPE;
    "CD_CODIGO1_c"            TAB_CONSULTORES.CD_CODIGO%TYPE;
    "NM_NOME2_c"              TAB_CONSULTORES.NM_NOME%TYPE;
    "NM_SOBRENOME3_c"         TAB_CONSULTORES.NM_SOBRENOME%TYPE;
    "ULT_ATUALIZ4_c"          TAB_CONSULTORES.ULT_ATUALIZ%TYPE;
    "VLR_SAL5_c"              TAB_CONSULTORES.VLR_SAL%TYPE;
    "VLR_UNIT6_c"             TAB_CONSULTORES.VLR_UNIT%TYPE;

  begin

    --
    -- site origem
    --
    column_changed$$ := column_changed$;

    if column_changed$ is not null then
       dbms_reputil.raw_to_varchar2(column_changed$,1,column_changed$_varchar2);
       dbms_reputil.raw_to_varchar2(column_changed$,2,column_sent$_varchar2);
    end if;

    registro_na_origem := true;

    begin
      select "CD_CODIGO",
             "NM_NOME",
             "NM_SOBRENOME",
             "ULT_ATUALIZ",
             "VLR_SAL",
             "VLR_UNIT"
        into "CD_CODIGO1_c",
             "NM_NOME2_c",
             "NM_SOBRENOME3_c",
             "ULT_ATUALIZ4_c",
             "VLR_SAL5_c",
             "VLR_UNIT6_c"
        from "TAB_CONSULTORES"
       where "CD_CODIGO" = "CD_CODIGO1_o";
    exception
      when others then
        registro_na_origem := false;

    end;

    dbms_reputil2.set_column_changed(column_changed$_varchar2);

    if propagation_flag = 'N' then
       dbms_reputil.replication_off;
    end if;


    --
    -- site destino
    --
    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;
    registro_no_destino      := true;
    transacao_valida         := false;

    --
    -- dados no destino
    --
    begin
      select "ULT_ATUALIZ"
        into "ULT_ATUALIZ_x"
        from "TAB_CONSULTORES"
       where "CD_CODIGO" = "CD_CODIGO1_o";
    exception
      when others then
        registro_no_destino := false;
    end;

    --
    -- verifica a transacao com ultima alteracao
    --
    if TO_CHAR("ULT_ATUALIZ4_n",'DD/MM/YYYY HH24:MI:SS') > TO_CHAR("ULT_ATUALIZ_x",'DD/MM/YYYY HH24:MI:SS') then
       transacao_valida  := true;
    end if;

    --
    -- nao achou na origem devido a exclusao, e enfileiramento
    --
    if not registro_na_origem then

       registro_na_origem := true;

       begin
         select "CD_CODIGO",
                "NM_NOME",
                "NM_SOBRENOME",
                "ULT_ATUALIZ",
                "VLR_SAL",
                "VLR_UNIT"
           into "CD_CODIGO1_c",
                "NM_NOME2_c",
                "NM_SOBRENOME3_c",
                "ULT_ATUALIZ4_c",
                "VLR_SAL5_c",
                "VLR_UNIT6_c"
           from "TAB_CONSULTORES"
          where "CD_CODIGO" = "CD_CODIGO1_o";
       exception
         when others then
           registro_na_origem := false;

       end;

    end if;


    if registro_no_destino and registro_na_origem and transacao_valida then

       update "TAB_CONSULTORES"
          set "CD_CODIGO"    = decode(substr(column_changed$_varchar2, 1, 1),'N', "CD_CODIGO1_c"   , "CD_CODIGO1_n"   ),
              "NM_NOME"      = decode(substr(column_changed$_varchar2, 2, 1),'N', "NM_NOME2_c"     , "NM_NOME2_n"     ),
              "NM_SOBRENOME" = decode(substr(column_changed$_varchar2, 3, 1),'N', "NM_SOBRENOME3_c", "NM_SOBRENOME3_n"),
              "ULT_ATUALIZ"  = decode(substr(column_changed$_varchar2, 4, 1),'N', "ULT_ATUALIZ4_c" , "ULT_ATUALIZ4_n" ),
              "VLR_SAL"      = decode(substr(column_changed$_varchar2, 5, 1),'N', "VLR_SAL5_c"     , "VLR_SAL5_n"     ),
              "VLR_UNIT"     = decode(substr(column_changed$_varchar2, 6, 1),'N', "VLR_UNIT6_c"    , "VLR_UNIT6_n"    )
        where "CD_CODIGO1_o" = "CD_CODIGO";

        if sql%rowcount = 0 then

           raise no_data_found;

        elsif sql%rowcount > 1 then

           raise too_many_rows;

        end if;

    else

       dbms_reputil.rep_end;
      
       --
       -- sincronizacao
       --
       update "TAB_CONSULTORES"
          set "CD_CODIGO"    = decode(substr(column_changed$_varchar2, 1, 1),'N', "CD_CODIGO1_c"   , "CD_CODIGO1_c"   ),
              "NM_NOME"      = decode(substr(column_changed$_varchar2, 2, 1),'N', "NM_NOME2_c"     , "NM_NOME2_c"     ),
              "NM_SOBRENOME" = decode(substr(column_changed$_varchar2, 3, 1),'N', "NM_SOBRENOME3_c", "NM_SOBRENOME3_c"),
              "ULT_ATUALIZ"  = decode(substr(column_changed$_varchar2, 4, 1),'N', "ULT_ATUALIZ4_c" , "ULT_ATUALIZ4_c" ),
              "VLR_SAL"      = decode(substr(column_changed$_varchar2, 5, 1),'N', "VLR_SAL5_c"     , "VLR_SAL5_c"     ),
              "VLR_UNIT"     = decode(substr(column_changed$_varchar2, 6, 1),'N', "VLR_UNIT6_c"    , "VLR_UNIT6_c"    )
        where "CD_CODIGO1_o" = "CD_CODIGO";

        if sql%rowcount = 0 then

           raise no_data_found;

        elsif sql%rowcount > 1 then

           raise too_many_rows;

        end if;

    end if;

    dbms_reputil.rep_end;

  exception
    when no_data_found then

      begin
        if not "TAB_CONSULTORES$RR".update_conflict_handler( "CD_CODIGO1_o",
                                                             "CD_CODIGO1_c",
                                                             "NM_NOME2_o",
                                                             "NM_NOME2_c",
                                                             "NM_SOBRENOME3_o",
                                                             "NM_SOBRENOME3_c",
                                                             "ULT_ATUALIZ4_o",
                                                             "ULT_ATUALIZ4_c",
                                                             "VLR_SAL5_o",
                                                             "VLR_SAL5_c",
                                                             "VLR_UNIT6_o",
                                                             "VLR_UNIT6_c",
                                                             site_name,
                                                             propagation_flag,
                                                             column_changed$,
                                                             column_sent$_varchar2,
                                                             null ) then

          dbms_reputil.rep_end;
          raise;

        end if;

        dbms_reputil.rep_end;

      exception
        when others then
          dbms_reputil.rep_end;
          raise;

      end;


    when dup_val_on_index then

      begin

        if not "TAB_CONSULTORES$RR".unique_conflict_update_handler( "CD_CODIGO1_o",
                                                                    "CD_CODIGO1_c",
                                                                    "NM_NOME2_o",
                                                                    "NM_NOME2_c",
                                                                    "NM_SOBRENOME3_o",
                                                                    "NM_SOBRENOME3_c",
                                                                    "ULT_ATUALIZ4_o",
                                                                    "ULT_ATUALIZ4_c",
                                                                    "VLR_SAL5_o",
                                                                    "VLR_SAL5_c",
                                                                    "VLR_UNIT6_o",
                                                                    "VLR_UNIT6_c",
                                                                    site_name,
                                                                    propagation_flag,
                                                                    column_changed$,
                                                                    column_sent$_varchar2,
                                                                    null,
                                                                    SQLERRM ) then

          dbms_reputil.rep_end;
          raise;

        end if;

        dbms_reputil.rep_end;

      exception
        when others then
          dbms_reputil.rep_end;
          raise;

      end;

    when others then

      dbms_reputil.rep_end;
      raise;

  end rep_update;


end "TAB_CONSULTORES$RP";
/

