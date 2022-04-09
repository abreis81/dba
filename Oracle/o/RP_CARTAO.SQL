CREATE OR REPLACE package TBEDGE_CARTAO$RP as

  column_changed$$ RAW(1000);

  procedure rep_delete(
    "DALT_AGECC1_o" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR);

  procedure rep_delete(
    column_changed$ IN RAW,
    "DALT_AGECC1_o" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR);

  procedure rep_insert(
    "DALT_AGECC1_n" IN DATE,
    "DALT_CICLO2_n" IN DATE,
    "DALT_END3_n" IN DATE,
    "DALT_FPAGA4_n" IN DATE,
    "DDAT_EMISS5_n" IN DATE,
    "DDAT_LIM6_n" IN DATE,
    "DDAT_NASC7_n" IN DATE,
    "DDAT_STA8_n" IN DATE,
    "NCEP_ASSOC9_n" IN NUMBER,
    "NCEP_COMPL10_n" IN NUMBER,
    "NCGC_CPF11_n" IN NUMBER,
    "NDAT_ABERT12_n" IN NUMBER,
    "NDAT_VALID13_n" IN NUMBER,
    "NDIA_CORTE14_n" IN NUMBER,
    "NDIA_VENCI15_n" IN NUMBER,
    "N_INSTITUI16_n" IN NUMBER,
    "NLIM_CARTD17_n" IN NUMBER,
    "NLIM_CARTR18_n" IN NUMBER,
    "NLIM_SAQD19_n" IN NUMBER,
    "NLIM_SAQR20_n" IN NUMBER,
    "NNUM_AGENC21_n" IN NUMBER,
    "NNUM_CART22_n" IN NUMBER,
    "NNUM_CCORR23_n" IN NUMBER,
    "NSTA_SENHA24_n" IN NUMBER,
    "NTP_ASSOC25_n" IN VARCHAR2,
    "VCART_PROT26_n" IN VARCHAR2,
    "VCID_ASSOC27_n" IN VARCHAR2,
    "VCOD_BANDE28_n" IN VARCHAR2,
    "VDES_INSTI29_n" IN VARCHAR2,
    "VDIG_AGENC30_n" IN VARCHAR2,
    "VDIG_CCORR31_n" IN VARCHAR2,
    "VEND_ASSOC32_n" IN VARCHAR2,
    "VKEY_CLI33_n" IN VARCHAR2,
    "VNOM_ASSOC34_n" IN VARCHAR2,
    "VNOM_PAIS35_n" IN VARCHAR2,
    "VSENHA_FON36_n" IN VARCHAR2,
    "VSTA_CART37_n" IN VARCHAR2,
    "VTEL_COM38_n" IN VARCHAR2,
    "VTEL_RES39_n" IN VARCHAR2,
    "VUF_ASSOC40_n" IN VARCHAR2,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR);

  procedure rep_update(
    "DALT_AGECC1_o" IN DATE,
    "DALT_AGECC1_n" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_CICLO2_n" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_END3_n" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DALT_FPAGA4_n" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_EMISS5_n" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_LIM6_n" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_NASC7_n" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "DDAT_STA8_n" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_ASSOC9_n" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCEP_COMPL10_n" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NCGC_CPF11_n" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_ABERT12_n" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDAT_VALID13_n" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_CORTE14_n" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "NDIA_VENCI15_n" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "N_INSTITUI16_n" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTD17_n" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_CARTR18_n" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQD19_n" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NLIM_SAQR20_n" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_AGENC21_n" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CART22_n" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NNUM_CCORR23_n" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NSTA_SENHA24_n" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "NTP_ASSOC25_n" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCART_PROT26_n" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCID_ASSOC27_n" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VCOD_BANDE28_n" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDES_INSTI29_n" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_AGENC30_n" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VDIG_CCORR31_n" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VEND_ASSOC32_n" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VKEY_CLI33_n" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_ASSOC34_n" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VNOM_PAIS35_n" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSENHA_FON36_n" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VSTA_CART37_n" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_COM38_n" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VTEL_RES39_n" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    "VUF_ASSOC40_n" IN VARCHAR2,
    "DAT_ATUALIZ41_o" IN DATE,
    "DAT_ATUALIZ41_n" IN DATE,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR);

  procedure rep_update(
    column_changed$ IN RAW,
    "DALT_AGECC1_o" IN DATE,
    "DALT_AGECC1_n" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_CICLO2_n" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_END3_n" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DALT_FPAGA4_n" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_EMISS5_n" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_LIM6_n" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_NASC7_n" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "DDAT_STA8_n" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_ASSOC9_n" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCEP_COMPL10_n" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NCGC_CPF11_n" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_ABERT12_n" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDAT_VALID13_n" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_CORTE14_n" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "NDIA_VENCI15_n" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "N_INSTITUI16_n" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTD17_n" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_CARTR18_n" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQD19_n" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NLIM_SAQR20_n" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_AGENC21_n" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CART22_n" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NNUM_CCORR23_n" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NSTA_SENHA24_n" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "NTP_ASSOC25_n" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCART_PROT26_n" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCID_ASSOC27_n" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VCOD_BANDE28_n" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDES_INSTI29_n" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_AGENC30_n" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VDIG_CCORR31_n" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VEND_ASSOC32_n" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VKEY_CLI33_n" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_ASSOC34_n" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VNOM_PAIS35_n" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSENHA_FON36_n" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VSTA_CART37_n" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_COM38_n" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VTEL_RES39_n" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    "VUF_ASSOC40_n" IN VARCHAR2,
    "DAT_ATUALIZ41_o" IN DATE,
    "DAT_ATUALIZ41_n" IN DATE,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR);
end "TBEDGE_CARTAO$RP";
/


CREATE OR REPLACE package body TBEDGE_CARTAO$RP as

  procedure rep_delete(
    "DALT_AGECC1_o" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR) is
  begin

    rep_delete(
      NULL,
      "DALT_AGECC1_o",
      "DALT_CICLO2_o",
      "DALT_END3_o",
      "DALT_FPAGA4_o",
      "DDAT_EMISS5_o",
      "DDAT_LIM6_o",
      "DDAT_NASC7_o",
      "DDAT_STA8_o",
      "NCEP_ASSOC9_o",
      "NCEP_COMPL10_o",
      "NCGC_CPF11_o",
      "NDAT_ABERT12_o",
      "NDAT_VALID13_o",
      "NDIA_CORTE14_o",
      "NDIA_VENCI15_o",
      "N_INSTITUI16_o",
      "NLIM_CARTD17_o",
      "NLIM_CARTR18_o",
      "NLIM_SAQD19_o",
      "NLIM_SAQR20_o",
      "NNUM_AGENC21_o",
      "NNUM_CART22_o",
      "NNUM_CCORR23_o",
      "NSTA_SENHA24_o",
      "NTP_ASSOC25_o",
      "VCART_PROT26_o",
      "VCID_ASSOC27_o",
      "VCOD_BANDE28_o",
      "VDES_INSTI29_o",
      "VDIG_AGENC30_o",
      "VDIG_CCORR31_o",
      "VEND_ASSOC32_o",
      "VKEY_CLI33_o",
      "VNOM_ASSOC34_o",
      "VNOM_PAIS35_o",
      "VSENHA_FON36_o",
      "VSTA_CART37_o",
      "VTEL_COM38_o",
      "VTEL_RES39_o",
      "VUF_ASSOC40_o",
      site_name,
      propagation_flag);

  end rep_delete;



  procedure rep_delete(
    column_changed$ IN RAW,
    "DALT_AGECC1_o" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR) is

    column_sent$_varchar2 VARCHAR2(40);

  begin

    column_changed$$ := column_changed$;

    if column_changed$ is not null then
       dbms_reputil.raw_to_varchar2(column_changed$,2,column_sent$_varchar2);
    end if;

    if propagation_flag = 'N' then
       dbms_reputil.replication_off;
    end if;

    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;

    delete from "TBEDGE_CARTAO"
     where "NNUM_CART22_o" = "NNUM_CART";

    if sql%rowcount = 0 then
       raise no_data_found;
    elsif sql%rowcount > 1 then
       raise too_many_rows;
    end if;

    dbms_reputil.rep_end;

  exception
    when no_data_found then

      begin
        if not "TBEDGE_CARTAO$RR".delete_conflict_handler(
          "DALT_AGECC1_o",
          "DALT_CICLO2_o",
          "DALT_END3_o",
          "DALT_FPAGA4_o",
          "DDAT_EMISS5_o",
          "DDAT_LIM6_o",
          "DDAT_NASC7_o",
          "DDAT_STA8_o",
          "NCEP_ASSOC9_o",
          "NCEP_COMPL10_o",
          "NCGC_CPF11_o",
          "NDAT_ABERT12_o",
          "NDAT_VALID13_o",
          "NDIA_CORTE14_o",
          "NDIA_VENCI15_o",
          "N_INSTITUI16_o",
          "NLIM_CARTD17_o",
          "NLIM_CARTR18_o",
          "NLIM_SAQD19_o",
          "NLIM_SAQR20_o",
          "NNUM_AGENC21_o",
          "NNUM_CART22_o",
          "NNUM_CCORR23_o",
          "NSTA_SENHA24_o",
          "NTP_ASSOC25_o",
          "VCART_PROT26_o",
          "VCID_ASSOC27_o",
          "VCOD_BANDE28_o",
          "VDES_INSTI29_o",
          "VDIG_AGENC30_o",
          "VDIG_CCORR31_o",
          "VEND_ASSOC32_o",
          "VKEY_CLI33_o",
          "VNOM_ASSOC34_o",
          "VNOM_PAIS35_o",
          "VSENHA_FON36_o",
          "VSTA_CART37_o",
          "VTEL_COM38_o",
          "VTEL_RES39_o",
          "VUF_ASSOC40_o",
          site_name,
          propagation_flag,
          column_changed$,
          column_sent$_varchar2) then

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



  procedure rep_insert(
    "DALT_AGECC1_n" IN DATE,
    "DALT_CICLO2_n" IN DATE,
    "DALT_END3_n" IN DATE,
    "DALT_FPAGA4_n" IN DATE,
    "DDAT_EMISS5_n" IN DATE,
    "DDAT_LIM6_n" IN DATE,
    "DDAT_NASC7_n" IN DATE,
    "DDAT_STA8_n" IN DATE,
    "NCEP_ASSOC9_n" IN NUMBER,
    "NCEP_COMPL10_n" IN NUMBER,
    "NCGC_CPF11_n" IN NUMBER,
    "NDAT_ABERT12_n" IN NUMBER,
    "NDAT_VALID13_n" IN NUMBER,
    "NDIA_CORTE14_n" IN NUMBER,
    "NDIA_VENCI15_n" IN NUMBER,
    "N_INSTITUI16_n" IN NUMBER,
    "NLIM_CARTD17_n" IN NUMBER,
    "NLIM_CARTR18_n" IN NUMBER,
    "NLIM_SAQD19_n" IN NUMBER,
    "NLIM_SAQR20_n" IN NUMBER,
    "NNUM_AGENC21_n" IN NUMBER,
    "NNUM_CART22_n" IN NUMBER,
    "NNUM_CCORR23_n" IN NUMBER,
    "NSTA_SENHA24_n" IN NUMBER,
    "NTP_ASSOC25_n" IN VARCHAR2,
    "VCART_PROT26_n" IN VARCHAR2,
    "VCID_ASSOC27_n" IN VARCHAR2,
    "VCOD_BANDE28_n" IN VARCHAR2,
    "VDES_INSTI29_n" IN VARCHAR2,
    "VDIG_AGENC30_n" IN VARCHAR2,
    "VDIG_CCORR31_n" IN VARCHAR2,
    "VEND_ASSOC32_n" IN VARCHAR2,
    "VKEY_CLI33_n" IN VARCHAR2,
    "VNOM_ASSOC34_n" IN VARCHAR2,
    "VNOM_PAIS35_n" IN VARCHAR2,
    "VSENHA_FON36_n" IN VARCHAR2,
    "VSTA_CART37_n" IN VARCHAR2,
    "VTEL_COM38_n" IN VARCHAR2,
    "VTEL_RES39_n" IN VARCHAR2,
    "VUF_ASSOC40_n" IN VARCHAR2,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR) is

  begin

    if propagation_flag = 'N' then
      dbms_reputil.replication_off;
    end if;

    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;

    insert into "TBEDGE_CARTAO" (
      "DALT_AGECC",
      "DALT_CICLO",
      "DALT_END",
      "DALT_FPAGA",
      "DDAT_EMISS",
      "DDAT_LIM",
      "DDAT_NASC",
      "DDAT_STA",
      "NCEP_ASSOC",
      "NCEP_COMPL",
      "NCGC_CPF",
      "NDAT_ABERT",
      "NDAT_VALID",
      "NDIA_CORTE",
      "NDIA_VENCI",
      "N_INSTITUI",
      "NLIM_CARTD",
      "NLIM_CARTR",
      "NLIM_SAQD",
      "NLIM_SAQR",
      "NNUM_AGENC",
      "NNUM_CART",
      "NNUM_CCORR",
      "NSTA_SENHA",
      "NTP_ASSOC",
      "VCART_PROT",
      "VCID_ASSOC",
      "VCOD_BANDE",
      "VDES_INSTI",
      "VDIG_AGENC",
      "VDIG_CCORR",
      "VEND_ASSOC",
      "VKEY_CLI",
      "VNOM_ASSOC",
      "VNOM_PAIS",
      "VSENHA_FON",
      "VSTA_CART",
      "VTEL_COM",
      "VTEL_RES",
      "VUF_ASSOC")
    values (
      "DALT_AGECC1_n",
      "DALT_CICLO2_n",
      "DALT_END3_n",
      "DALT_FPAGA4_n",
      "DDAT_EMISS5_n",
      "DDAT_LIM6_n",
      "DDAT_NASC7_n",
      "DDAT_STA8_n",
      "NCEP_ASSOC9_n",
      "NCEP_COMPL10_n",
      "NCGC_CPF11_n",
      "NDAT_ABERT12_n",
      "NDAT_VALID13_n",
      "NDIA_CORTE14_n",
      "NDIA_VENCI15_n",
      "N_INSTITUI16_n",
      "NLIM_CARTD17_n",
      "NLIM_CARTR18_n",
      "NLIM_SAQD19_n",
      "NLIM_SAQR20_n",
      "NNUM_AGENC21_n",
      "NNUM_CART22_n",
      "NNUM_CCORR23_n",
      "NSTA_SENHA24_n",
      "NTP_ASSOC25_n",
      "VCART_PROT26_n",
      "VCID_ASSOC27_n",
      "VCOD_BANDE28_n",
      "VDES_INSTI29_n",
      "VDIG_AGENC30_n",
      "VDIG_CCORR31_n",
      "VEND_ASSOC32_n",
      "VKEY_CLI33_n",
      "VNOM_ASSOC34_n",
      "VNOM_PAIS35_n",
      "VSENHA_FON36_n",
      "VSTA_CART37_n",
      "VTEL_COM38_n",
      "VTEL_RES39_n",
      "VUF_ASSOC40_n");

    dbms_reputil.rep_end;

  exception
    when dup_val_on_index then
      begin
        if not "TBEDGE_CARTAO$RR".unique_conflict_insert_handler(
          "DALT_AGECC1_n",
          "DALT_CICLO2_n",
          "DALT_END3_n",
          "DALT_FPAGA4_n",
          "DDAT_EMISS5_n",
          "DDAT_LIM6_n",
          "DDAT_NASC7_n",
          "DDAT_STA8_n",
          "NCEP_ASSOC9_n",
          "NCEP_COMPL10_n",
          "NCGC_CPF11_n",
          "NDAT_ABERT12_n",
          "NDAT_VALID13_n",
          "NDIA_CORTE14_n",
          "NDIA_VENCI15_n",
          "N_INSTITUI16_n",
          "NLIM_CARTD17_n",
          "NLIM_CARTR18_n",
          "NLIM_SAQD19_n",
          "NLIM_SAQR20_n",
          "NNUM_AGENC21_n",
          "NNUM_CART22_n",
          "NNUM_CCORR23_n",
          "NSTA_SENHA24_n",
          "NTP_ASSOC25_n",
          "VCART_PROT26_n",
          "VCID_ASSOC27_n",
          "VCOD_BANDE28_n",
          "VDES_INSTI29_n",
          "VDIG_AGENC30_n",
          "VDIG_CCORR31_n",
          "VEND_ASSOC32_n",
          "VKEY_CLI33_n",
          "VNOM_ASSOC34_n",
          "VNOM_PAIS35_n",
          "VSENHA_FON36_n",
          "VSTA_CART37_n",
          "VTEL_COM38_n",
          "VTEL_RES39_n",
          "VUF_ASSOC40_n",
          site_name,
          propagation_flag,
          SQLERRM) then

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



  procedure rep_update(
    "DALT_AGECC1_o" IN DATE,
    "DALT_AGECC1_n" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_CICLO2_n" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_END3_n" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DALT_FPAGA4_n" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_EMISS5_n" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_LIM6_n" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_NASC7_n" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "DDAT_STA8_n" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_ASSOC9_n" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCEP_COMPL10_n" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NCGC_CPF11_n" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_ABERT12_n" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDAT_VALID13_n" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_CORTE14_n" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "NDIA_VENCI15_n" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "N_INSTITUI16_n" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTD17_n" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_CARTR18_n" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQD19_n" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NLIM_SAQR20_n" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_AGENC21_n" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CART22_n" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NNUM_CCORR23_n" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NSTA_SENHA24_n" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "NTP_ASSOC25_n" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCART_PROT26_n" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCID_ASSOC27_n" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VCOD_BANDE28_n" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDES_INSTI29_n" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_AGENC30_n" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VDIG_CCORR31_n" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VEND_ASSOC32_n" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VKEY_CLI33_n" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_ASSOC34_n" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VNOM_PAIS35_n" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSENHA_FON36_n" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VSTA_CART37_n" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_COM38_n" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VTEL_RES39_n" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    "VUF_ASSOC40_n" IN VARCHAR2,
    "DAT_ATUALIZ41_o" IN DATE,
    "DAT_ATUALIZ41_n" IN DATE,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR) is

  begin

    rep_update(
      NULL,
      "DALT_AGECC1_o",
      "DALT_AGECC1_n",
      "DALT_CICLO2_o",
      "DALT_CICLO2_n",
      "DALT_END3_o",
      "DALT_END3_n",
      "DALT_FPAGA4_o",
      "DALT_FPAGA4_n",
      "DDAT_EMISS5_o",
      "DDAT_EMISS5_n",
      "DDAT_LIM6_o",
      "DDAT_LIM6_n",
      "DDAT_NASC7_o",
      "DDAT_NASC7_n",
      "DDAT_STA8_o",
      "DDAT_STA8_n",
      "NCEP_ASSOC9_o",
      "NCEP_ASSOC9_n",
      "NCEP_COMPL10_o",
      "NCEP_COMPL10_n",
      "NCGC_CPF11_o",
      "NCGC_CPF11_n",
      "NDAT_ABERT12_o",
      "NDAT_ABERT12_n",
      "NDAT_VALID13_o",
      "NDAT_VALID13_n",
      "NDIA_CORTE14_o",
      "NDIA_CORTE14_n",
      "NDIA_VENCI15_o",
      "NDIA_VENCI15_n",
      "N_INSTITUI16_o",
      "N_INSTITUI16_n",
      "NLIM_CARTD17_o",
      "NLIM_CARTD17_n",
      "NLIM_CARTR18_o",
      "NLIM_CARTR18_n",
      "NLIM_SAQD19_o",
      "NLIM_SAQD19_n",
      "NLIM_SAQR20_o",
      "NLIM_SAQR20_n",
      "NNUM_AGENC21_o",
      "NNUM_AGENC21_n",
      "NNUM_CART22_o",
      "NNUM_CART22_n",
      "NNUM_CCORR23_o",
      "NNUM_CCORR23_n",
      "NSTA_SENHA24_o",
      "NSTA_SENHA24_n",
      "NTP_ASSOC25_o",
      "NTP_ASSOC25_n",
      "VCART_PROT26_o",
      "VCART_PROT26_n",
      "VCID_ASSOC27_o",
      "VCID_ASSOC27_n",
      "VCOD_BANDE28_o",
      "VCOD_BANDE28_n",
      "VDES_INSTI29_o",
      "VDES_INSTI29_n",
      "VDIG_AGENC30_o",
      "VDIG_AGENC30_n",
      "VDIG_CCORR31_o",
      "VDIG_CCORR31_n",
      "VEND_ASSOC32_o",
      "VEND_ASSOC32_n",
      "VKEY_CLI33_o",
      "VKEY_CLI33_n",
      "VNOM_ASSOC34_o",
      "VNOM_ASSOC34_n",
      "VNOM_PAIS35_o",
      "VNOM_PAIS35_n",
      "VSENHA_FON36_o",
      "VSENHA_FON36_n",
      "VSTA_CART37_o",
      "VSTA_CART37_n",
      "VTEL_COM38_o",
      "VTEL_COM38_n",
      "VTEL_RES39_o",
      "VTEL_RES39_n",
      "VUF_ASSOC40_o",
      "VUF_ASSOC40_n",
      "DAT_ATUALIZ41_o", 
      "DAT_ATUALIZ41_n",
      site_name,
      propagation_flag);

  end rep_update;



  procedure rep_update(
    column_changed$ IN RAW,
    "DALT_AGECC1_o" IN DATE,
    "DALT_AGECC1_n" IN DATE,
    "DALT_CICLO2_o" IN DATE,
    "DALT_CICLO2_n" IN DATE,
    "DALT_END3_o" IN DATE,
    "DALT_END3_n" IN DATE,
    "DALT_FPAGA4_o" IN DATE,
    "DALT_FPAGA4_n" IN DATE,
    "DDAT_EMISS5_o" IN DATE,
    "DDAT_EMISS5_n" IN DATE,
    "DDAT_LIM6_o" IN DATE,
    "DDAT_LIM6_n" IN DATE,
    "DDAT_NASC7_o" IN DATE,
    "DDAT_NASC7_n" IN DATE,
    "DDAT_STA8_o" IN DATE,
    "DDAT_STA8_n" IN DATE,
    "NCEP_ASSOC9_o" IN NUMBER,
    "NCEP_ASSOC9_n" IN NUMBER,
    "NCEP_COMPL10_o" IN NUMBER,
    "NCEP_COMPL10_n" IN NUMBER,
    "NCGC_CPF11_o" IN NUMBER,
    "NCGC_CPF11_n" IN NUMBER,
    "NDAT_ABERT12_o" IN NUMBER,
    "NDAT_ABERT12_n" IN NUMBER,
    "NDAT_VALID13_o" IN NUMBER,
    "NDAT_VALID13_n" IN NUMBER,
    "NDIA_CORTE14_o" IN NUMBER,
    "NDIA_CORTE14_n" IN NUMBER,
    "NDIA_VENCI15_o" IN NUMBER,
    "NDIA_VENCI15_n" IN NUMBER,
    "N_INSTITUI16_o" IN NUMBER,
    "N_INSTITUI16_n" IN NUMBER,
    "NLIM_CARTD17_o" IN NUMBER,
    "NLIM_CARTD17_n" IN NUMBER,
    "NLIM_CARTR18_o" IN NUMBER,
    "NLIM_CARTR18_n" IN NUMBER,
    "NLIM_SAQD19_o" IN NUMBER,
    "NLIM_SAQD19_n" IN NUMBER,
    "NLIM_SAQR20_o" IN NUMBER,
    "NLIM_SAQR20_n" IN NUMBER,
    "NNUM_AGENC21_o" IN NUMBER,
    "NNUM_AGENC21_n" IN NUMBER,
    "NNUM_CART22_o" IN NUMBER,
    "NNUM_CART22_n" IN NUMBER,
    "NNUM_CCORR23_o" IN NUMBER,
    "NNUM_CCORR23_n" IN NUMBER,
    "NSTA_SENHA24_o" IN NUMBER,
    "NSTA_SENHA24_n" IN NUMBER,
    "NTP_ASSOC25_o" IN VARCHAR2,
    "NTP_ASSOC25_n" IN VARCHAR2,
    "VCART_PROT26_o" IN VARCHAR2,
    "VCART_PROT26_n" IN VARCHAR2,
    "VCID_ASSOC27_o" IN VARCHAR2,
    "VCID_ASSOC27_n" IN VARCHAR2,
    "VCOD_BANDE28_o" IN VARCHAR2,
    "VCOD_BANDE28_n" IN VARCHAR2,
    "VDES_INSTI29_o" IN VARCHAR2,
    "VDES_INSTI29_n" IN VARCHAR2,
    "VDIG_AGENC30_o" IN VARCHAR2,
    "VDIG_AGENC30_n" IN VARCHAR2,
    "VDIG_CCORR31_o" IN VARCHAR2,
    "VDIG_CCORR31_n" IN VARCHAR2,
    "VEND_ASSOC32_o" IN VARCHAR2,
    "VEND_ASSOC32_n" IN VARCHAR2,
    "VKEY_CLI33_o" IN VARCHAR2,
    "VKEY_CLI33_n" IN VARCHAR2,
    "VNOM_ASSOC34_o" IN VARCHAR2,
    "VNOM_ASSOC34_n" IN VARCHAR2,
    "VNOM_PAIS35_o" IN VARCHAR2,
    "VNOM_PAIS35_n" IN VARCHAR2,
    "VSENHA_FON36_o" IN VARCHAR2,
    "VSENHA_FON36_n" IN VARCHAR2,
    "VSTA_CART37_o" IN VARCHAR2,
    "VSTA_CART37_n" IN VARCHAR2,
    "VTEL_COM38_o" IN VARCHAR2,
    "VTEL_COM38_n" IN VARCHAR2,
    "VTEL_RES39_o" IN VARCHAR2,
    "VTEL_RES39_n" IN VARCHAR2,
    "VUF_ASSOC40_o" IN VARCHAR2,
    "VUF_ASSOC40_n" IN VARCHAR2,
    "DAT_ATUALIZ41_o" IN DATE,
    "DAT_ATUALIZ41_n" IN DATE,
    site_name IN VARCHAR2,
    propagation_flag IN CHAR ) is

    column_changed$_varchar2  VARCHAR2(40);
    column_sent$_varchar2     VARCHAR2(40);
    registro_no_destino       boolean;
    registro_na_origem        boolean;
    transacao_valida          boolean;
    "DAT_ATUALIZ_x"           TBEDGE_CARTAO.DAT_ATUALIZ%TYPE;
    "DALT_AGECC_c"		TBEDGE_CARTAO.DALT_AGECC%TYPE;
    "DALT_CICLO_c"		TBEDGE_CARTAO.DALT_CICLO%TYPE;
    "DALT_END_c"			TBEDGE_CARTAO.DALT_END%TYPE;
    "DALT_FPAGA_c"		TBEDGE_CARTAO.DALT_FPAGA%TYPE;
    "DDAT_EMISS_c"		TBEDGE_CARTAO.DDAT_EMISS%TYPE;
    "DDAT_LIM_c"			TBEDGE_CARTAO.DDAT_LIM%TYPE;
    "DDAT_NASC_c"			TBEDGE_CARTAO.DDAT_NASC%TYPE;
    "DDAT_STA_c"			TBEDGE_CARTAO.DDAT_STA%TYPE;
    "NCEP_ASSOC_c"		TBEDGE_CARTAO.NCEP_ASSOC%TYPE;
    "NCEP_COMPL_c"		TBEDGE_CARTAO.NCEP_COMPL%TYPE;
    "NCGC_CPF_c"			TBEDGE_CARTAO.NCGC_CPF%TYPE;
    "NDAT_ABERT_c"		TBEDGE_CARTAO.NDAT_ABERT%TYPE;
    "NDAT_VALID_c"		TBEDGE_CARTAO.NDAT_VALID%TYPE;
    "NDIA_CORTE_c"		TBEDGE_CARTAO.NDIA_CORTE%TYPE;
    "NDIA_VENCI_c"		TBEDGE_CARTAO.NDIA_VENCI%TYPE;
    "N_INSTITUI_c"		TBEDGE_CARTAO.N_INSTITUI%TYPE;
    "NLIM_CARTD_c"		TBEDGE_CARTAO.NLIM_CARTD%TYPE;
    "NLIM_CARTR_c"		TBEDGE_CARTAO.NLIM_CARTR%TYPE;
    "NLIM_SAQD_c"			TBEDGE_CARTAO.NLIM_SAQD%TYPE;
    "NLIM_SAQR_c"			TBEDGE_CARTAO.NLIM_SAQR%TYPE;
    "NNUM_AGENC_c"		TBEDGE_CARTAO.NNUM_AGENC%TYPE;
    "NNUM_CART_c"			TBEDGE_CARTAO.NNUM_CART%TYPE;
    "NNUM_CCORR_c"		TBEDGE_CARTAO.NNUM_CCORR%TYPE;
    "NSTA_SENHA_c"		TBEDGE_CARTAO.NSTA_SENHA%TYPE;
    "NTP_ASSOC_c"			TBEDGE_CARTAO.NTP_ASSOC%TYPE;
    "VCART_PROT_c"		TBEDGE_CARTAO.VCART_PROT%TYPE;
    "VCID_ASSOC_c"		TBEDGE_CARTAO.VCID_ASSOC%TYPE;
    "VCOD_BANDE_c"		TBEDGE_CARTAO.VCOD_BANDE%TYPE;
    "VDES_INSTI_c"		TBEDGE_CARTAO.VDES_INSTI%TYPE;
    "VDIG_AGENC_c"		TBEDGE_CARTAO.VDIG_AGENC%TYPE;
    "VDIG_CCORR_c"		TBEDGE_CARTAO.VDIG_CCORR%TYPE;
    "VEND_ASSOC_c"		TBEDGE_CARTAO.VEND_ASSOC%TYPE;
    "VKEY_CLI_c"			TBEDGE_CARTAO.VKEY_CLI%TYPE;
    "VNOM_ASSOC_c"		TBEDGE_CARTAO.VNOM_ASSOC%TYPE;
    "VNOM_PAIS_c"			TBEDGE_CARTAO.VNOM_PAIS%TYPE;
    "VSENHA_FON_c"		TBEDGE_CARTAO.VSENHA_FON%TYPE;
    "VSTA_CART_c"			TBEDGE_CARTAO.VSTA_CART%TYPE;
    "VTEL_COM_c"			TBEDGE_CARTAO.VTEL_COM%TYPE;
    "VTEL_RES_c"			TBEDGE_CARTAO.VTEL_RES%TYPE;
    "VUF_ASSOC_c"			TBEDGE_CARTAO.VUF_ASSOC%TYPE;
    "DAT_ATUALIZ_c"           TBEDGE_CARTAO.DAT_ATUALIZ%TYPE;

  begin

    column_changed$$ := column_changed$;

    if column_changed$ is not null then
       dbms_reputil.raw_to_varchar2(column_changed$,1,column_changed$_varchar2);
       dbms_reputil.raw_to_varchar2(column_changed$,2,column_sent$_varchar2);
    end if;

    registro_na_origem := true;

    begin

      select "DALT_AGECC",
             "DALT_CICLO",
             "DALT_END"	,
             "DALT_FPAGA",	
             "DDAT_EMISS",	
             "DDAT_LIM"	,
             "DDAT_NASC",	
             "DDAT_STA"	,
             "NCEP_ASSOC",	
             "NCEP_COMPL",	
             "NCGC_CPF"	,
             "NDAT_ABERT",	
             "NDAT_VALID",	
             "NDIA_CORTE",	
             "NDIA_VENCI",	
             "N_INSTITUI",	
             "NLIM_CARTD",	
             "NLIM_CARTR",	
             "NLIM_SAQD",	
             "NLIM_SAQR",	
             "NNUM_AGENC",	
             "NNUM_CART",	
             "NNUM_CCORR",	
             "NSTA_SENHA",	
             "NTP_ASSOC",	
             "VCART_PROT",	
             "VCID_ASSOC",	
             "VCOD_BANDE",	
             "VDES_INSTI",	
             "VDIG_AGENC",	
             "VDIG_CCORR",	
             "VEND_ASSOC",	
             "VKEY_CLI"	,
             "VNOM_ASSOC",	
             "VNOM_PAIS",	
             "VSENHA_FON",	
             "VSTA_CART",	
             "VTEL_COM"	,
             "VTEL_RES"	,
             "VUF_ASSOC",	
             "DAT_ATUALIZ"
        into "DALT_AGECC_c",
             "DALT_CICLO_c",
             "DALT_END_c",
             "DALT_FPAGA_c",	
             "DDAT_EMISS_c",	
             "DDAT_LIM_c",
             "DDAT_NASC_c",	
             "DDAT_STA_c",
             "NCEP_ASSOC_c",	
             "NCEP_COMPL_c",	
             "NCGC_CPF_c",
             "NDAT_ABERT_c",	
             "NDAT_VALID_c",	
             "NDIA_CORTE_c",	
             "NDIA_VENCI_c",	
             "N_INSTITUI_c",	
             "NLIM_CARTD_c",	
             "NLIM_CARTR_c",	
             "NLIM_SAQD_c",	
             "NLIM_SAQR_c",	
             "NNUM_AGENC_c",	
             "NNUM_CART_c",	
             "NNUM_CCORR_c",	
             "NSTA_SENHA_c",	
             "NTP_ASSOC_c",	
             "VCART_PROT_c",	
             "VCID_ASSOC_c",	
             "VCOD_BANDE_c",	
             "VDES_INSTI_c",	
             "VDIG_AGENC_c",	
             "VDIG_CCORR_c",	
             "VEND_ASSOC_c",	
             "VKEY_CLI_c",
             "VNOM_ASSOC_c",	
             "VNOM_PAIS_c",	
             "VSENHA_FON_c",	
             "VSTA_CART_c",	
             "VTEL_COM_c",
             "VTEL_RES_c",
             "VUF_ASSOC_c",
             "DAT_ATUALIZ_c"
        from "TBEDGE_CARTAO"
       where "NNUM_CART22_o" = "NNUM_CART";

    exception
      when others then
        registro_na_origem := false;

    end;
    
    dbms_reputil2.set_column_changed(column_changed$_varchar2);

    if propagation_flag = 'N' then
       dbms_reputil.replication_off;
    end if;

    dbms_reputil.rep_begin(site_name);
    dbms_reputil.global_name := site_name;
    registro_no_destino      := true;
    transacao_valida         := false;

    begin
      select "DAT_ATUALIZ"
        into "DAT_ATUALIZ_x"
        from "TBEDGE_CARTAO"
       where "NNUM_CART22_o" = "NNUM_CART";
    exception
      when others then
        registro_no_destino := false;
    end;

    if TO_CHAR("DAT_ATUALIZ41_n",'DD/MM/YYYY HH24:MI:SS') > TO_CHAR("DAT_ATUALIZ_x",'DD/MM/YYYY HH24:MI:SS') then
       transacao_valida  := true;
    end if;


    if not registro_na_origem then

       registro_na_origem := true;

       begin

      select "DALT_AGECC",
             "DALT_CICLO",
             "DALT_END"	,
             "DALT_FPAGA",	
             "DDAT_EMISS",	
             "DDAT_LIM"	,
             "DDAT_NASC",	
             "DDAT_STA"	,
             "NCEP_ASSOC",	
             "NCEP_COMPL",	
             "NCGC_CPF"	,
             "NDAT_ABERT",	
             "NDAT_VALID",	
             "NDIA_CORTE",	
             "NDIA_VENCI",	
             "N_INSTITUI",	
             "NLIM_CARTD",	
             "NLIM_CARTR",	
             "NLIM_SAQD",	
             "NLIM_SAQR",	
             "NNUM_AGENC",	
             "NNUM_CART",	
             "NNUM_CCORR",	
             "NSTA_SENHA",	
             "NTP_ASSOC",	
             "VCART_PROT",	
             "VCID_ASSOC",	
             "VCOD_BANDE",	
             "VDES_INSTI",	
             "VDIG_AGENC",	
             "VDIG_CCORR",	
             "VEND_ASSOC",	
             "VKEY_CLI"	,
             "VNOM_ASSOC",	
             "VNOM_PAIS",	
             "VSENHA_FON",	
             "VSTA_CART",	
             "VTEL_COM"	,
             "VTEL_RES"	,
             "VUF_ASSOC",
             "DAT_ATUALIZ"
        into "DALT_AGECC_c",
             "DALT_CICLO_c",
             "DALT_END_c",
             "DALT_FPAGA_c",	
             "DDAT_EMISS_c",	
             "DDAT_LIM_c",
             "DDAT_NASC_c",	
             "DDAT_STA_c",
             "NCEP_ASSOC_c",	
             "NCEP_COMPL_c",	
             "NCGC_CPF_c",
             "NDAT_ABERT_c",	
             "NDAT_VALID_c",	
             "NDIA_CORTE_c",	
             "NDIA_VENCI_c",	
             "N_INSTITUI_c",	
             "NLIM_CARTD_c",	
             "NLIM_CARTR_c",	
             "NLIM_SAQD_c",	
             "NLIM_SAQR_c",	
             "NNUM_AGENC_c",	
             "NNUM_CART_c",	
             "NNUM_CCORR_c",	
             "NSTA_SENHA_c",	
             "NTP_ASSOC_c",	
             "VCART_PROT_c",	
             "VCID_ASSOC_c",	
             "VCOD_BANDE_c",	
             "VDES_INSTI_c",	
             "VDIG_AGENC_c",	
             "VDIG_CCORR_c",	
             "VEND_ASSOC_c",	
             "VKEY_CLI_c",
             "VNOM_ASSOC_c",	
             "VNOM_PAIS_c",	
             "VSENHA_FON_c",	
             "VSTA_CART_c",	
             "VTEL_COM_c",
             "VTEL_RES_c",
             "VUF_ASSOC_c",	
             "DAT_ATUALIZ_c"
        from "TBEDGE_CARTAO"
       where "NNUM_CART22_o" = "NNUM_CART";

       exception
         when others then
           registro_na_origem := false;

       end;

    end if;


    if registro_no_destino and registro_na_origem and transacao_valida then

       update "TBEDGE_CARTAO" 
          set "DALT_AGECC" = decode(substr(column_changed$_varchar2, 1, 1),'N', "DALT_AGECC_c",'Y', "DALT_AGECC1_n"),
              "DALT_CICLO" = decode(substr(column_changed$_varchar2, 2, 1),'N', "DALT_CICLO_c",'Y', "DALT_CICLO2_n"),
              "DALT_END"   = decode(substr(column_changed$_varchar2, 3, 1),'N', "DALT_END_c",'Y', "DALT_END3_n"),
              "DALT_FPAGA" = decode(substr(column_changed$_varchar2, 4, 1),'N', "DALT_FPAGA_c",'Y', "DALT_FPAGA4_n"),
              "DDAT_EMISS" = decode(substr(column_changed$_varchar2, 5, 1),'N', "DDAT_EMISS_c",'Y', "DDAT_EMISS5_n"),
              "DDAT_LIM"   = decode(substr(column_changed$_varchar2, 6, 1),'N', "DDAT_LIM_c",'Y', "DDAT_LIM6_n"),
              "DDAT_NASC"  = decode(substr(column_changed$_varchar2, 7, 1),'N', "DDAT_NASC_c",'Y', "DDAT_NASC7_n"),
              "DDAT_STA"   = decode(substr(column_changed$_varchar2, 8, 1),'N', "DDAT_STA_c",'Y', "DDAT_STA8_n"),
              "NCEP_ASSOC" = decode(substr(column_changed$_varchar2, 9, 1),'N', "NCEP_ASSOC_c",'Y', "NCEP_ASSOC9_n"),
              "NCEP_COMPL" = decode(substr(column_changed$_varchar2, 10, 1),'N', "NCEP_COMPL_c",'Y', "NCEP_COMPL10_n"),
              "NCGC_CPF"   = decode(substr(column_changed$_varchar2, 11, 1),'N', "NCGC_CPF_c",'Y', "NCGC_CPF11_n"),
              "NDAT_ABERT" = decode(substr(column_changed$_varchar2, 12, 1),'N', "NDAT_ABERT_c",'Y', "NDAT_ABERT12_n"),
              "NDAT_VALID" = decode(substr(column_changed$_varchar2, 13, 1),'N', "NDAT_VALID_c",'Y', "NDAT_VALID13_n"),
              "NDIA_CORTE" = decode(substr(column_changed$_varchar2, 14, 1),'N', "NDIA_CORTE_c",'Y', "NDIA_CORTE14_n"),
              "NDIA_VENCI" = decode(substr(column_changed$_varchar2, 15, 1),'N', "NDIA_VENCI_c",'Y', "NDIA_VENCI15_n"),
              "N_INSTITUI" = decode(substr(column_changed$_varchar2, 16, 1),'N', "N_INSTITUI_c",'Y', "N_INSTITUI16_n"),
              "NLIM_CARTD" = decode(substr(column_changed$_varchar2, 17, 1),'N', "NLIM_CARTD_c",'Y', "NLIM_CARTD17_n"),
              "NLIM_CARTR" = decode(substr(column_changed$_varchar2, 18, 1),'N', "NLIM_CARTR_c",'Y', "NLIM_CARTR18_n"),
              "NLIM_SAQD"  = decode(substr(column_changed$_varchar2, 19, 1),'N', "NLIM_SAQD_c",'Y', "NLIM_SAQD19_n"),
              "NLIM_SAQR"  = decode(substr(column_changed$_varchar2, 20, 1),'N', "NLIM_SAQR_c",'Y', "NLIM_SAQR20_n"),
              "NNUM_AGENC" = decode(substr(column_changed$_varchar2, 21, 1),'N', "NNUM_AGENC_c",'Y', "NNUM_AGENC21_n"),
              "NNUM_CART"  = decode(substr(column_changed$_varchar2, 22, 1),'N', "NNUM_CART_c",'Y', "NNUM_CART22_n"),
              "NNUM_CCORR" = decode(substr(column_changed$_varchar2, 23, 1),'N', "NNUM_CCORR_c",'Y', "NNUM_CCORR23_n"),
              "NSTA_SENHA" = decode(substr(column_changed$_varchar2, 24, 1),'N', "NSTA_SENHA_c",'Y', "NSTA_SENHA24_n"),
              "NTP_ASSOC"  = decode(substr(column_changed$_varchar2, 25, 1),'N', "NTP_ASSOC_c",'Y', "NTP_ASSOC25_n"),
              "VCART_PROT" = decode(substr(column_changed$_varchar2, 26, 1),'N', "VCART_PROT_c",'Y', "VCART_PROT26_n"),
              "VCID_ASSOC" = decode(substr(column_changed$_varchar2, 27, 1),'N', "VCID_ASSOC_c",'Y', "VCID_ASSOC27_n"),
              "VCOD_BANDE" = decode(substr(column_changed$_varchar2, 28, 1),'N', "VCOD_BANDE_c",'Y', "VCOD_BANDE28_n"),
              "VDES_INSTI" = decode(substr(column_changed$_varchar2, 29, 1),'N', "VDES_INSTI_c",'Y', "VDES_INSTI29_n"),
              "VDIG_AGENC" = decode(substr(column_changed$_varchar2, 30, 1),'N', "VDIG_AGENC_c",'Y', "VDIG_AGENC30_n"),
              "VDIG_CCORR" = decode(substr(column_changed$_varchar2, 31, 1),'N', "VDIG_CCORR_c",'Y', "VDIG_CCORR31_n"),
              "VEND_ASSOC" = decode(substr(column_changed$_varchar2, 32, 1),'N', "VEND_ASSOC_c",'Y', "VEND_ASSOC32_n"),
              "VKEY_CLI"   = decode(substr(column_changed$_varchar2, 33, 1),'N', "VKEY_CLI_c",'Y', "VKEY_CLI33_n"),
              "VNOM_ASSOC" = decode(substr(column_changed$_varchar2, 34, 1),'N', "VNOM_ASSOC_c",'Y', "VNOM_ASSOC34_n"),
              "VNOM_PAIS"  = decode(substr(column_changed$_varchar2, 35, 1),'N', "VNOM_PAIS_c",'Y', "VNOM_PAIS35_n"),
              "VSENHA_FON" = decode(substr(column_changed$_varchar2, 36, 1),'N', "VSENHA_FON_c",'Y', "VSENHA_FON36_n"),
              "VSTA_CART"  = decode(substr(column_changed$_varchar2, 37, 1),'N', "VSTA_CART_c",'Y', "VSTA_CART37_n"),
              "VTEL_COM"   = decode(substr(column_changed$_varchar2, 38, 1),'N', "VTEL_COM_c",'Y', "VTEL_COM38_n"),
              "VTEL_RES"   = decode(substr(column_changed$_varchar2, 39, 1),'N', "VTEL_RES_c",'Y', "VTEL_RES39_n"),
              "VUF_ASSOC"  = decode(substr(column_changed$_varchar2, 40, 1),'N', "VUF_ASSOC_c",'Y', "VUF_ASSOC40_n")
        where "NNUM_CART22_o" = "NNUM_CART";

     else

       dbms_reputil.rep_end;

       update "TBEDGE_CARTAO" 
          set "DALT_AGECC" = decode(substr(column_changed$_varchar2, 1, 1),'N', "DALT_AGECC_c",'Y', "DALT_AGECC_c"),
              "DALT_CICLO" = decode(substr(column_changed$_varchar2, 2, 1),'N', "DALT_CICLO_c",'Y', "DALT_CICLO_c"),
              "DALT_END"   = decode(substr(column_changed$_varchar2, 3, 1),'N', "DALT_END_c",'Y', "DALT_END_c"),
              "DALT_FPAGA" = decode(substr(column_changed$_varchar2, 4, 1),'N', "DALT_FPAGA_c",'Y', "DALT_FPAGA_c"),
              "DDAT_EMISS" = decode(substr(column_changed$_varchar2, 5, 1),'N', "DDAT_EMISS_c",'Y', "DDAT_EMISS_c"),
              "DDAT_LIM"   = decode(substr(column_changed$_varchar2, 6, 1),'N', "DDAT_LIM_c",'Y', "DDAT_LIM_c"),
              "DDAT_NASC"  = decode(substr(column_changed$_varchar2, 7, 1),'N', "DDAT_NASC_c",'Y', "DDAT_NASC_c"),
              "DDAT_STA"   = decode(substr(column_changed$_varchar2, 8, 1),'N', "DDAT_STA_c",'Y', "DDAT_STA_c"),
              "NCEP_ASSOC" = decode(substr(column_changed$_varchar2, 9, 1),'N', "NCEP_ASSOC_c",'Y', "NCEP_ASSOC_c"),
              "NCEP_COMPL" = decode(substr(column_changed$_varchar2, 10, 1),'N', "NCEP_COMPL_c",'Y', "NCEP_COMPL_c"),
              "NCGC_CPF"   = decode(substr(column_changed$_varchar2, 11, 1),'N', "NCGC_CPF_c",'Y', "NCGC_CPF_c"),
              "NDAT_ABERT" = decode(substr(column_changed$_varchar2, 12, 1),'N', "NDAT_ABERT_c",'Y', "NDAT_ABERT_c"),
              "NDAT_VALID" = decode(substr(column_changed$_varchar2, 13, 1),'N', "NDAT_VALID_c",'Y', "NDAT_VALID_c"),
              "NDIA_CORTE" = decode(substr(column_changed$_varchar2, 14, 1),'N', "NDIA_CORTE_c",'Y', "NDIA_CORTE_c"),
              "NDIA_VENCI" = decode(substr(column_changed$_varchar2, 15, 1),'N', "NDIA_VENCI_c",'Y', "NDIA_VENCI_c"),
              "N_INSTITUI" = decode(substr(column_changed$_varchar2, 16, 1),'N', "N_INSTITUI_c",'Y', "N_INSTITUI_c"),
              "NLIM_CARTD" = decode(substr(column_changed$_varchar2, 17, 1),'N', "NLIM_CARTD_c",'Y', "NLIM_CARTD_c"),
              "NLIM_CARTR" = decode(substr(column_changed$_varchar2, 18, 1),'N', "NLIM_CARTR_c",'Y', "NLIM_CARTR_c"),
              "NLIM_SAQD"  = decode(substr(column_changed$_varchar2, 19, 1),'N', "NLIM_SAQD_c",'Y', "NLIM_SAQD_c"),
              "NLIM_SAQR"  = decode(substr(column_changed$_varchar2, 20, 1),'N', "NLIM_SAQR_c",'Y', "NLIM_SAQR_c"),
              "NNUM_AGENC" = decode(substr(column_changed$_varchar2, 21, 1),'N', "NNUM_AGENC_c",'Y', "NNUM_AGENC_c"),
              "NNUM_CART"  = decode(substr(column_changed$_varchar2, 22, 1),'N', "NNUM_CART_c",'Y', "NNUM_CART_c"),
              "NNUM_CCORR" = decode(substr(column_changed$_varchar2, 23, 1),'N', "NNUM_CCORR_c",'Y', "NNUM_CCORR_c"),
              "NSTA_SENHA" = decode(substr(column_changed$_varchar2, 24, 1),'N', "NSTA_SENHA_c",'Y', "NSTA_SENHA_c"),
              "NTP_ASSOC"  = decode(substr(column_changed$_varchar2, 25, 1),'N', "NTP_ASSOC_c",'Y', "NTP_ASSOC_c"),
              "VCART_PROT" = decode(substr(column_changed$_varchar2, 26, 1),'N', "VCART_PROT_c",'Y', "VCART_PROT_c"),
              "VCID_ASSOC" = decode(substr(column_changed$_varchar2, 27, 1),'N', "VCID_ASSOC_c",'Y', "VCID_ASSOC_c"),
              "VCOD_BANDE" = decode(substr(column_changed$_varchar2, 28, 1),'N', "VCOD_BANDE_c",'Y', "VCOD_BANDE_c"),
              "VDES_INSTI" = decode(substr(column_changed$_varchar2, 29, 1),'N', "VDES_INSTI_c",'Y', "VDES_INSTI_c"),
              "VDIG_AGENC" = decode(substr(column_changed$_varchar2, 30, 1),'N', "VDIG_AGENC_c",'Y', "VDIG_AGENC_c"),
              "VDIG_CCORR" = decode(substr(column_changed$_varchar2, 31, 1),'N', "VDIG_CCORR_c",'Y', "VDIG_CCORR_c"),
              "VEND_ASSOC" = decode(substr(column_changed$_varchar2, 32, 1),'N', "VEND_ASSOC_c",'Y', "VEND_ASSOC_c"),
              "VKEY_CLI"   = decode(substr(column_changed$_varchar2, 33, 1),'N', "VKEY_CLI_c",'Y', "VKEY_CLI_c"),
              "VNOM_ASSOC" = decode(substr(column_changed$_varchar2, 34, 1),'N', "VNOM_ASSOC_c",'Y', "VNOM_ASSOC_c"),
              "VNOM_PAIS"  = decode(substr(column_changed$_varchar2, 35, 1),'N', "VNOM_PAIS_c",'Y', "VNOM_PAIS_c"),
              "VSENHA_FON" = decode(substr(column_changed$_varchar2, 36, 1),'N', "VSENHA_FON_c",'Y', "VSENHA_FON_c"),
              "VSTA_CART"  = decode(substr(column_changed$_varchar2, 37, 1),'N', "VSTA_CART_c",'Y', "VSTA_CART_c"),
              "VTEL_COM"   = decode(substr(column_changed$_varchar2, 38, 1),'N', "VTEL_COM_c",'Y', "VTEL_COM_c"),
              "VTEL_RES"   = decode(substr(column_changed$_varchar2, 39, 1),'N', "VTEL_RES_c",'Y', "VTEL_RES_c"),
              "VUF_ASSOC"  = decode(substr(column_changed$_varchar2, 40, 1),'N', "VUF_ASSOC_c",'Y', "VUF_ASSOC_c")
        where "NNUM_CART22_o" = "NNUM_CART";

     end if;

     if sql%rowcount = 0 then
        raise no_data_found;
     elsif sql%rowcount > 1 then
        raise too_many_rows;
     end if;

     dbms_reputil.rep_end;

  exception
    when no_data_found then

      begin
        if not "TBEDGE_CARTAO$RR".update_conflict_handler(
          "DALT_AGECC1_o",
          "DALT_AGECC_c",
          "DALT_CICLO2_o",
          "DALT_CICLO_c",
          "DALT_END3_o",
          "DALT_END_c",
          "DALT_FPAGA4_o",
          "DALT_FPAGA_c",
          "DDAT_EMISS5_o",
          "DDAT_EMISS_c",
          "DDAT_LIM6_o",
          "DDAT_LIM_c",
          "DDAT_NASC7_o",
          "DDAT_NASC_c",
          "DDAT_STA8_o",
          "DDAT_STA_c",
          "NCEP_ASSOC9_o",
          "NCEP_ASSOC_c",
          "NCEP_COMPL10_o",
          "NCEP_COMPL_c",
          "NCGC_CPF11_o",
          "NCGC_CPF_c",
          "NDAT_ABERT12_o",
          "NDAT_ABERT_c",
          "NDAT_VALID13_o",
          "NDAT_VALID_c",
          "NDIA_CORTE14_o",
          "NDIA_CORTE_c",
          "NDIA_VENCI15_o",
          "NDIA_VENCI_c",
          "N_INSTITUI16_o",
          "N_INSTITUI_c",
          "NLIM_CARTD17_o",
          "NLIM_CARTD_c",
          "NLIM_CARTR18_o",
          "NLIM_CARTR_c",
          "NLIM_SAQD19_o",
          "NLIM_SAQD_c",
          "NLIM_SAQR20_o",
          "NLIM_SAQR_c",
          "NNUM_AGENC21_o",
          "NNUM_AGENC_c",
          "NNUM_CART22_o",
          "NNUM_CART_c",
          "NNUM_CCORR23_o",
          "NNUM_CCORR_c",
          "NSTA_SENHA24_o",
          "NSTA_SENHA_c",
          "NTP_ASSOC25_o",
          "NTP_ASSOC_c",
          "VCART_PROT26_o",
          "VCART_PROT_c",
          "VCID_ASSOC27_o",
          "VCID_ASSOC_c",
          "VCOD_BANDE28_o",
          "VCOD_BANDE_c",
          "VDES_INSTI29_o",
          "VDES_INSTI_c",
          "VDIG_AGENC30_o",
          "VDIG_AGENC_c",
          "VDIG_CCORR31_o",
          "VDIG_CCORR_c",
          "VEND_ASSOC32_o",
          "VEND_ASSOC_c",
          "VKEY_CLI33_o",
          "VKEY_CLI_c",
          "VNOM_ASSOC34_o",
          "VNOM_ASSOC_c",
          "VNOM_PAIS35_o",
          "VNOM_PAIS_c",
          "VSENHA_FON36_o",
          "VSENHA_FON_c",
          "VSTA_CART37_o",
          "VSTA_CART_c",
          "VTEL_COM38_o",
          "VTEL_COM_c",
          "VTEL_RES39_o",
          "VTEL_RES_c",
          "VUF_ASSOC40_o",
          "VUF_ASSOC_c",
          "DAT_ATUALIZ41_o",
          "DAT_ATUALIZ_c",
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
        if not "TBEDGE_CARTAO$RR".unique_conflict_update_handler(
          "DALT_AGECC1_o",
          "DALT_AGECC_c",
          "DALT_CICLO2_o",
          "DALT_CICLO_c",
          "DALT_END3_o",
          "DALT_END_c",
          "DALT_FPAGA4_o",
          "DALT_FPAGA_c",
          "DDAT_EMISS5_o",
          "DDAT_EMISS_c",
          "DDAT_LIM6_o",
          "DDAT_LIM_c",
          "DDAT_NASC7_o",
          "DDAT_NASC_c",
          "DDAT_STA8_o",
          "DDAT_STA_c",
          "NCEP_ASSOC9_o",
          "NCEP_ASSOC_c",
          "NCEP_COMPL10_o",
          "NCEP_COMPL_c",
          "NCGC_CPF11_o",
          "NCGC_CPF_c",
          "NDAT_ABERT12_o",
          "NDAT_ABERT_c",
          "NDAT_VALID13_o",
          "NDAT_VALID_c",
          "NDIA_CORTE14_o",
          "NDIA_CORTE_c",
          "NDIA_VENCI15_o",
          "NDIA_VENCI_c",
          "N_INSTITUI16_o",
          "N_INSTITUI_c",
          "NLIM_CARTD17_o",
          "NLIM_CARTD_c",
          "NLIM_CARTR18_o",
          "NLIM_CARTR_c",
          "NLIM_SAQD19_o",
          "NLIM_SAQD_c",
          "NLIM_SAQR20_o",
          "NLIM_SAQR_c",
          "NNUM_AGENC21_o",
          "NNUM_AGENC_c",
          "NNUM_CART22_o",
          "NNUM_CART_c",
          "NNUM_CCORR23_o",
          "NNUM_CCORR_c",
          "NSTA_SENHA24_o",
          "NSTA_SENHA_c",
          "NTP_ASSOC25_o",
          "NTP_ASSOC_c",
          "VCART_PROT26_o",
          "VCART_PROT_c",
          "VCID_ASSOC27_o",
          "VCID_ASSOC_c",
          "VCOD_BANDE28_o",
          "VCOD_BANDE_c",
          "VDES_INSTI29_o",
          "VDES_INSTI_c",
          "VDIG_AGENC30_o",
          "VDIG_AGENC_c",
          "VDIG_CCORR31_o",
          "VDIG_CCORR_c",
          "VEND_ASSOC32_o",
          "VEND_ASSOC_c",
          "VKEY_CLI33_o",
          "VKEY_CLI_c",
          "VNOM_ASSOC34_o",
          "VNOM_ASSOC_c",
          "VNOM_PAIS35_o",
          "VNOM_PAIS_c",
          "VSENHA_FON36_o",
          "VSENHA_FON_c",
          "VSTA_CART37_o",
          "VSTA_CART_c",
          "VTEL_COM38_o",
          "VTEL_COM_c",
          "VTEL_RES39_o",
          "VTEL_RES_c",
          "VUF_ASSOC40_o",
          "VUF_ASSOC_c",
          site_name,
          propagation_flag,
          column_changed$,
          column_sent$_varchar2,
          null,
          SQLERRM) then

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


end "TBEDGE_CARTAO$RP";
/

