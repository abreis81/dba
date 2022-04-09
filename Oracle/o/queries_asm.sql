SELECT
    a.name                disk_group_name
  , b.path                disk_path
  , b.reads               reads
  , b.writes              writes
  , b.read_errs           read_errs 
  , b.write_errs          write_errs
  , b.read_time           read_time
  , b.write_time          write_time
  , b.bytes_read          bytes_read
  , b.bytes_written       bytes_written
FROM
    v$asm_diskgroup a
 JOIN v$asm_disk b USING (group_number)
ORDER BY
    a.name


SELECT
    g.name               disk_group_name
  , a.name               alias_name
  , a.file_number        file_number
  , a.file_incarnation   file_incarnation
  , a.alias_index        alias_index
  , a.alias_incarnation  alias_incarnation
  , a.parent_index       parent_index
  , a.reference_index    reference_index
  , a.alias_directory    alias_directory
  , a.system_created     system_created
FROM
    v$asm_alias a JOIN v$asm_diskgroup g USING (group_number)
ORDER BY
    g.name
  , a.file_number
/

SELECT
    g.name               disk_group_name
  , a.name               alias_name
  , a.alias_directory    alias_directory
FROM
    v$asm_alias a JOIN v$asm_diskgroup g USING (group_number)
ORDER BY
    g.name
  , a.file_number
/

SELECT level, dir, sys, substr(lpad(' ',2*level,' ')||CONCAT('+'||gname,
     SYS_CONNECT_BY_PATH(aname,'/')),1,60) full_path
     FROM ( SELECT g.name gname, a.parent_index pindex, a.name aname,
     a.reference_index rindex, a.ALIAS_DIRECTORY dir, a.SYSTEM_CREATED sys
                      FROM v$asm_alias a, v$asm_diskgroup g
                    WHERE a.group_number = g.group_number)
     START WITH (MOD(pindex, POWER(2, 24))) = 0
     CONNECT BY PRIOR rindex = pindex
     ORDER BY rtrim(ltrim(full_path))desc, level asc; 