--drop trigger SYS.FC_ATI_TRG_NOSSONUMERO

--CREATE OR REPLACE TRIGGER SYS.FC_ATI_TRG_NOSSONUMERO AFTER LOGON ON DATABASE
 DECLARE
 v_prog sys.v_$session.program%TYPE;
 v_user sys.v_$session.username%TYPE;
 v_osuser sys.v_$session.osuser%TYPE;
 v_machine sys.v_$session.MACHINE%TYPE;
 BEGIN
 SELECT program, username, osuser, machine
 INTO v_prog, v_user, v_osuser, v_machine
 FROM sys.v_$session
 WHERE audsid = USERENV('SESSIONID')
 AND audsid != 0 -- Não verificar conexões SYS
 AND rownum = 1; -- Processos paralelos terá o mesmo do AUDSID
--IF UPPER(v_osuser) IN ('AREIS') or UPPER(v_osuser) like ('F02403')
IF  UPPER(v_machine) LIKE ('%FCESPSQLD002%')
  THEN
IF UPPER(v_prog) LIKE '%TOAD%' OR
 UPPER(v_prog) LIKE '%T.O.A.D%' OR -- Toad
 UPPER(v_prog) LIKE '%SQLNAV%' OR -- SQL Navigator
 UPPER(v_prog) LIKE '%PLSQLDEV%' OR -- PLSQL Developer
 UPPER(v_prog) LIKE '%BUSOBJ%' OR -- Business Objects
 UPPER(v_prog) LIKE '%EXCEL%' OR -- MS-Excel plug-in
 UPPER(v_prog) LIKE '%SQLPLUS%' OR -- SQLPLUS
 UPPER(v_prog) LIKE '%DEVELOPER%' OR -- Oracle SQL Developer
 UPPER(v_prog) LIKE '%IFBLD%' OR -- Oracle Forms Developer Builder
 UPPER(v_prog) LIKE '%RWBUILDER%' OR -- Oracle Reports Builder
 UPPER(v_prog) LIKE '%RAPTOR%' -- Oracle Raptor
 THEN
-- RAISE_APPLICATION_ERROR(-20000, 'Ferramentas de desenvolvimento não são permitidas na PRODUÇÃO!  ('||v_osuser||' - '||v_user||' - '||v_prog||')');
  begin 
   execute immediate  'ALTER INDEX AREIS.IDX_TESTE INVISIBLE';

--    insert into areis.testes values (1,2,3,4);
  end;
   insert into areis.indice_visible values ('I',sysdate());
 END IF;
END IF;
 EXCEPTION
 WHEN NO_DATA_FOUND THEN NULL;
 END;
