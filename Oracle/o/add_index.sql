/*
  script:   add_index.sql
  objetivo: criar um indice
  autor:    Josivan
  data:     

  VER O ARQUIVO INDICE.SQL

*/

validar a estrutura de um index eh validar se os seus blocos nao estao corrompidos.
ver conteudo da tabela INDEX_STATS

analyze index idx_cliente_sub_conta validate structure;

-----------------------------------------------------------------------------------------------

1-reconstruindo um indice.

alter index idx_cliente_sub_cona rebuild;

-----------------------------------------------------------------------------------------------

create  index GLNPS.INDE_RELATED_FRGN
           on GLNPS.INVOICE_DETAILS ( INDE_STTT_ID_NR )
      storage (initial 7782400 next 106496  pctincrease 0)
   tablespace FO4PI01
   PARALLEL( DEGREE 20 )
   NOLOGGING
/

CREATE INDEX IND_AUTORIZACOES
          ON AUTORIZACOES(CD_CODIGO_AUT )
         PCTFREE 10
        INITRANS 2
        MAXTRANS 255
STORAGE( INITIAL 12288
            NEXT 12288
      MINEXTENTS 1
      MAXEXTENTS 249
     PCTINCREASE 0
       FREELISTS 1) 
TABLESPACE TS_SECPRESS;
  
CREATE INDEX IND_CARTA
          ON CARTAS(CD_CARTA_CRT )
        PCTFREE 10
       INITRANS 2
       MAXTRANS 255
STORAGE(INITIAL 81920
           NEXT 36864
     MINEXTENTS 1 
     MAXEXTENTS 249
    PCTINCREASE 0
      FREELISTS 1)
TABLESPACE TS_SECPRESS;
  
CREATE INDEX IND_CONTADOR
             ON CONTADOR (CD_CODIGO_CNT ) 
        PCTFREE 10 INITRANS 2 MAXTRANS 255
STORAGE(INITIAL 12288
           NEXT 12288 
     MINEXTENTS 1
     MAXEXTENTS 249
    PCTINCREASE 0
      FREELISTS 1)
TABLESPACE TS_SECPRESS;
  
CREATE INDEX IND_DESPACHO ON DESPACHO (CD_CARTA_DSP ) 
        PCTFREE 10
       INITRANS 2
       MAXTRANS 255
STORAGE(INITIAL 122880
           NEXT 57344 
     MINEXTENTS 1
     MAXEXTENTS 249
    PCTINCREASE 0
      FREELISTS 1)
TABLESPACE TS_SECPRESS;

create  index SYSRECEI.IND_VOCCNG_1                                             
           on SYSRECEI.VOO_CUPOM_CONG (
              FK_TREVIFK_ORIG_AD_AEROPORTO ,                                    
              FK_TREVIFK_DEST_AD_AEROPORTO ,                                    
              FK_TREVIFK_CD_NAT_VOO ,                                           
              FK_TREVIFK_CD_NUM_VOO ,                                           
              FK_TREVIFK_CD_VER_VOO ,                                           
              FK_TREVIFK_DT_RLZ_VGM ,                                           
              FK_TREVIFK_AD_PESSOA ,                                            
              CD_SEQ_PAX_TRECHO )                                               
      storage (initial 30720000 next 3072000  pctincrease 0)                    
   tablespace TS_REC_INDEX06;                                                   

create  index SYSRECEI.IND_VOOCNG_2                                             
           on SYSRECEI.VOO_CUPOM_CONG (                                         
              FK_CDRVEAFK_CD_RESERVA ,                                          
              FK_CDRVEAFK_AD_PESSOA )                                           
      storage (initial 10240000 next 1024000  pctincrease 0)                    
   tablespace TS_REC_INDEX06;                                                   

create  index SYSRECEI.IND_VOOCNG_3                                             
           on SYSRECEI.VOO_CUPOM_CONG (                                         
              FK_CLASS_CL_ASSENTO )                                             
      storage (initial 10240000 next 1024000  pctincrease 0)                    
   tablespace TS_REC_INDEX03;                                                   

create  index SYSRECEI.IND_VOOCNG_4                                             
           on SYSRECEI.VOO_CUPOM_CONG (                                         
              AD_SEQ_PAX ,                                                      
              CD_SEQ_PAX_TRECHO )                                               
      storage (initial 6963200 next 409600  pctincrease 0)                      
   tablespace TS_REC_INDEX03;                                                   

create UNIQUE index SYSRECEI.PK_VOCCNG                                          
           on SYSRECEI.VOO_CUPOM_CONG (                                         
              FK_CPCNGFK_AD_PESSOA ,                                            
              FK_CPCNGFK_CD_FORMULARIO ,                                        
              FK_CPCNGFK_CD_SERIE ,                                             
              FK_CPCNG_CD_CUPOM ,                                               
              CD_SEQ_TRECHOS )                                                  
      storage (initial 20480000 next 2048000  pctincrease 0)                    
   tablespace TS_REC_INDEX06;                                                   

