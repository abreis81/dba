CREATE OR REPLACE VIEW "SEU"."SEUAEI" (
saei_idempresa                          
,saei_IDFILIAL                           
,saei_IDCHEQUE                           
,saei_BANCO                              
,saei_AGENCIA                            
,saei_CCORRENTE                          
,saei_SERIE                              
,saei_NUM_CHEQUE                         
,saei_VALOR                              
,saei_DT_VCTO                            
,saei_COD_STATUS_CHEQUE                  
,saei_DESC_STATUS_CHEQUE                 
,saei_DT_DEPOSITO                        
,saei_DT_DEVOL                           
,saei_COD_ALINEA_DEVOL                   
,saei_DT_REAPRE                  
,saei_DT_DEVOL_REAPRE            
,saei_COD_ALINEA_DEVOL_REAPRE       
,saei_DT_PERDA                           
,saei_DT_CANCEL_DEPOSITO                 
,saei_DT_CANCEL_DEVOL                    
,saei_DT_CANCEL_REAPRE           
,saei_DT_CANCEL_DEVOL_REAPRE    
,saei_DT_CANCEL_PERDA                    
,saei_NOME_EMITENTE                      
,saei_CGC_CPF_EMITENTE                   
,saei_TEL_EMITENTE                       
,saei_ID_CC_DEPOSITO                     
,saei_APELIDO_RESP_CC_DEPOSITO           
,saei_NUM_BACEN_CC_DEPOSITO              
,saei_NUM_AGENCIA_CC_DEPOSITO            
,saei_NUM_CC_DEPOSITO                    
,saei_ID_PESSOA_CLIENTE                  
,saei_NUMRA                              
,saei_NOME_PESSOA_CLIENTE                
,saei_CGC_CPF_CLIENTE                    
,saei_CGC_CPF_CLIENTE_FORMATADO          
,saei_REFERENCIA_CLIENTE                 
,saei_IDTIT                              
,saei_STATUS_TIT                         
,saei_DT_EMISSAO_TIT                     
,saei_DT_SOLIC                           
,saei_NUM_DOCUMENTO_NAO_FISCAL           
,saei_DT_ULT_OPERACAO )                   
as
select distinct saam_idempresa                 as saei_idempresa
      ,ID_FILIAL                      as saei_IDFILIAL                     
      ,ID_CHEQUE                      as saei_IDCHEQUE                     
      ,BANCO                          as saei_BANCO                         
      ,AGENCIA                        as saei_AGENCIA                       
      ,CCORRENTE                      as saei_CCORRENTE                     
      ,SERIE                          as saei_SERIE                         
      ,NUM_CHEQUE                     as saei_NUM_CHEQUE                    
      ,VALOR                          as saei_VALOR                         
      ,DT_VCTO                        as saei_DT_VCTO                       
      ,COD_STATUS_CHEQUE              as saei_COD_STATUS_CHEQUE             
      ,DESC_STATUS_CHEQUE             as saei_DESC_STATUS_CHEQUE            
      ,DT_DEPOSITO                    as saei_DT_DEPOSITO                   
      ,DT_DEVOL                       as saei_DT_DEVOL                      
      ,COD_ALINEA_DEVOL               as saei_COD_ALINEA_DEVOL              
      ,DT_REAPRESENTACAO              as saei_DT_REAPRE             
      ,DT_DEVOL_REAPRESENTACAO        as saei_DT_DEVOL_REAPRE       
      ,COD_ALINEA_DEVOL_REAPRESENT    as saei_COD_ALINEA_DEVOL_REAPRE  
      ,DT_PERDA                       as saei_DT_PERDA                      
      ,DT_CANCEL_DEPOSITO             as saei_DT_CANCEL_DEPOSITO            
      ,DT_CANCEL_DEVOL                as saei_DT_CANCEL_DEVOL               
      ,DT_CANCEL_REAPRESENTACAO       as saei_DT_CANCEL_REAPRE     
      ,DT_CANCEL_DEVOL_REAPRESENTACAO as saei_DT_CANCEL_DEVOL_REAPRE
      ,DT_CANCEL_PERDA                as saei_DT_CANCEL_PERDA               
      ,NOME_EMITENTE                  as saei_NOME_EMITENTE                     
      ,CGC_CPF_EMITENTE               as saei_CGC_CPF_EMITENTE                  
      ,TEL_EMITENTE                   as saei_TEL_EMITENTE                      
      ,ID_CC_DEPOSITO                 as saei_ID_CC_DEPOSITO                    
      ,APELIDO_RESP_CC_DEPOSITO       as saei_APELIDO_RESP_CC_DEPOSITO          
      ,NUM_BACEN_CC_DEPOSITO          as saei_NUM_BACEN_CC_DEPOSITO             
      ,NUM_AGENCIA_CC_DEPOSITO        as saei_NUM_AGENCIA_CC_DEPOSITO           
      ,NUM_CC_DEPOSITO                as saei_NUM_CC_DEPOSITO                   
      ,ID_PESSOA_CLIENTE              as saei_ID_PESSOA_CLIENTE                 
      ,NUMRA                          as saei_NUMRA                             
      ,NOME_PESSOA_CLIENTE            as saei_NOME_PESSOA_CLIENTE               
      ,CGC_CPF_CLIENTE                as saei_CGC_CPF_CLIENTE                   
      ,CGC_CPF_CLIENTE_FORMATADO      as saei_CGC_CPF_CLIENTE_FORMATADO         
      ,REFERENCIA_CLIENTE             as saei_REFERENCIA_CLIENTE                
      ,ID_TIT                         as saei_IDTIT                            
      ,STATUS_TIT                     as saei_STATUS_TIT                        
      ,DT_EMISSAO_TIT                 as saei_DT_EMISSAO_TIT                    
      ,DT_SOLIC                       as saei_DT_SOLIC                          
      ,NUM_DOCUMENTO_NAO_FISCAL       as saei_NUM_DOCUMENTO_NAO_FISCAL          
      ,DT_ULT_OPERACAO                as saei_DT_ULT_OPERACAO 
from seu.seuaam a, seu.vcr_cheques_receb b
where a.SAAM_FILERP=b.id_filial;
         
                                          
                                          
                                          
                                          
                                          