CREATE or replace PROCEDURE "JOB_USER"."P_INS_PROCSEL_GRAD" IS
CURSOR c_inscritos IS
         --busca inscrições realizadas nao inseridas
        SELECT codigo, fase || tipo as codini, dtprova, titulo, cod_tipo
          FROM siga.inscritos  
         WHERE cod_tipo not in ('15','17','19')  
           AND dtprova > to_char(sysdate,'yyyymmdd')  
           AND codigo NOT IN (SELECT nvl(precod,0)  
                                FROM siga.veinscricao  
                               WHERE dtexame = to_date(dtprova,'yyyymmdd')  
                              )
           AND TITULO IS NOT NULL;
  
   v_cod      INTEGER;  
   v_codves   INTEGER;  
   v_codini   VARCHAR2(2);  
   v_codtipo  VARCHAR2(2);  
   v_dtprova  VARCHAR2(8);  
   v_idparc   NUMBER;  
   v_status   VARCHAR2(1);  
   v_unidade  VARCHAR2(10);  
   v_predio   VARCHAR2(20);  
   v_sala     VARCHAR2(20); 
   v_sit      VARCHAR2(1);  
  
  
BEGIN  
  
    OPEN  c_inscritos;  
    FETCH c_inscritos INTO v_cod, v_codini, v_dtprova, v_idparc, v_codtipo;  
  
    WHILE c_inscritos%FOUND LOOP  
  
        --busca status do titulo bancário  
        SELECT status_parcela  
          INTO v_status  
          FROM vcr_consulta_titulo  
         WHERE id_parcela = v_idparc  
           AND referencia = v_cod;  
  
        --caso esteja totalmente baixado  
        IF v_status = 'P'  THEN  
        BEGIN  
  
            IF v_codtipo = '14' OR v_codtipo = '21' THEN -- verifica se é pedagogia
                SELECT SIGA.SEQ_VEINSCRICAO_COD_PED.NEXTVAL
                   INTO v_codves
                   FROM DUAL;
                v_predio := '0';
                v_sala   := '0';
                v_sit    := 'A';
            ELSE
                v_sit := 'I';
                --busca próximo codigo para fase e tipo de inscrição do candidato  
                SELECT nvl(MAX(codigo), v_codini || '0000')  
                  INTO v_codves  
                  FROM siga.veinscricao  
                 WHERE dtexame = to_date(v_dtprova,'yyyymmdd')  
                   AND codigo BETWEEN v_codini || '0000' and v_codini || '9999'  
                   AND cod_tipo NOT IN ('15','17','19');  
  
                v_codves := v_codves + 1;  
  
                --busca próxima sala disponível para unidade da opção do candidato  
                SELECT nvl(unidade,0) as unidade, nvl(predio,'0') as predio, nvl(sala,'0') as sala  
                  INTO v_unidade, v_predio, v_sala  
                  FROM (SELECT salas_web.unidade,  
                               nvl(salas_web.predio,'0') AS predio,  
                               nvl(salas_web.sala,'0') AS sala  
                          FROM siga.inscritos,  
                               siga.salas_web  
                         WHERE inscritos.dtprova =   salas_web.dtprova (+)  
                           AND unidade (+) = CASE substr(curso1,1,1)  
                                               WHEN '3' THEN '11'  
                                               WHEN '9' THEN '9'  
                                               WHEN '4' THEN '4'  
                                             END  
                           AND inscritos.codigo = v_cod  
                           AND ncandidatos (+) <= capacidade (+)  
                        ORDER BY predio, salas_web.sala  
                        )tmp  
                WHERE ROWNUM = 1; 

                --atualiza utilização da sala  
                update siga.salas_web  
                   set ncandidatos = ncandidatos + 1  
                 where dtprova = v_dtprova  
                   and unidade =  v_unidade  
                   and predio =  v_predio  
                   and sala = v_sala;                

            END IF; -- else - verifica se é pedagogia
            
            dbms_output.put_line(v_codtipo||' '||v_cod||' '||v_codves ||' '||v_predio||' '||v_sala || ' ' || v_status);  
           
            --insere registro na veinscricao  
            INSERT INTO siga.veinscricao  
            SELECT to_char(v_codves), to_char(v_codves), v_predio, v_sala, NULL, nome, v_sit, logradouro, bairro, cidade, estado,  
                   substr(ltrim(rtrim(cep)),1,8), telres, telcom, ramal, substr(sexo,1,1), ' ', to_date(data,'yyyymmdd'),  
                   to_date(dtprova,'yyyymmdd'),  
                   to_date(replace(nasc,' ','0'),'yyyymmdd'), ' ', ' ', ' ', ' ', ' ',  
                   ' ', rg, d_rg, emissor, estadodoc, cpf, escola, 0, loc_prova, 0, 0, 0, 0, 0, 0, 0, 0,  
                   ltrim(rtrim(curso1)), ltrim(rtrim(curso2)), ltrim(rtrim(curso3)), ' ', ' ', ' ', NULL, email, 'N', 'N',  
                   ano_conc, endereco, numero, complemento, 'sistema', codigo, esc_conc, tipo_conc, conheceu, out_vest,  
                   esp_fis, substr(empresa,1,50) as empresa, convenio, NULL, NULL, 'C', titulo, codigo, cod_tipo, 'N', dddcel || telcel  
              FROM siga.inscritos  
             WHERE codigo = v_cod
               AND cod_tipo = v_codtipo;
            
            COMMIT;  
  
        END;  
        END IF;  
  
        FETCH c_inscritos INTO v_cod, v_codini, v_dtprova, v_idparc, v_codtipo;  
  
    END LOOP;  
  
CLOSE c_inscritos;  
  
END;
/