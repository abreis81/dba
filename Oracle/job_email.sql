

------ CRIAR OS OBJETOS NO BANCO

@?/rdbms/admin/utlmail.sql
@?/rdbms/admin/prvtmail.plb

----- ATRIBUIR IP PARA ENVIAR EMAIL

alter system set smtp_out_server='10.190.35.92:25' scope=both SID='*';


------- CRIAÇÃO DO USUÁRIO

Create user sys_cron_apaga identified by xxx;

GRANT CREATE PROCEDURE TO SYS_cRON_APAGA;
grant DROP ANY INDEX to SYS_cRON_APAGA;
grant DROP ANY INDEXTYPE to SYS_cRON_APAGA;
grant DROP ANY PROCEDURE to SYS_cRON_APAGA;
grant DROP ANY SEQUENCE to SYS_cRON_APAGA;
grant DROP ANY SYNONYM to SYS_cRON_APAGA;
grant DROP ANY TABLE to SYS_cRON_APAGA;
grant DROP ANY TRIGGER to SYS_cRON_APAGA;
grant DROP ANY TYPE to SYS_cRON_APAGA;
grant DROP ANY VIEW to SYS_cRON_APAGA;
grant create session to SYS_cRON_APAGA;

----- CRIAR REGRAS DE ENVIO DE EMAIL

begin
   dbms_network_acl_admin.create_acl (
        acl => 'grant_acl.xml',
        description => 'Permite enviar e-mail e usar outras packages',
        principal => 'SYS_CRON_APAGA', -- observe que o nome do usuário deve estar sempre em UPPERCASE 
        is_grant => TRUE,
        privilege => 'connect'  -- este privilégio concedido é que permite que o usuário envie email através do servidor que será especificado no próximo bloco que chama a SP "assign_acl"
        );
  commit;
end; 
/


begin
   dbms_network_acl_admin.create_acl (
        acl => 'grant_acl.xml',
        description => 'Permite enviar e-mail e usar outras packages',
        principal => 'SYS_CRON_APAGA', 
        is_grant => TRUE,
        privilege => 'connect' 
        );
  commit;
end; 
/


begin 
   dbms_network_acl_admin.assign_acl( 
        acl => 'grant_acl.xml',
        host => '10.190.35.92'  -- preencha aqui o nome do host do servidor SMTP
        );
   commit;
end; 
 /
 

----- CRIAR DIRETÓRIO PARA GRAVAR OS LOGS

CREATE DIRECTORY SCRIPTS AS '/home/oracle/scripts'


------ PROCEDURE QUE PEGA A SAIDA DO DBMS_OUTPUT E GERA ARQUIVO

CREATE OR REPLACE PROCEDURE dba_chklist.write_log (nlog varchar2 )AS
         l_line VARCHAR2(255);
         l_done NUMBER;
         l_file utl_file.file_type;
      BEGIN
         l_file := utl_file.fopen('SCRIPTS', nlog, 'W');
         LOOP
            EXIT WHEN l_done = 1;
            dbms_output.get_line(l_line, l_done);
            utl_file.put_line(l_file, l_line);
         END LOOP;
         utl_file.fflush(l_file);
         utl_file.fclose(l_file);
     END write_log;


grant execute on dba_chklist.write_log to SYS_CRON_APAGA;


########################################################################################################################################
------- PROCEDURE DE SELECT PARA ENVIO NO QUARTA

CREATE OR REPLACE PROCEDURE SYS_CRON_APAGA.PRE_APAGA_HOME
IS
 n number :=0;
 fHandle utl_file.file_type; 

 vTextOut varchar2(32000); 
 text varchar2(32000) := NULL;

 arquivo varchar2(50):='pre_apaga_home.log'; 
 titulo varchar2(50):= 'Objetos a serem apagados';
 
begin

         dbms_output.enable(100000);
         -- write something to DBMS_OUTPUT
         -- write the content of the buffer to a file

    DBMS_OUTPUT.put_line (' Rotina de limpeza rodará no domingo apagando todos os objetos listados.');
    DBMS_OUTPUT.put_line ('************************************************************************');
    FOR cur_rec IN 
     (SELECT object_name, object_type,  owner
                    FROM   dba_objects
                    where owner LIKE 'F0%'
                    AND OBJECT_TYPE NOT IN ('INDEX','PACKAGE BODY','TRIGGER','DATABASE LINK','LOB')
                    AND created < sysdate-3
                    order by  OWNER, OBJECT_TYPE
                   ) LOOP
      BEGIN
        
        DBMS_OUTPUT.put_line('Objeto: '||lower(cur_rec.object_type) || ' ' ||cur_rec.owner||'.'|| cur_rec.object_name);
      EXCEPTION
        WHEN OTHERS THEN
           DBMS_OUTPUT.put_line('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
      END;
    END LOOP;
    --- gera arquivo com a saida do dbms_output
   dba_chklist.write_log(arquivo);

    --- le o arquivo com a saida do dbms_output
   fHandle := UTL_FILE.FOPEN('SCRIPTS',arquivo,'r');

   IF UTL_FILE.IS_OPEN(fHandle) THEN
     DBMS_OUTPUT.PUT_LINE('File read open');
   ELSE
     DBMS_OUTPUT.PUT_LINE('File read not open');
   END IF;
  
   -- gera o texto do email com a leitura do arquivo aberto
   loop
     begin
     UTL_FILE.GET_LINE(fHandle,vTextOut);
   IF text IS NULL THEN
    text := text || UTL_TCP.CRLF || '************************************************************************';
    text := text || UTL_TCP.CRLF || vTextOut;
   ELSE
    text := text || UTL_TCP.CRLF || vTextOut;
   END IF;

     EXCEPTION
       WHEN NO_DATA_FOUND THEN EXIT;
     end;
   END LOOP;     

   --fechar o arquivo
   UTL_FILE.FCLOSE(fHandle);

-- envia email  
UTL_MAIL.SEND
 (
    SENDER => 'producao@oracle.com', -- remetente da mensagem
    RECIPIENTS => 'adriano.gabriel@funcesp.com.br',  -- destinatário da mensagem
    CC => 'desenvprevidencia@funcesp.com.br,desenvsaude@funcesp.com.br,desenvPortalCRM@funcesp.com.br,desenvbackoffice@funcesp.com.br',  -- destinatário copiado na mensagem
    BCC => 'dba@funcesp.com.br',  -- destinatário com cópia oculta da  mensagem
    SUBJECT =>  titulo ||' - PROD', -- assunto da mensagem
    MESSAGE =>  text, -- mensagem do e-mail
    MIME_TYPE => 'text/plain; charset=iso-8859-1' -- mime type + character set do texto da mensagem
 );


  EXCEPTION
     WHEN OTHERS THEN
     --  dbms_output.put_line('Fehler');
    raise_application_error(-20001,'The following error has occured: ' || sqlerrm);   
   END;

########################################################################################################################################

------------- PROCEDURE PARA APAGAR OS OBJETOS

CREATE OR REPLACE PROCEDURE SYS_CRON_APAGA.APAGA_HOME
AUTHID CURRENT_USER 
IS
 n number :=0;
 fHandle utl_file.file_type; 
 l_cascade  VARCHAR2(20);
 vTextOut varchar2(32000); 
 text varchar2(32000) := NULL;
 arquivo varchar2(50):='apaga_home.log'; 
 titulo varchar2(50):= 'Objetos apagados';
 
begin

        dbms_output.enable(100000);
         -- write something to DBMS_OUTPUT
         -- write the content of the buffer to a file

    DBMS_OUTPUT.put_line ('**************** Objetos apagados na rotina semanal ********************');
    DBMS_OUTPUT.put_line ('************************************************************************');
  FOR cur_rec IN 
     (SELECT object_name, object_type,  owner
                    FROM   dba_objects
                    where owner LIKE 'F02403%'
                    AND OBJECT_TYPE NOT IN ('INDEX','PACKAGE BODY','TRIGGER','DATABASE LINK','LOB')
                    AND created < sysdate-7
                    order by  OWNER, OBJECT_TYPE
                   ) LOOP
      BEGIN
        l_cascade := NULL;
        IF cur_rec.object_type = 'TABLE' THEN 
          l_cascade := ' CASCADE CONSTRAINTS';
        END IF;
     
       EXECUTE IMMEDIATE ('DROP ' || cur_rec.object_type || ' ' ||cur_rec.owner||'.'|| cur_rec.object_name || ' ' || l_cascade);
        DBMS_OUTPUT.put_line('Apagado: '||lower(cur_rec.object_type) || ' ' ||cur_rec.owner||'.'|| cur_rec.object_name);
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.put_line('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
--          NULL;
      END;
    END LOOP;
    EXECUTE IMMEDIATE 'PURGE RECYCLEBIN';
   --- gera arquivo com a saida do dbms_output 
   dba_chklist.write_log(arquivo);

    --- le o arquivo com a saida do dbms_output
   fHandle := UTL_FILE.FOPEN('SCRIPTS',arquivo,'r');

   IF UTL_FILE.IS_OPEN(fHandle) THEN
     DBMS_OUTPUT.PUT_LINE('File read open');
   ELSE
     DBMS_OUTPUT.PUT_LINE('File read not open');
   END IF;
  
 -- gera o texto do email com a leitura do arquivo aberto
   loop
     begin
     UTL_FILE.GET_LINE(fHandle,vTextOut);
   IF text IS NULL THEN
    text := text || UTL_TCP.CRLF || '************************************************************************';
    text := text || UTL_TCP.CRLF || vTextOut;
   ELSE
    text := text || UTL_TCP.CRLF || vTextOut;
   END IF;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN EXIT;
     end;
   END LOOP;     

   --fechar o arquivo
   UTL_FILE.FCLOSE(fHandle);

-- envia email   
UTL_MAIL.SEND
 (
    SENDER => 'producao@oracle.com', -- remetente da mensagem
    RECIPIENTS => 'adriano.gabriel@funcesp.com.br',  -- destinatário da mensagem
    CC => 'desenvprevidencia@funcesp.com.br,desenvsaude@funcesp.com.br,desenvPortalCRM@funcesp.com.br,desenvbackoffice@funcesp.com.br',  -- destinatário copiado na mensagem
    BCC => 'dba@funcesp.com.br',  -- destinatário com cópia oculta da  mensagem
    SUBJECT =>  titulo ||' - PROD', -- assunto da mensagem
    MESSAGE =>  text, -- mensagem do e-mail
    MIME_TYPE => 'text/plain; charset=iso-8859-1' -- mime type + character set do texto da mensagem
 );


  EXCEPTION
     WHEN OTHERS THEN
     --  dbms_output.put_line('Fehler');
    raise_application_error(-20001,'The following error has occured: ' || sqlerrm);   
   END;

########################################################################################################################################

------------ JOB DE EXECUÇÃO


declare
      numero_job   NUMBER;
BEGIN
      sys.DBMS_JOB.SUBMIT(job  => numero_job,
                      what => 'PRE_APAGA_HOME;',
                      next_date => 'NEXT_DAY(TRUNC(SYSDATE ), "WEDNESDAY" ) + 09/24',
                      interval  => 'SYSDATE+7');
      COMMIT;
END;
/

DECLARE
      numero_job   NUMBER;
BEGIN
      DBMS_JOB.SUBMIT(job  => numero_job,
                      what => 'APAGA_HOME;',
                      next_date => 'NEXT_DAY(TRUNC(SYSDATE+7 ), "SUNDAY" ) + 09/24',
                      interval  => 'SYSDATE+7');
      COMMIT;
END;
/
