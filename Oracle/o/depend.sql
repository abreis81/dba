REM depends.sql     Try to determine what objects an objects depends on
REM		    Oracle 8 version. 
REM 
REM Usage:          Connect to SQL*Plus as a DBA user and run this script.
REM                 When prompted for 'OWNER' enter the owner or a pattern
REM                 Eg: sco%
REM                 When prompted for the 'OBJECT' enter its name or a pattern.
REM                 The relevant objects should be listed. 
REM                 Select the object ID of the required object to check. 
REM
REM                 A immediate dependency chart should be shown.
REM
REM 
set echo off
set feedback off
set ver off
set pages 10000
column Owner format "A10"
column Obj#  format "99999"
column Object format "A42"
rem
ACCEPT OWN   CHAR PROMPT "Enter OWNER pattern: "
ACCEPT NAM   CHAR PROMPT "Enter OBJECT NAME pattern: "
prompt
prompt "Objects matching &&OWN..&&NAM"
prompt "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
select o.obj# "Obj#",
       decode(o.linkname, null, 
        u.name||'.'||o.name,
        o.remoteowner||'.'||o.name||'@'||o.linkname) "Object",
       decode(o.type#, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
			4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
			7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
			10, '*Not Exist*',
			11, 'PKG BODY', 12, 'TRIGGER', 
			13, 'TYPE', 14,'TYPE BODY',
			19,'TABLE PARTITION', 20,'INDEX PARTITION',
			21,'LOB',22,'LIBRARY',
			23,'DIRECTORY', 'UNDEFINED') "Type",
       decode(o.status,0,'N/A',1,'VALID', 'INVALID') "Status"
  from sys.obj$ o, sys.user$ u 
 where owner#=user# 
   and u.name like upper('&&OWN') and o.name like upper('&&NAM')
;
prompt
ACCEPT OBJID CHAR PROMPT "Enter Object ID required: "
prompt
prompt
prompt "Object &&OBJID is:"
prompt "~~~~~~~~~~~~~~~~~~~"
select o.obj# "Obj#",
       decode(o.linkname, null, 
        u.name||'.'||o.name,
        o.remoteowner||'.'||o.name||'@'||o.linkname) "Object",
       decode(o.type#, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
			4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
			7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
			10, '*Not Exist*',
			11, 'PKG BODY', 12, 'TRIGGER', 
			13, 'TYPE', 14,'TYPE BODY',
			19,'TABLE PARTITION', 20,'INDEX PARTITION',
			21,'LOB',22,'LIBRARY',
			23,'DIRECTORY', 'UNDEFINED') "Type",
       decode(o.status,0,'N/A',1,'VALID', 'INVALID') "Status",
       substr(to_char(stime,'DD-MON-YYYY HH24:MI:SS'),1,20) "S-Time"
  from sys.obj$ o, sys.user$ u 
 where owner#=user# and o.obj#='&&OBJID'
;
prompt
prompt "Depends on:"
prompt "~~~~~~~~~~~"

select o.obj# "Obj#", 
       decode(o.linkname, null, 
        nvl(u.name,'Unknown')||'.'||nvl(o.name,'Dropped?'),
        o.remoteowner||'.'||nvl(o.name,'Dropped?')||'@'||o.linkname) "Object",
       decode(o.type#, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
			4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
			7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
			10, '*Not Exist*',
			11, 'PKG BODY', 12, 'TRIGGER', 
			13, 'TYPE', 14,'TYPE BODY',
			19,'TABLE PARTITION', 20,'INDEX PARTITION',
			21,'LOB',22,'LIBRARY',
			23,'DIRECTORY', 'UNDEFINED') "Type",
        decode(sign(stime-P_TIMESTAMP),
                      1,'*NEWER*',-1,'*?OLDER?*',null,'-','-SAME-') "TimeStamp",
  decode(o.status,0,'N/A',1,'VALID','INVALID') "Status"
  from sys.dependency$ d,  sys.obj$ o, sys.user$ u
 where P_OBJ#=obj#(+) and o.owner#=u.user#(+) and D_OBJ#='&&OBJID'
;

prompt
prompt "Direct Dependants:"
prompt "~~~~~~~~~~~~~~~~~~"

select o.obj# "Obj#", 
       decode(o.linkname, null, 
        nvl(u.name,'Unknown')||'.'||nvl(o.name,'Dropped?'),
        o.remoteowner||'.'||nvl(o.name,'Dropped?')||'@'||o.linkname) "Object",
       decode(o.type#, 0, 'NEXT OBJECT', 1, 'INDEX', 2, 'TABLE', 3, 'CLUSTER',
			4, 'VIEW', 5, 'SYNONYM', 6, 'SEQUENCE',
			7, 'PROCEDURE', 8, 'FUNCTION', 9, 'PACKAGE',
			10, '*Not Exist*',
			11, 'PKG BODY', 12, 'TRIGGER', 
			13, 'TYPE', 14,'TYPE BODY',
			19,'TABLE PARTITION', 20,'INDEX PARTITION',
			21,'LOB',22,'LIBRARY',
			23,'DIRECTORY', 'UNDEFINED') "Type",
        decode(sign(stime-D_TIMESTAMP),
                      1,'*NEWER*',-1,'*?OLDER?*',null,'-','-SAME-') "TimeStamp",
  decode(o.status,0,'N/A',1,'VALID','INVALID') "Status"
  from sys.dependency$ d,  sys.obj$ o, sys.user$ u
 where D_OBJ#=obj#(+) and o.owner#=u.user#(+) and P_OBJ#='&&OBJID'
;

