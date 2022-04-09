/*
	set lines 135
	set pages 200
	col file_name for a40
	col tablespace_name for a20
	col "Pct Free" format a8
*/
	SELECT 	t.tablespace_name,
		nvl(t.bytes,0)/1024/1024 "Total(Mb)",
		nvl(nvl(f.free,ft.free),0)/1024/1024  "Free(Mb)",
		to_char(round((nvl(f.free,ft.free)*100)/t.bytes,1),999.9) "Pct Free"	
	FROM			(SELECT	d.tablespace_name,
					sum(d.bytes) bytes
				FROM	dba_data_files d
				GROUP BY tablespace_name
				UNION
				SELECT	d.tablespace_name,
					sum(d.bytes) bytes
				FROM	dba_TEMP_files d
				GROUP BY tablespace_name) t,
				(SELECT	tablespace_name,
					sum(bytes) free
				FROM	dba_free_space
				GROUP BY tablespace_name) f,
				(select TABLESPACE_NAME,
					sum(bytes_free) free  
				from 	V$TEMP_SPACE_HEADER
				group by tablespace_name) ft			
	WHERE	t.tablespace_name = f.tablespace_name(+)
	AND	t.tablespace_name = ft.tablespace_name(+)
	--AND	t.tablespace_name = 'PSAPSTABI'
	ORDER BY 4;

--##########################################################################################
/*
set lines 180
set pages 200
col file_name for a40
col tablespace_name for a20
col "Pct Free" format a8
SELECT 	d.TABLESPACE_NAME,
	d.FILE_NAME,
	d.BYTES/1024/1024		"Total(Mb)",
	nvl(nvl(f.bytes,ft.bytes)/1024/1024,0)	"Free(Mb)",
	to_char(round((nvl(nvl(f.bytes,ft.bytes),0)*100)/d.bytes,1),999.9) "Pct Free",
	AUTOEXTENSIBLE,
	MAXBYTES/1024/1024 "Maxbytes(Mb)"
FROM	(select	tablespace_name,
		file_name,
		bytes,
		AUTOEXTENSIBLE,
		MAXBYTES,
		file_id
	from	dba_data_files
	union
	select	tablespace_name,
		file_name,
		bytes,
		AUTOEXTENSIBLE,
		MAXBYTES,
		file_id
	from	dba_temp_files) d,
	(select	file_id,
		tablespace_name,
		sum(bytes) bytes
	from	dba_free_space
	group by file_id,
		 tablespace_name) f,
	(select TABLESPACE_NAME,
		file_id,
		bytes_free bytes 
	from 	V$TEMP_SPACE_HEADER) ft
WHERE	d.file_id = f.file_id(+)
AND	d.tablespace_name = f.tablespace_name(+)
AND	d.file_id = ft.file_id(+)
AND	d.tablespace_name = ft.tablespace_name(+)
--AND	FILE_NAME LIKE '%'
AND	d.tablespace_name like 'PSAPSTABI'
ORDER BY 1,2;

*/
