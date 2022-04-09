CREATE OR REPLACE package TAB_CONSULTORES$RP as

  column_changed$$ RAW(1000);

  function fu_coluna_caracter( pe_coluna_p   in varchar2
                              ,pe_coluna_c   in varchar2
                              ,pe_data_p     in date
                              ,pe_data_c     in date
                              ,pe_site_p     in varchar2
                              ,pe_site_c     in varchar2 ) 
  return varchar2;
  pragma restrict_references(fu_coluna_caracter, WNDS, WNPS, RNPS );


  procedure rep_delete( "CD_CODIGO1_o"    IN NUMBER,
                        "NM_NOME2_o"      IN VARCHAR2,
                        "NM_SOBRENOME3_o" IN VARCHAR2,
                        "ULT_ATUALIZ4_o"  IN DATE,
                        "VLR_SAL5_o"      IN NUMBER,
                        "VLR_UNIT6_o"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR );


  procedure rep_delete( column_changed$   IN RAW,
                        "CD_CODIGO1_o"    IN NUMBER,
                        "NM_NOME2_o"      IN VARCHAR2,
                        "NM_SOBRENOME3_o" IN VARCHAR2,
                        "ULT_ATUALIZ4_o"  IN DATE,
                        "VLR_SAL5_o"      IN NUMBER,
                        "VLR_UNIT6_o"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR );


  procedure rep_insert( "CD_CODIGO1_n"    IN NUMBER,
                        "NM_NOME2_n"      IN VARCHAR2,
                        "NM_SOBRENOME3_n" IN VARCHAR2,
                        "ULT_ATUALIZ4_n"  IN DATE,
                        "VLR_SAL5_n"      IN NUMBER,
                        "VLR_UNIT6_n"     IN NUMBER,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR );


  procedure rep_update( "CD_CODIGO1_o"         IN NUMBER,
                        "CD_CODIGO1_n"         IN NUMBER,
                        "NM_NOME2_o"           IN VARCHAR2,
                        "NM_NOME2_n"           IN VARCHAR2,
                        "NM_SOBRENOME3_o"      IN VARCHAR2,
                        "NM_SOBRENOME3_n"      IN VARCHAR2,
                        "ULT_ATUALIZ4_o"       IN DATE,
                        "ULT_ATUALIZ4_n"       IN DATE,
                        "VLR_SAL5_o"           IN NUMBER,
                        "VLR_SAL5_n"           IN NUMBER,
                        "VLR_UNIT6_o"          IN NUMBER,
                        "VLR_UNIT6_n"          IN NUMBER,
                        "ST_COLUNA_ALTERADA_o" IN VARCHAR2,
                        "ST_COLUNA_ALTERADA_n" IN VARCHAR2,
                        site_name              IN VARCHAR2,
                        propagation_flag       IN CHAR );


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
                        "ST_COLUNA_ALTERADA_o" IN VARCHAR2,
                        "ST_COLUNA_ALTERADA_n" IN VARCHAR2,
                        site_name         IN VARCHAR2,
                        propagation_flag  IN CHAR);

end "TAB_CONSULTORES$RP";
/






CREATE OR REPLACE package body TAB_CONSULTORES$RP as

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
    where ( "CD_CODIGO1_o" = "CD_CODIGO"

      and decode(substr(column_sent$_varchar2, 2, 1),'N', 'Y',
          decode("NM_NOME2_o", "NM_NOME", 'Y')) = 'Y'
 
      and decode(substr(column_sent$_varchar2, 3, 1),'N', 'Y',
          decode("NM_SOBRENOME3_o", "NM_SOBRENOME", 'Y')) = 'Y'

      and decode(substr(column_sent$_varchar2, 4, 1),'N', 'Y',
          decode("ULT_ATUALIZ4_o", "ULT_ATUALIZ", 'Y')) = 'Y'

      and decode(substr(column_sent$_varchar2, 5, 1),'N', 'Y',
          decode("VLR_SAL5_o", "VLR_SAL", 'Y')) = 'Y'

      and decode(substr(column_sent$_varchar2, 6, 1),'N', 'Y',
          decode("VLR_UNIT6_o", "VLR_UNIT", 'Y')) = 'Y' );


    if sql%rowcount = 0 then

      raise no_data_found;

    elsif sql%rowcount > 1 then

      raise too_many_rows;

    end if;

    dbms_reputil.rep_end;

  exception
    when no_data_found then

      begin
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
  -- REP_UPDATE CHAMA OUTRA PROCEDURE DE MESMO NOME
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
  -- ATUALIZACOES
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
    atualiza_registro         boolean  := true;

  begin

    column_changed$$ := column_changed$;

    if column_changed$ is not null then

       dbms_reputil.raw_to_varchar2(column_changed$,1,column_changed$_varchar2);
       dbms_reputil.raw_to_varchar2(column_changed$,2,column_sent$_varchar2);

    end if;

    dbms_reputil2.set_column_changed(column_changed$_varchar2);

    if propagation_flag = 'N' then
       dbms_reputil.replication_off;
    end if;

    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;
    atualiza_registro        := true;

    if DBMS_REPUTIL.MAXIMUM( "ULT_ATUALIZ4_n", "ULT_ATUALIZ4_o", atualiza_registro ) then

       update "TAB_CONSULTORES"
          set "CD_CODIGO"    = decode(substr(column_changed$_varchar2, 1, 1),'N', "CD_CODIGO"   , "CD_CODIGO1_n"   ),
              "NM_NOME"      = decode(substr(column_changed$_varchar2, 2, 1),'N', "NM_NOME"     , "NM_NOME2_n"     ),
              "NM_SOBRENOME" = decode(substr(column_changed$_varchar2, 3, 1),'N', "NM_SOBRENOME", "NM_SOBRENOME3_n"),
              "ULT_ATUALIZ"  = decode(substr(column_changed$_varchar2, 4, 1),'N', "ULT_ATUALIZ" , "ULT_ATUALIZ4_n" ),
              "VLR_SAL"      = decode(substr(column_changed$_varchar2, 5, 1),'N', "VLR_SAL"     , "VLR_SAL5_n"     ),
              "VLR_UNIT"     = decode(substr(column_changed$_varchar2, 6, 1),'N', "VLR_UNIT"    , "VLR_UNIT6_n"    )
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
        if not "TAB_CONSULTORES$RR".update_conflict_handler(
          "CD_CODIGO1_o",
          dbms_reputil2.choose_number(
              "CD_CODIGO1_o",
              "CD_CODIGO1_n",
              1),
          "NM_NOME2_o",
          dbms_reputil2.choose_varchar2(
              "NM_NOME2_o",
              "NM_NOME2_n",
              2),
          "NM_SOBRENOME3_o",
          dbms_reputil2.choose_varchar2(
              "NM_SOBRENOME3_o",
              "NM_SOBRENOME3_n",
              3),
          "ULT_ATUALIZ4_o",
          dbms_reputil2.choose_date(
              "ULT_ATUALIZ4_o",
              "ULT_ATUALIZ4_n",
              4),
          "VLR_SAL5_o",
          dbms_reputil2.choose_number(
              "VLR_SAL5_o",
              "VLR_SAL5_n",
              5),
          "VLR_UNIT6_o",
          dbms_reputil2.choose_number(
              "VLR_UNIT6_o",
              "VLR_UNIT6_n",
              6),
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
        if not "TAB_CONSULTORES$RR".unique_conflict_update_handler(
          "CD_CODIGO1_o",
          dbms_reputil2.choose_number(
              "CD_CODIGO1_o",
              "CD_CODIGO1_n",
              1),
          "NM_NOME2_o",
          dbms_reputil2.choose_varchar2(
              "NM_NOME2_o",
              "NM_NOME2_n",
              2),
          "NM_SOBRENOME3_o",
          dbms_reputil2.choose_varchar2(
              "NM_SOBRENOME3_o",
              "NM_SOBRENOME3_n",
              3),
          "ULT_ATUALIZ4_o",
          dbms_reputil2.choose_date(
              "ULT_ATUALIZ4_o",
              "ULT_ATUALIZ4_n",
              4),
          "VLR_SAL5_o",
          dbms_reputil2.choose_number(
              "VLR_SAL5_o",
              "VLR_SAL5_n",
              5),
          "VLR_UNIT6_o",
          dbms_reputil2.choose_number(
              "VLR_UNIT6_o",
              "VLR_UNIT6_n",
              6),
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

