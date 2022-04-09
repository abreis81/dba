set heading off;
set feedback off;
set pagesize 1000;
set verify off;
--
accept OWNER  char prompt 'Tecle o owner da tabela:';
accept TABELA char prompt 'Tecle o nome da tabela :'; 
--
spool &&TABELA
--
column teste noprint
--
set term off;
--
select con#||'q1' teste
      ,'  ALTER TABLE '||obj2.name ||' ADD FOREIGN KEY ('
  from sys.cdef$ def
      ,sys.obj$ obj1
      ,sys.obj$ obj2
      ,sys.user$ us
 where def.type    = 4
   and def.robj#   = obj1.obj#
   and obj1.name   = upper('&&TABELA')
   and def.obj#    = obj2.obj#
   and obj1.owner# = us.user#
   and us.name     = upper('&&OWNER')
 union
select def.con#||'q2'||ccol.pos# teste
      ,'                    '||col.name||decode(to_char(def.cols-ccol.pos#),0,' )',' ,')
  from sys.obj$ obj
      ,sys.cdef$ def
      ,sys.ccol$ ccol
      ,sys.col$ col
      ,sys.user$ us
 where obj.name   = upper('&&TABELA')
   and obj.obj#   = def.robj#
   and def.obj#   = ccol.obj#
   and def.con#   = ccol.con#
   and ccol.col#  = col.col#
   and ccol.obj#  = col.obj#
   and obj.owner# = us.user#
   and us.name    = upper('&&OWNER')
 union
select con#||'q3' teste
      ,'             REFERENCES '||obj1.name ||' ('
  from sys.cdef$ def
      ,sys.obj$ obj1
      ,sys.user$ us 
 where def.type   = 4
  and def.robj#   = obj1.obj#
  and obj1.name   = upper('&&TABELA')
  and obj1.owner# = us.user#
  and us.name     = upper('&&OWNER')
union
select def.con#||'q4'||ccol.pos# teste
      ,'                    '||col.name||decode(to_char(def.cols-ccol.pos#),0,' )',' ,')
 from sys.obj$ obj
     ,sys.cdef$ def
     ,sys.ccol$ ccol
     ,sys.col$ col
     ,sys.user$ us
where obj.name   = upper('&&TABELA')
  and obj.obj#   = def.robj#
  and def.robj#  = ccol.obj#
  and def.rcon#  = ccol.con#
  and ccol.col#  = col.col#
  and ccol.obj#  = col.obj#
  and obj.owner# = us.user#
  and us.name    = upper('&&OWNER')
union
select def.con#||'q5' teste
      ,'             CONSTRAINT '||con.name||'   ;'
  from sys.obj$ obj
      ,sys.cdef$ def
      ,sys.con$ con
      ,sys.user$ us
 where obj.name   = upper('&&TABELA')
   and obj.obj#   = def.robj#
   and def.con#   = con.con#
   and obj.owner# = us.user#
   and us.name    = upper('&&OWNER');
--
set verify on;
set feedback on;
set pagesize 14;
set heading on;
spool off;
undefine TABELA;
set term on;
