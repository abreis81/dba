CREATE OR REPLACE procedure Prc_Exibe_Informacoes_Sessao( P_Pid    in    number
                                                         ,P_Opcao  in    number) as
--    Exibe informações da Sessão Oracle através de Dbms_Output
--    Ligar o set serverouput on para execução, conforme abaixo :
--  	        set serveroutput on size 1000000
--            set feedback off
--
--    Parâmetros de Entrada :
--       PID obtido através da instrução TOP
--       Opcao : 1 = Informações gerais sobre a sessão   (Não exibe o comando SQL)
--               2 = Todas as informações sobre a sessão (Exibe o comando   SQL atual)
--               3 = Exibe apenas o comando SQL anterior
--
--    Procedure de execução para a role rl_Br_Suporte
--
--
v_Sid           V$Session.Sid%type;
v_Serial#       V$Session.Serial#%type;
v_Username      V$Session.Username%type;
v_Status        V$Session.Status%type;
v_Machine       V$Session.Machine%type;
v_Terminal      V$Session.Terminal%type;
v_Program       V$Session.Program%type;
v_OsUser        V$Session.OsUser%type;
v_Schemaname    V$Session.Schemaname%type;
v_Sql_Address   V$Session.Sql_Address%type;
v_Prev_Sql_Addr V$Session.Prev_Sql_Addr%type;
v_Address       V$SqlText.address%type;
v_Process_Addr  V$Process.addr%type;
cursor c_sql_text is
       Select sql_text
       from   v$sqltext
       where  address = v_address
       order  by piece;
Begin
--  Consiste os parâmetros recebidos --
--
    If   P_Pid is null
    or   P_Pid = 0  then
         Dbms_Output.put_line ('PID fornecido em branco  - Procedure Cancelada');
         return;
    End  if;
    If   P_Opcao is null
    or   P_Opcao not in (1,2,3) then
         Dbms_Output.put_line ('Opcao fornecida invalida - Procedure Cancelada');
         return;
    End  if;
--  Acessa e exibe os dados da Sessão
--
         Begin
         Select Addr
         into   v_Process_Addr
         from   V$Process
         where  spid  =  P_Pid;
         Select Sid,         Serial#,      Username,      Status,         Machine,
                Terminal,    Program,      OsUser,        Schemaname,     Sql_Address,
                Prev_Sql_Addr
         into   v_Sid,       v_Serial#,    V_Username,    V_Status,       V_Machine,
                v_Terminal,  v_Program,    V_OsUser,      V_Schemaname ,  v_Sql_Address,
                v_Prev_Sql_Addr
         from   V$Session
         where   paddr = v_Process_Addr;
         Exception
           When No_Data_Found then
                Dbms_Output.Put_Line('Nao existe sessao no Oracle para este PID');
                return;
           When Others then
                Dbms_Output.Put_Line('Erro Grave ' || Sqlerrm) ;
                return;
         End;
     If  P_opcao = 1 then
         Dbms_Output.Put_line ('============================   ');
         Dbms_Output.Put_line ('Informacoes Gerais da Sessao   ');
         Dbms_Output.Put_line ('============================   ');
         Dbms_Output.Put_line ('Pid..........= ' || P_Pid       );
         Dbms_Output.Put_line ('Sid..........= ' || v_Sid       );
         Dbms_Output.Put_line ('Serial#......= ' || v_Serial#   );
         Dbms_Output.Put_line ('Username.....= ' || v_Username  );
         Dbms_Output.Put_line ('Status.......= ' || v_Status    );
         Dbms_Output.Put_line ('Machine......= ' || v_Machine   );
         Dbms_Output.Put_line ('Terminal.....= ' || v_Terminal  );
         Dbms_Output.Put_line ('Program......= ' || v_Program   );
         Dbms_Output.Put_line ('OsUser.......= ' || v_OsUser    );
         Dbms_Output.Put_line ('Schemaname...= ' || v_Schemaname);
         return;
     End if;
--  Acessa e exibe o comando atual e o anterior executados pela sessao
--
    If   P_Opcao = 2 then
         If   V_Sql_Address <> '00' then
              Dbms_Output.Put_line('===================           ');
              Dbms_Output.Put_line('Instrucao SQL atual           ');
              Dbms_Output.Put_line('===================           ');
              v_Address := V_Sql_Address;
              for  reg_c_sql_text in c_sql_text loop
                   Dbms_Output.Put_Line(reg_c_sql_text.sql_text);
              end loop;
         End if;
    End if;
    If   P_Opcao = 3
    and  V_Sql_Address <> V_Prev_Sql_Addr then
         If   V_Prev_Sql_Addr <> '00' then
              Dbms_Output.Put_line('======================           ');
              Dbms_Output.Put_line('Instrucao SQL anterior           ');
              Dbms_Output.Put_line('======================           ');
              v_Address := V_Prev_Sql_Addr;
              for  reg_c_sql_text in c_sql_text loop
                   Dbms_Output.Put_Line(reg_c_sql_text.sql_text);
              end loop;
         End if;
    End if;
Exception
      When Others then
           Dbms_Output.Put_Line('Erro Grave ' || Sqlerrm) ;
           return;
End;
/
