CREATE OR REPLACE PROCEDURE CAL_TABLE( p_owner       CHAR   DEFAULT '%'
                                      ,p_nm_tabela   CHAR   DEFAULT '%'
                                      ,p_nr_linhas   NUMBER DEFAULT 1
                                      ,p_bytes_long  NUMBER DEFAULT 512 ) IS
--
-- Determina espaco estimado para criar tabelas/indices.
--
-- Parametros Entrada:
-- p_owner       - nome do Owner. Default '%' (todos owners).
-- p_nm_tabela   - nome da tabela. Default '%' (todas tabelas).
-- p_nr_linhas   - numero de linhas para efeito de calculo. Default 1 linha.
-- p_bytes_long  - tamanho em bytes que uma coluna LONG/LONG RAW ocupa.
--                 Default 512 bytes.

--
--  Definicao de Cursores
--
CURSOR c1 IS
  SELECT owner
        ,table_name
        ,ini_trans
        ,pct_free
    FROM dba_tables
   WHERE owner like upper(p_owner)
     AND table_name like upper(p_nm_tabela)
     AND cluster_name IS NULL;

CURSOR c2( pc_owner CHAR
          ,pc_table CHAR ) IS
  SELECT data_type
        ,data_length
        ,data_precision
    FROM dba_tab_columns
   WHERE owner      = pc_owner
     AND table_name = pc_table;

CURSOR c3( pc_owner CHAR
          ,pc_table CHAR ) IS
  SELECT owner
        ,index_name
        ,ini_trans
        ,pct_free
    FROM dba_indexes
   WHERE owner      like upper(pc_owner)
     AND table_name like upper(pc_table);

CURSOR c4(pc_owner CHAR, pc_index CHAR) IS
  SELECT b.data_type
        ,b.data_length
        ,b.data_precision
    FROM dba_ind_columns a
        ,dba_tab_columns b
   WHERE a.index_owner = pc_owner
     AND a.index_name  = pc_index
     AND b.owner       = a.table_owner
     AND b.table_name  = a.table_name
     AND b.column_name = a.column_name;
--
--  Definicao de Variaveis
--
vp_nr_linhas                        NUMBER;
vp_bytes_long                       NUMBER;
v_db_block_size				NUMBER;
v_size                              NUMBER;
v_rowsize1                          NUMBER;
v_rowsize2                          NUMBER;
v_tot_size                          NUMBER;
v_hsize                             NUMBER;
v_availspace                        NUMBER;
v_rowspace                          NUMBER;
v_bytes_need                        NUMBER(18);

--
--  Definicao de Funcoes
--
FUNCTION le_v$type_size(p_type v$type_size.type%TYPE)	RETURN NUMBER IS

v_component           v$type_size.component%TYPE;
v_type                v$type_size.type%TYPE;
v_description         v$type_size.description%TYPE;
v_size                NUMBER;

BEGIN

  BEGIN
    SELECT *
      INTO v_component, v_type, v_description, v_size
      FROM v$type_size
     WHERE type = upper(p_type);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_size := -1;
    WHEN OTHERS THEN
      raise_application_error(-20001,'Problemas lendo view V$TYPE_SIZE');
  END;

  RETURN v_size;

END le_v$type_size;

--
-- Colunas
--
FUNCTION size_column( p_table_name       dba_tables.table_name%TYPE
                     ,p_data_type        dba_tab_columns.data_type%TYPE
                     ,p_data_length      dba_tab_columns.data_length%TYPE
                     ,p_data_precision   dba_tab_columns.data_precision%TYPE ) RETURN NUMBER IS

v_size    NUMBER;

BEGIN

  IF p_data_type = 'CHAR' THEN
     v_size := p_data_length;
  ELSIF p_data_type = 'VARCHAR2' THEN
     v_size := p_data_length;
  ELSIF p_data_type = 'NUMBER' THEN

     IF p_data_precision IS NULL THEN
        v_size := p_data_length;
     ELSE
        v_size := FLOOR(p_data_precision/2) + 3;
     END IF;

  ELSIF p_data_type = 'DATE' THEN
     v_size := p_data_length;
  ELSIF p_data_type = 'LONG'	THEN
     v_size := vp_bytes_long;
  ELSIF p_data_type = 'RAW' THEN
     v_size := p_data_length;
  ELSIF p_data_type = 'LONG RAW' THEN
     v_size := vp_bytes_long;
  ELSIF p_data_type = 'ROWID'	THEN
     v_size := p_data_length;
  ELSIF p_data_type = 'MLSLABEL' THEN
     v_size := p_data_length;
  ELSIF p_data_type = 'UNDEFINED' THEN
     v_size := 0;
  ELSE
     raise_application_error(-20001,'Invalid datatype '||p_data_type||' in table '||p_table_name);
  END IF;

  IF v_size < 250 THEN
     v_size := v_size + 1;
  ELSE
     v_size := v_size + 3;
  END IF;

  RETURN v_size;

END size_column;

--
-- Objeto
--
PROCEDURE insert_calcula_size( p_owner           calcula_size.nm_owner%TYPE
                              ,p_type            calcula_size.tp_objeto%TYPE
                              ,p_objeto          calcula_size.nm_objeto%TYPE
                              ,p_nr_linhas       calcula_size.nr_linhas%TYPE
                              ,p_bytes           calcula_size.qt_bytes%TYPE ) IS
BEGIN

  INSERT INTO calcula_size VALUES(p_owner, p_type, p_objeto, p_nr_linhas, p_bytes);

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE calcula_size
       SET nr_linhas = p_nr_linhas
          ,qt_bytes  = p_bytes
     WHERE nm_owner  = p_owner
       AND tp_objeto = p_type
       AND nm_objeto = p_objeto;
  WHEN OTHERS THEN
    raise_application_error(-20001,sqlerrm);
END insert_calcula_size;

/*---------*/
/* MAIN    */
/*---------*/
BEGIN

  IF p_nr_linhas IS NULL OR p_nr_linhas < 1 THEN
     vp_nr_linhas := 1;
  ELSE
     vp_nr_linhas := p_nr_linhas;
  END IF;

  IF p_bytes_long IS NULL OR p_bytes_long < 1 THEN
     vp_bytes_long := 1;
  ELSE
     vp_bytes_long := p_bytes_long;
  END IF;

  --
  --  Seleciona variaveis
  --
  BEGIN
    SELECT to_number(value)
      INTO v_db_block_size
      FROM v$parameter
     WHERE name = 'db_block_size';
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(-20001,'Problemas lendo view V$PARAMETER');
  END;

  --
  -- Consome Cursor Tabela
  --
  FOR v1 IN c1 LOOP

      --
      --  Calcula Data Block Header
      --
      v_hsize := v_db_block_size - le_v$type_size('KCBH')  -
                                   le_v$type_size('UB4')   - 
                                   le_v$type_size('KTBBH') - (v1.ini_trans - 1) * 
                                   le_v$type_size('KTBIT') -
                                   le_v$type_size('KDBH');
      --
      -- Calcula Available Data Space
      --
      v_size := le_v$type_size('KDBT');
      IF v_size < 0 THEN
         v_size := le_v$type_size('UB4');
      END IF;

      v_availspace := CEIL(v_hsize * (1 - v1.pct_free / 100)) - v_size;

      --
      --  Consome Cursor Column Table / Calcula Space Used per Row
      --
      v_tot_size := 0;
      --
      FOR v2 IN c2(v1.owner, v1.table_name) LOOP
          v_tot_size := v_tot_size + size_column( v1.table_name
                                                 ,v2.data_type
                                                 ,v2.data_length
                                                 ,v2.data_precision );
      END LOOP;

      v_rowsize1 := le_v$type_size('UB1') * 3 +
                    le_v$type_size('UB4')     +
                    le_v$type_size('SB2');

      v_rowsize2 := le_v$type_size('UB1') * 3 + v_tot_size;

      IF v_rowsize1 > v_rowsize2 THEN
         v_rowspace := v_rowsize1;
      ELSE
         v_rowspace := v_rowsize2;
      END IF;

      v_rowspace := v_rowspace + le_v$type_size('SB2');

      --
      -- Calcula Number of Bytes Need - addicional 20 percent for rows
      --
      IF FLOOR(v_availspace / v_rowspace) = 0 THEN
         v_bytes_need := 1.2 * vp_nr_linhas * v_rowspace;
      ELSE
         v_bytes_need := 1.2 * vp_nr_linhas * (v_db_block_size / (v_availspace / v_rowspace));
      END IF;

      --
      --  Insert Record in Table CALCULA_SIZE
      --
      insert_calcula_size( v1.owner
                          ,'TABLE'
                          ,v1.table_name
                          ,vp_nr_linhas
                          ,v_bytes_need );

      --
      --  Consome Cursor Indexes
      --
      FOR v3 IN  c3(v1.owner, v1.table_name) LOOP
          --
          --  Calcula Block Header Size
          --
          v_hsize := 113 + 24 * v3.ini_trans;

          --
          -- Calcula Available Data Space
          --
          v_availspace := (v_db_block_size - v_hsize) * (1 - v3.pct_free/100);

          --
          --  Consome Cursor Index Column / Calcula Space Used per Index Row
          --
          v_tot_size := 0;
          --
          FOR v4 IN c4(v3.owner, v3.index_name) LOOP
              v_tot_size := v_tot_size + size_column( v1.table_name
                                                     ,v4.data_type
                                                     ,v4.data_length
                                                     ,v4.data_precision );
          END LOOP;

          v_rowsize1 := le_v$type_size('UB1') * 3 +
                        le_v$type_size('UB4')     +
                        le_v$type_size('SB2');

          v_rowsize2 := le_v$type_size('UB1') * 3 + v_tot_size;
          IF v_rowsize1 > v_rowsize2 THEN
             v_rowspace := v_rowsize1;
          ELSE
             v_rowspace := v_rowsize2;
          END IF;
          --
          v_rowspace := v_rowspace + 8;  -- entry head 2 bytes +

          -- rowid length 6 bytes
          --
          -- Calcula Number of Bytes Need - addicional 20 percent for rows
          --
          IF FLOOR(v_availspace / v_rowspace) = 0 THEN
             v_bytes_need := 1.2 * vp_nr_linhas * v_rowspace;
          ELSE
             v_bytes_need := 1.2 * vp_nr_linhas * (v_db_block_size / (v_availspace / v_rowspace));
          END IF;

          --
          --  Insert Record in Table CALCULA_SIZE
          --
          insert_calcula_size( v1.owner
                              ,'INDEX'
                              ,v3.index_name
                              ,vp_nr_linhas
                              ,v_bytes_need );
      END LOOP;

      COMMIT WORK;

  END LOOP;

END CAL_TABLE;
/
show errors
