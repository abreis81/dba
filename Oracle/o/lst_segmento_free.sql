set pagesize 66
--
column tablespace format a10
column "LIVRE(MBYTES)" format '999,990.00'
column "MAXLIVRE(MBYTES)" format '999,990.00'
--
break on tot
--
compute sum on tot of "LIVRE(MBYTES)"
compute sum on tot of "MAXLIVRE(MBYTES)"
--
clear screen
--
  select 'tot' tot
        ,a.tablespace_name      "TABLESPACE"
        ,sum(a.bytes)/1024/1024 "LIVRE(MBYTES)"
        ,max(a.bytes)/1024/1024 "MAXLIVRE(MBYTES)"
    from sys.dba_free_space a
group by a.tablespace_name
/
