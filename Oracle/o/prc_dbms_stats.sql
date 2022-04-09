accept in_table_owner prompt "Owner: "
accept in_table_name prompt "Tabela: "

declare 

--pl_file sys.utl_file.file_type ;
pl_line varchar2 (256);
pl_sqlerrm varchar2(132) ;
-- output variables for table
numrows number ;
numblks number ;
avgrlen number;
--
-- input variables for columns
CURSOR cur_selcolumns IS
  Select column_name, decode(nullable,'N', ' (NOT NULL)','') not_null,
         num_distinct, num_nulls
    from dba_tab_columns
   where owner = '&&in_table_owner'
     and table_name = '&&in_table_name' ;
--
-- input variables for indexes
CURSOR cur_selindexes IS
  Select owner, index_name
    from dba_indexes
   where table_owner = '&&in_table_owner'
     and table_name = '&&in_table_name'
     and numrows > 0 ;
--
CURSOR cur_selcolindexes(in_index_owner VARCHAR2, in_index_name VARCHAR2) IS
  Select column_name
    from dba_ind_columns
   where index_owner = in_index_owner
     and index_name = in_index_name
  order by column_position ;
-- output variables for indexes
-- ind_numrows number ;
numlblks number ;
numdist number ;
avglblk number ;
avgdblk number ;
clstfct number ;
indlevel number ;
BEGIN
--
-- prepare output file
--
--pl_file := sys.utl_file.fopen('c:\oracle\admin\adm', 'selstaball.log', 'w');
--
-- get table statistics
--
sys.dbms_stats.get_table_stats('&&in_table_owner', '&&in_table_name',
numrows => numrows,numblks => numblks, avgrlen => avgrlen);
pl_line := 'Table '|| '&&in_table_owner' || '.' || '&&in_table_name' ;
dbms_output.put_line( pl_line );
pl_line := '- Number of rows     : '||numrows ;
dbms_output.put_line( pl_line );
pl_line := '- Number of blocks   : '||numblks ;
dbms_output.put_line( pl_line );
pl_line := '- Average row length : '||avgrlen ;
dbms_output.put_line( pl_line );
pl_line := '' ;
dbms_output.put_line( pl_line );

--
-- get table colums statistics
--
FOR selcolumns IN cur_selcolumns LOOP
  pl_line := '  Column ' || selcolumns.column_name || selcolumns.not_null ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Number of distinct values : ' || selcolumns.num_distinct ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Number of nulls : ' || selcolumns.num_nulls ;
  dbms_output.put_line( pl_line );
  pl_line := '' ;
  dbms_output.put_line( pl_line );
END LOOP ;
--
-- get index statistics
--
FOR selindexes IN cur_selindexes LOOP
  sys.dbms_stats.get_index_stats( selindexes.owner, selindexes.index_name,
    numrows => numrows, numlblks => numlblks,numdist => numdist,
    avglblk => avglblk,avgdblk => avgdblk,
    clstfct => clstfct,indlevel => indlevel);
  --
  -- get index colums
  --
  pl_line := '  Index ' || selindexes.owner||'.'||selindexes.index_name ;
  dbms_output.put_line( pl_line );
  FOR selcolindexes IN cur_selcolindexes(selindexes.owner,selindexes.index_name) LOOP
    pl_line := '  Column ' ||selcolindexes.column_name ;
    dbms_output.put_line( pl_line );
  END LOOP ;
  pl_line := '  - Number of rows              : '||numrows ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Number of blocks            : '||numlblks ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Number of disctint values   : '||numdist ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Average leaf blocks per key : '||avglblk ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Average data blocks per key : '||avgdblk ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Clustering Factor           : '||clstfct ;
  dbms_output.put_line( pl_line );
  pl_line := '  - Depth of tree               : '||indlevel ;
  dbms_output.put_line( pl_line );
  pl_line := '' ;
  dbms_output.put_line( pl_line );
END LOOP ;
--sys.utl_file.fclose(pl_file) ;
EXCEPTION
/*
  WHEN sys.utl_file.INVALID_PATH THEN
    pl_line := 'Invalid file name or file location' ;
    dbms_output.put_line( pl_line );
    sys.utl_file.fclose(pl_file) ;
  WHEN sys.utl_file.INVALID_MODE THEN
    pl_line := 'open_mode parameter must be ''a'', ''w'' or ''r''' ;
    dbms_output.put_line( pl_line );
    sys.utl_file.fclose(pl_file) ;
  WHEN sys.utl_file.INVALID_OPERATION THEN
    pl_line := 'File cannot be operated or opened as requested' ;
    dbms_output.put_line( pl_line );
    sys.utl_file.fclose(pl_file) ;
  WHEN OTHERS THEN
    pl_sqlerrm := substr(SQLERRM, 1,132 ) ;
    pl_line := 'Error : ' || pl_sqlerrm  ;  
    dbms_output.put_line( pl_line );
    sys.utl_file.fclose(pl_file) ;
*/
null;
END;
/
