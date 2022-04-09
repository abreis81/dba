CREATE OR REPLACE package TAB_CONSULTORES$RR as

  function unique_conflict_insert_handler( "CD_CODIGO1_n"    IN NUMBER,
                                           "NM_NOME2_n"      IN VARCHAR2,
                                           "NM_SOBRENOME3_n" IN VARCHAR2,
                                           "ULT_ATUALIZ4_n"  IN DATE,
                                           "VLR_SAL5_n"      IN NUMBER,
                                           "VLR_UNIT6_n"     IN NUMBER,
                                           site_name         IN VARCHAR2,
                                           propagation_flag  IN CHAR,
                                           errmsg            IN VARCHAR2 ) return boolean;

  function delete_conflict_handler( "CD_CODIGO1_o"         IN NUMBER,
                                    "NM_NOME2_o"           IN VARCHAR2,
                                    "NM_SOBRENOME3_o"      IN VARCHAR2,
                                    "ULT_ATUALIZ4_o"       IN DATE,
                                    "VLR_SAL5_o"           IN NUMBER,
                                    "VLR_UNIT6_o"          IN NUMBER,
                                    site_name              IN VARCHAR2,
                                    propagation_flag       IN CHAR,
                                    column_changed$        IN RAW,
                                    column_sent$_varchar2  IN VARCHAR2 ) return boolean;

  function update_conflict_handler( "CD_CODIGO1_o"            IN NUMBER,
                                    "CD_CODIGO1_n"            IN NUMBER,
                                    "NM_NOME2_o"              IN VARCHAR2,
                                    "NM_NOME2_n"              IN VARCHAR2,
                                    "NM_SOBRENOME3_o"         IN VARCHAR2,
                                    "NM_SOBRENOME3_n"         IN VARCHAR2,
                                    "ULT_ATUALIZ4_o"          IN DATE,
                                    "ULT_ATUALIZ4_n"          IN DATE,
                                    "VLR_SAL5_o"              IN NUMBER,
                                    "VLR_SAL5_n"              IN NUMBER,
                                    "VLR_UNIT6_o"             IN NUMBER,
                                    "VLR_UNIT6_n"             IN NUMBER,
                                    "ST_COLUNA_ALTERADA7_o"   IN VARCHAR2,
                                    "ST_COLUNA_ALTERADA7_n"   IN VARCHAR2,
                                    site_name                 IN VARCHAR2,
                                    propagation_flag          IN CHAR,
                                    column_changed$           IN RAW,
                                    column_sent$_varchar2     IN VARCHAR2,
                                    column_changed$_varchar2  IN VARCHAR2 ) return boolean;

  function unique_conflict_update_handler( "CD_CODIGO1_o"           IN NUMBER,
                                           "CD_CODIGO1_n"           IN NUMBER,
                                           "NM_NOME2_o"             IN VARCHAR2,
                                           "NM_NOME2_n"             IN VARCHAR2,
                                           "NM_SOBRENOME3_o"        IN VARCHAR2,
                                           "NM_SOBRENOME3_n"        IN VARCHAR2,
                                           "ULT_ATUALIZ4_o"         IN DATE,
                                           "ULT_ATUALIZ4_n"         IN DATE,
                                           "VLR_SAL5_o"             IN NUMBER,
                                           "VLR_SAL5_n"             IN NUMBER,
                                           "VLR_UNIT6_o"            IN NUMBER,
                                           "VLR_UNIT6_n"            IN NUMBER,
                                           "ST_COLUNA_ALTERADA7_o"  IN VARCHAR2,
                                           "ST_COLUNA_ALTERADA7_n"  IN VARCHAR2,
                                           site_name                IN VARCHAR2,
                                           propagation_flag         IN CHAR,
                                           column_changed$          IN RAW,
                                           column_sent$_varchar2    IN VARCHAR2,
                                           column_changed$_varchar2 IN VARCHAR2,
                                           errmsg                   IN VARCHAR2 ) return boolean;

end TAB_CONSULTORES$RR;
/




CREATE OR REPLACE package body TAB_CONSULTORES$RR as

  --
  -- conflito de PK
  --
  function unique_conflict_insert_handler( "CD_CODIGO1_n"    IN NUMBER,
                                           "NM_NOME2_n"      IN VARCHAR2,
                                           "NM_SOBRENOME3_n" IN VARCHAR2,
                                           "ULT_ATUALIZ4_n"  IN DATE,
                                           "VLR_SAL5_n"      IN NUMBER,
                                           "VLR_UNIT6_n"     IN NUMBER,
                                           site_name         IN VARCHAR2,
                                           propagation_flag  IN CHAR,
                                           errmsg            IN VARCHAR2 ) return boolean is
  begin

    return FALSE;

  end unique_conflict_insert_handler;


  --
  -- conflito no_data_found
  --
  function delete_conflict_handler( "CD_CODIGO1_o"        IN NUMBER,
                                    "NM_NOME2_o"          IN VARCHAR2,
                                    "NM_SOBRENOME3_o"     IN VARCHAR2,
                                    "ULT_ATUALIZ4_o"      IN DATE,
                                    "VLR_SAL5_o"          IN NUMBER,
                                    "VLR_UNIT6_o"         IN NUMBER,
                                    site_name             IN VARCHAR2,
                                    propagation_flag      IN CHAR,
                                    column_changed$       IN RAW,
                                    column_sent$_varchar2 IN VARCHAR2 ) return boolean is
  begin

    return FALSE;

  end delete_conflict_handler;



  --
  -- conflito de update
  --
  function update_conflict_handler( "CD_CODIGO1_o"           IN NUMBER,
                                    "CD_CODIGO1_n"           IN NUMBER,
                                    "NM_NOME2_o"             IN VARCHAR2,
                                    "NM_NOME2_n"             IN VARCHAR2,
                                    "NM_SOBRENOME3_o"        IN VARCHAR2,
                                    "NM_SOBRENOME3_n"        IN VARCHAR2,
                                    "ULT_ATUALIZ4_o"         IN DATE,
                                    "ULT_ATUALIZ4_n"         IN DATE,
                                    "VLR_SAL5_o"             IN NUMBER,
                                    "VLR_SAL5_n"             IN NUMBER,
                                    "VLR_UNIT6_o"            IN NUMBER,
                                    "VLR_UNIT6_n"            IN NUMBER,
                                    "ST_COLUNA_ALTERADA7_o"  IN VARCHAR2,
                                    "ST_COLUNA_ALTERADA7_n"  IN VARCHAR2,
                                    site_name                IN VARCHAR2,
                                    propagation_flag         IN CHAR,
                                    column_changed$          IN RAW,
                                    column_sent$_varchar2    IN VARCHAR2,
                                    column_changed$_varchar2 IN VARCHAR2 ) return boolean is
  begin

    return FALSE;

  end update_conflict_handler;



  --
  -- conflito de PK 
  --
  function unique_conflict_update_handler( "CD_CODIGO1_o"           IN NUMBER,
                                           "CD_CODIGO1_n"           IN NUMBER,
                                           "NM_NOME2_o"             IN VARCHAR2,
                                           "NM_NOME2_n"             IN VARCHAR2,
                                           "NM_SOBRENOME3_o"        IN VARCHAR2,
                                           "NM_SOBRENOME3_n"        IN VARCHAR2,
                                           "ULT_ATUALIZ4_o"         IN DATE,
                                           "ULT_ATUALIZ4_n"         IN DATE,
                                           "VLR_SAL5_o"             IN NUMBER,
                                           "VLR_SAL5_n"             IN NUMBER,
                                           "VLR_UNIT6_o"            IN NUMBER,
                                           "VLR_UNIT6_n"            IN NUMBER,
                                           "ST_COLUNA_ALTERADA7_o"  IN VARCHAR2,
                                           "ST_COLUNA_ALTERADA7_n"  IN VARCHAR2,
                                           site_name                IN VARCHAR2,
                                           propagation_flag         IN CHAR,
                                           column_changed$          IN RAW,
                                           column_sent$_varchar2    IN VARCHAR2,
                                           column_changed$_varchar2 IN VARCHAR2,
                                           errmsg                   IN VARCHAR2 ) return boolean is
  begin

    return FALSE;

  end unique_conflict_update_handler;


end TAB_CONSULTORES$RR;
/
