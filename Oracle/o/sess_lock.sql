SELECT to_char(s.logon_TIME,'dd/mm/yyyy hh24:mi') LOGON,VLO.SESSION_ID
      ,VLO.ORACLE_USERNAME
      ,VLO.OS_USER_NAME
      ,DECODE(VLO.LOCKED_MODE,'0','NENHUM'
                             ,'1','NULO'
                             ,'2','LINHA'
                             ,'3','LINHA'
                             ,'4','PARTILHA'
                             ,'5','LINHA UNICA'
                             ,'6','EXCLUSIVO')
      ,SUBSTR(AO.OBJECT_NAME,1,20) OBJETO
  FROM V$LOCKED_OBJECT VLO
      ,DBA_OBJECTS AO
      ,v$session s
 WHERE VLO.OBJECT_ID = AO.OBJECT_ID
       and AO.OBJECT_NAME='TBEDGE_GC_FILACAMP'
 ORDER BY 1
/
