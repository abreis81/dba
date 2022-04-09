CREATE OR REPLACE
PROCEDURE brdba.sp_lista_erros(hora_1 IN VARCHAR2, hora_2 IN VARCHAR2) IS

  argno         NUMBER;
  argtyp        NUMBER;
  argform       NUMBER;
  callno        NUMBER;
  tranid        VARCHAR2(30);
  typdsc        CHAR(15);
  char_val      VARCHAR2(500);
  date_val      DATE;
  number_val    NUMBER;
  varchar2_val  VARCHAR2(2000);
  arg_name_c    CHAR(30);
  pk_char       CHAR(1):=' ';
  valor_coluna  VARCHAR2(30);
  nome_tabela   VARCHAR2(30);
  v_conta_id    NUMBER(2);
  f_lista       UTL_FILE.FILE_TYPE;
  nome_arq      VARCHAR2(50);
  valor_pk      VARCHAR2(300);
  nm_site	varchar2(15);

  cursor c_agrupa_tabelas is
     SELECT substrb(sys.dbms_defer_query_utl.schema_name(2,A.chain_no,A.user_data),1,30) schemaname,
            substrb(sys.dbms_defer_query_utl.package_name(2,A.chain_no,A.user_data),1,30) packagename,
            substrb(sys.dbms_defer_query_utl.procedure_name(2,A.chain_no,A.user_data),1,30) procname,
            A.enq_time      horario ,
            A.enq_tid               ,
            A.chain_no      argcount,
            A.step_no       callno  ,
	    B.error_number  cod_error,
            B.error_msg
       FROM system.def$_aqerror      A,
            system.def$_error        B
      WHERE A.ENQ_TIME BETWEEN to_date(hora_1,'dd/mm/yyyy hh24:mi')
                           AND to_date(hora_2,'dd/mm/yyyy hh24:mi')
        AND A.ENQ_TID = B.ENQ_TID
      ORDER BY 1,2,3,4;

  cursor pk_cursor (schema VARCHAR2, t_name VARCHAR2) is
     select column_name
       from dba_constraints  t1, dba_cons_columns t2
      where t1.constraint_name = t2.constraint_name
        and t1.owner           = t2.owner
        and t1.owner           = schema
        and t1.constraint_type = 'P'
        and t1.table_name      = t_name;

  cursor c_arg_name (p_schema VARCHAR2, p_procname VARCHAR2, p_pkgname VARCHAR2,
                     p_call_count VARCHAR2, coluna VARCHAR2)  is
     select position, argument_name
       from all_arguments
      where owner = p_schema
        and package_name = p_pkgname
        and object_name = p_procname
        and coluna = substr(argument_name,1,length(coluna))
        and (overload = (select overload
                          from all_arguments
                         where owner = p_schema
                           and package_name = p_pkgname
                           and object_name = p_procname
                           and position = p_call_count)
             or overload is null);

  arg_name            c_arg_name%rowtype;

BEGIN

  select global_name into nm_site from global_name;

  nome_arq := to_char(to_date(hora_1,'dd/mm/yyyy hh24:mi'),'dd-mm_hh24-mi_')||'ate_'||to_char(to_date(hora_2,'dd/mm/yyyy hh24:mi'),'dd-mm_hh24-mi')||'.log';
  f_lista  := UTL_FILE.FOPEN('/ora01/dba/log' , nome_arq , 'w');

  UTL_FILE.PUT_LINE(f_lista ,'-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
  UTL_FILE.PUT_LINE(f_lista ,'Codigo                Operacao            Horario        Tabela                        Valor da Chave                Erro Oracle                                                                                         ');
  UTL_FILE.PUT_LINE(f_lista ,'-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');

  FOR v_fila_erro in c_agrupa_tabelas LOOP

    valor_pk    := 'N';
    nome_tabela := substr(v_fila_erro.packagename, 1,instr(v_fila_erro.packagename, '$') - 1);
    v_conta_id  := 1;

    FOR v_coluna_pk in pk_cursor (v_fila_erro.schemaname,nome_tabela) LOOP

      open  c_arg_name (v_fila_erro.schemaname, v_fila_erro.procname, v_fila_erro.packagename, v_fila_erro.argcount, v_coluna_pk.column_name);
      fetch c_arg_name into arg_name;
      close c_arg_name;

      callno     := v_fila_erro.callno;
      tranid     := v_fila_erro.enq_tid;
      argno      := arg_name.position;
      argtyp     := dbms_defer_query.get_arg_type(callno, argno, tranid);
      argform    := dbms_defer_query.get_arg_form(callno, argno, tranid);

      if argtyp = 1 and argform = 1 then
         typdsc := 'VARCHAR2';
         varchar2_val := dbms_defer_query.get_varchar2_arg(callno,argno,tranid);
         valor_coluna := (substr(varchar2_val,1,30));
      elsif argtyp = 2 then
         typdsc := 'NUMBER';
         number_val := dbms_defer_query.get_number_arg(callno, argno, tranid);
         valor_coluna := (nvl(to_char(number_val),'(NULL)'));
      elsif argtyp = 12 then
         typdsc := 'DATE';
         date_val := dbms_defer_query.get_date_arg(callno, argno, tranid);
         valor_coluna := (nvl(to_char(date_val,'YYYY-MM-DD HH24:MI:SS'),'(NULL)'));
      end if;

      if v_conta_id = 1 then
	  if v_fila_erro.procname like '%INSERT%' THEN
 	   if argtyp = 12 then
  	    valor_pk := 'insert into '||nome_tabela||'@'||nm_site||' (select * from '||nome_tabela||' where '||
	    rtrim(arg_name.argument_name,arg_name.position||'_n')||'= to_date('||''''||valor_coluna||''''||','||''''||'YYYY-MM-DD HH24:MI:SS'||''''||')';
	   else
            valor_pk := 'insert into '||nome_tabela||'@'||nm_site||' (select * from '||nome_tabela||' where '||
	    rtrim(arg_name.argument_name,arg_name.position||'_n')||'='||''''||valor_coluna||'''';
	   end if;
	  else
	    if argtyp = 12 then
	     valor_pk := rtrim(arg_name.argument_name,arg_name.position - 1||'_o')||'= to_date('||''''||valor_coluna||''''||','||''''||'YYYY-MM-DD HH24:MI:SS'||''''||')';
 	    else
	     valor_pk := rtrim(arg_name.argument_name,arg_name.position - 1||'_o')||'='||''''||valor_coluna||'''';
            end if;
	  end if;

         UTL_FILE.PUT_LINE(f_lista ,rpad(v_fila_erro.enq_tid,22,' ')
                                 ||rpad(substr(v_fila_erro.procname,5),20,' ')
                                 ||to_char(v_fila_erro.horario,'dd/mon hh24:mi   ')
                                 ||rpad(nome_tabela,30,' ')
                                 ||rpad(valor_coluna,30,' ')
                                 ||substr(substr(v_fila_erro.error_msg,1,length(v_fila_erro.error_msg) - 1),1,63));
      else

         if v_fila_erro.procname like '%INSERT%' THEN
	   if argtyp = 12 then
	    valor_pk := valor_pk||' and '||rtrim(arg_name.argument_name,arg_name.position||'_n')||'= to_date('||''''||valor_coluna||''''||','||''''||'YYYY-MM-DD HH24:MI:SS'||''''||')';
	   else
            valor_pk := valor_pk||' and '||rtrim(arg_name.argument_name,arg_name.position||'_n')||'='||''''||valor_coluna||'''';
	   end if;
            UTL_FILE.PUT_LINE(f_lista ,'"                     "                   "              "                             '||valor_coluna);
         else
	    if argtyp = 12 then
	     valor_pk := valor_pk||' and '||rtrim(arg_name.argument_name,arg_name.position -1 ||'_o')||'= to_date('||''''||valor_coluna||''''||','||''''||'YYYY-MM-DD HH24:MI:SS'||''''||')';
	    else
	     valor_pk := valor_pk||' and '||rtrim(arg_name.argument_name,arg_name.position -1 ||'_o')||'='||''''||valor_coluna||'''';
	    end if;
            UTL_FILE.PUT_LINE(f_lista ,'"                     "                   "              "                             '||valor_coluna);
	 end if;

      end if;
         v_conta_id := v_conta_id + 1;

    END LOOP;

    valor_pk := valor_pk||')';

    IF VALOR_PK <> 'N' THEN
       BEGIN
         INSERT INTO BRDBA.TBDBA_FILA_ERROS( CD_REPLICA
                                      ,NM_TABELA
                                      ,NM_PROCNAME
                                      ,NM_CHAVEPK
                                      ,DT_OCORR
				      ,NNUM_ERRO )
                               VALUES( rpad(v_fila_erro.enq_tid,22,' ')
                                      ,rpad(nome_tabela,30,' ')
                                      ,rpad(substr(v_fila_erro.procname,5),20,' ')
                                      ,valor_pk
                                      ,SYSDATE 
				      ,v_fila_erro.cod_error);

         COMMIT;

       EXCEPTION
         WHEN OTHERS THEN
           NULL;
       END;
    END IF;

  END LOOP;

  UTL_FILE.FCLOSE(f_lista);

END;
/
