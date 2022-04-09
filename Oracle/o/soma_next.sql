compute sum of next_extent on report;
break on report;
select substr(a.tablespace_name,1,30) Tablespace
        ,substr(a.segment_name,1,30)    Objeto
        ,substr(a.segment_type,1,10)    Tipo
        ,a.extents                      extents
        ,(a.next_extent/1024)           next_extent
        ,(s.bytes/1024)                 Livre
    from dba_segments a
        ,(select tablespace_name 
                ,max(bytes) bytes
            from dba_free_space
        group by tablespace_name) s
   where s.tablespace_name(+) = a.tablespace_name
	  and (a.next_extent) > s.bytes
	 and a.tablespace_name='TBS_DAT_EDGE';