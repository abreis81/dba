CREATE OR REPLACE PROCEDURE sp_show_call_pk2 IS
--
-- Josivan em 28/05/2001
--
-- ENTRADA
--   t: identificador da transacao
--   c: sequencia 
-- SAIDA
--   Argumento              Data Type       Valor
--   ---------------------- --------------- ----------------------
--   01 COLUMN_CHANGED$     RAW             060607
--   02*GRADE1_o            NUMBER          9
--   03*GRADE1_n            NUMBER          (NULL)
--   04 HISAL2_o            NUMBER          9999
--   05 HISAL2_n            NUMBER          (NULL)
--   06 LOSAL3_o            NUMBER          999
--   07 LOSAL3_n            NUMBER          (NULL)
--   08 SITE_NAME           VARCHAR2        REP2.WORLD
--   09 PROPAGATION_FLAG    VARCHAR2        N
--
--  Nota: colunas com '*' identifica a PRIMARY KEY da tabela
--
  argno         number;
  argtyp        number;
  argform       number;
  callno        number;
  tranid        VARCHAR2(30);
  typdsc        char(15);
  rowid_val     rowid;
  char_val      varchar2(255);
  nchar_val     nvarchar2(255);
  date_val      date;
  number_val    number;
  varchar2_val  varchar2(2000);
  nvarchar2_val nvarchar2(2000);
  raw_val       raw(255);
  arg_name      varchar2(20);
  arg_name_c    char(20);
  table_name    varchar2(100);
  col_name      varchar2(100);
  pk_char       char(1);
 f_lista       UTL_FILE.FILE_TYPE;
  valor	 	varchar2(30);
	 
  cursor nome_pack is
	select distinct substrb(sys.dbms_defer_query_utl.package_name(2,chain_no,user_data),1,30) packagename
	from system.def$_aqerror;

  cursor c_defcall (pack VARCHAR2) is
    select TO_CHAR(ENQ_TIME,'DD/MM/YYYY HH24:MI:SS') dt_trans
	   step_no callno,
           enq_tid deferred_tran_id,
           substrb(sys.dbms_defer_query_utl.schema_name(2,chain_no,user_data),1,30) schemaname,
           substrb(sys.dbms_defer_query_utl.package_name(2,chain_no,user_data),1,30) packagename,
           substrb(sys.dbms_defer_query_utl.procedure_name(2,chain_no,user_data),1,30) procname,
           chain_no      argcount
       from system.def$_aqerror
	where substrb(sys.dbms_defer_query_utl.package_name(2,chain_no,user_data),1,30) packagename = p';

  cursor c_arg_name( p_schema     VARCHAR2
                    ,p_procname   VARCHAR2
                    ,p_pkgname    VARCHAR2
                    ,p_call_count VARCHAR2 ) is

     select argument_name
       from all_arguments
      where owner        = p_schema
        and package_name = p_pkgname
        and object_name  = p_procname
        and (overload    = ( select ovrld.overload
                               from ( select overload
                                            ,object_name
                                            ,package_name
                                            ,max(position) pos
                                        from all_arguments
                                       where object_name  = p_procname
                                         and package_name = p_pkgname
                                    group by overload
                                            ,object_name
                                            ,package_name ) ovrld
                              where p_call_count = ovrld.pos
                                and object_name  = p_procname
                                and package_name = p_pkgname ) or overload is null )
   order by position;

  cursor pk_cursor( schema   VARCHAR2
                   ,t_name   VARCHAR2
                   ,col_name VARCHAR2 ) is
     select decode (count(*),1,'*',' ')
       from dba_constraints  t1
           ,dba_cons_columns t2
      where t1.constraint_name = t2.constraint_name
        and t1.owner           = t2.owner
        and t1.owner           = schema
        and t1.constraint_type = 'P'
        and t1.table_name      = t_name
        and t2.column_name     like col_name;

begin
  
    for cpack in nome_pack loop
    nome_arq := cpack.packagename||'.log';
    f_lista  := UTL_FILE.FOPEN('/ora01/dba/log' , nome_arq , 'w');
    for c1rec in c_defcall (cpack.packagemame) loop
    
    
    argno := 1;
    callno := c1rec.callno; tranid := c1rec.deferred_tran_id;
    open c_arg_name (c1rec.schemaname, c1rec.procname,c1rec.packagename, c1rec.argcount);

    while argno <= c1rec.argcount loop

      fetch c_arg_name into arg_name;
      arg_name_c := arg_name;

      open pk_cursor (c1rec.schemaname, table_name, col_name);
      fetch pk_cursor into pk_char;
--    dbms_output.put_line(table_name||'.'||col_name||'['||pk_char||']');
      close pk_cursor;

      argtyp := dbms_defer_query.get_arg_type(callno, argno, tranid);
      argform := dbms_defer_query.get_arg_form(callno, argno, tranid);
      if pk_char='*' then
      	if argtyp = 1 and argform = 1 then
         typdsc := 'VARCHAR2';
         valor := to_char(dbms_defer_query.get_varchar2_arg(callno,argno,tranid));
         
      	elsif argtyp = 1 and argform = 2 then
         typdsc := 'NVARCHAR2';
         valor := to_char(dbms_defer_query.get_nvarchar2_arg(callno,argno,tranid));
         
      	elsif argtyp = 2 then
         typdsc := 'NUMBER';
         valor := to_char(dbms_defer_query.get_number_arg(callno, argno,tranid));
         
      	elsif argtyp = 11 then
         typdsc := 'ROWID';
         rowid_val := to_char(dbms_defer_query.get_rowid_arg(callno, argno,tranid));
         
      	elsif argtyp = 12 then
         typdsc := 'DATE';
         valor := to_char(dbms_defer_query.get_date_arg(callno, argno,tranid));

      	elsif argtyp = 23 then
         typdsc := 'RAW';
         valor := to_char(dbms_defer_query.get_raw_arg(callno, argno, tranid));

      	elsif argtyp = 96 and argform = 1 then
         typdsc := 'CHAR';
         valor := to_char(dbms_defer_query.get_char_arg(callno, argno,tranid));

      	elsif argtyp = 96 and argform = 2 then
         typdsc := 'NCHAR';
         valor := to_char(dbms_defer_query.get_nchar_arg(callno, argno,tranid));
  
      	elsif argtyp = 113 then
         typdsc := 'BLOB';
         valor := to_char(dbms_lob.substr(dbms_defer_query.get_blob_arg(callno,argno, tranid)));
         
      	elsif argtyp = 112 and argform = 1 then
         typdsc := 'CLOB';
        valor :=to_char(dbms_lob.substr(dbms_defer_query.get_clob_arg(callno,argno, tranid)));

      	elsif argtyp = 112 and argform = 2 then
         typdsc := 'NCLOB';
         valor :=to_char(dbms_lob.substr(dbms_defer_query.get_nclob_arg(callno,argno, tranid)));
    
      end if;

       UTL_FILE.PUT_LINE('DATA_HORA_TRANSACAO STEP_NO ENQ_TID        PACKAGENAME        PROCNAME    NUMERO DO CARTAO(PK)');
       UTL_FILE.PUT_LINE('------------------- ------- -------------- ------------------ ----------- --------------------');
       UTL_FILE.PUT_LINE(c1rec.dt_trans||' '||c1rec.callno||' '||c1rec.deferred_tran_id||' '||c1rec.schemaname||' '||c1rec.packagename||' '||c1rec.procname||' '||valor);	
      argno := argno + 1;

    end loop;

  end loop;
       UTL_FILE.FCLOSE(f_lista);
  end loop;
end;
/
