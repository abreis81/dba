-- Comments and Script Documentation
-- Script Name   : extract_schema_ddl.sql
-- Requirements  : User calling script must be owner the objects, and have privileges the package   DBMS_METADATA. 
-- Author        : HUDSON SANTOS
-- Created Date  : 05/05/2011


set pagesize 0
set long 90000
set linesize 32767
set trimspool ON
set feedback off
set echo off 
column txt format a121 word_wrapped

BEGIN
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', TRUE );
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', TRUE );
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false ); 
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'REF_CONSTRAINTS',false);
END;
/


spool schema.sql 

-- TABELAS

SELECT DBMS_METADATA.GET_DDL('TABLE',u.table_name) txt
     FROM USER_TABLES u ;

-- CONSTRAINTS R1

SELECT DBMS_METADATA.GET_DDL('CONSTRAINT',u.constraint_name) txt
     FROM USER_constraints u WHERE CONSTRAINT_TYPE IN ('P','C');

-- CONSTRAINTS R2

SELECT DBMS_METADATA.GET_DDL('REF_CONSTRAINT',u.constraint_name) txt
     FROM USER_constraints u WHERE CONSTRAINT_TYPE IN ('R');

-- INDICES 
SELECT DBMS_METADATA.GET_DDL('INDEX',u.index_name) txt
     FROM USER_INDEXES u ;

-- TRIGGERS

SELECT dbms_metadata.get_ddl('TRIGGER', u.trigger_name) txt
 FROM USER_TRIGGERS u;

-- PROCEDURES

SELECT dbms_metadata.get_ddl('PROCEDURE', u.object_name) txt
 FROM USER_objects u WHERE OBJECT_TYPE='PROCEDURE' ;

-- FUNCTIONS

SELECT dbms_metadata.get_ddl('FUNCTION', u.object_name) txt
 FROM USER_objects u WHERE OBJECT_TYPE='FUNCTION' ;

-- SEQUENCES

SELECT dbms_metadata.get_ddl('SEQUENCE',u.SEQUENCE_NAME) txt
 FROM USER_SEQUENCES u;

-- VIEWS

SELECT dbms_metadata.get_ddl('VIEW',u.VIEW_NAME) txt
 FROM USER_VIEWS u;

-- VIEW_MATERIALIZED

SELECT dbms_metadata.get_ddl('MATERIALIZED_VIEW',u.MVIEW_NAME) txt
 FROM USER_MVIEWS u;

--PACKAGE

SELECT dbms_metadata.get_ddl('PACKAGE',u.object_name) txt
 FROM USER_OBJECTS u WHERE OBJECT_TYPE='PACKAGE';

--PACKAGE_BODY

SELECT dbms_metadata.get_ddl('PACKAGE_BODY',u.object_name) txt
 FROM USER_OBJECTS u WHERE OBJECT_TYPE='PACKAGE_BODY';


spool off;