GRANT CTXAPP TO teste_ctx;

 

 

GRANT EXECUTE ON CTXSYS.CTX_CLS TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_DDL TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_DOC TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_OUTPUT TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_QUERY TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_REPORT TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_THES TO teste_ctx;

GRANT EXECUTE ON CTXSYS.CTX_ULEXER TO teste_ctx;

 

CREATE TABLE CONTENT_INVENTORY (

  CONTENT_INVENTORY_ID       NUMBER NOT NULL,

  FILE_NAME                     VARCHAR2(1024),

  KEYWORDS                      VARCHAR2(2048),

  URL                                     SYS.HTTPURITYPE,

  TEXT                                   BLOB DEFAULT empty_blob(),

  TEXT_LOADED                                CHAR(1) DEFAULT 'N' NOT NULL,

    CONSTRAINT UNQ_CONTENT_INVENTORY

      UNIQUE(CONTENT_INVENTORY_ID) USING INDEX

    TABLESPACE USERS

);

 

INSERT INTO CONTENT_INVENTORY

  (CONTENT_INVENTORY_ID, FILE_NAME, KEYWORDS)

    VALUES ('1', 'Aleph_DB_link.pdf', 'encompassing');

--Word Document

INSERT INTO CONTENT_INVENTORY

  (CONTENT_INVENTORY_ID, FILE_NAME, KEYWORDS)

    VALUES ('2', 'Sistema.doc', '');

INSERT INTO CONTENT_INVENTORY

  (CONTENT_INVENTORY_ID, FILE_NAME, KEYWORDS)

    VALUES ('3', 'gc26784700.pdf', 'encompassing');

 

CREATE OR REPLACE PROCEDURE loadLOBFromBFILE IS

   Dest_loc       BLOB;

   Src_loc        BFILE := BFILENAME('DCTX', '');

   Amount         INTEGER := 0;

   cursor ContentInv_cursor is

     --create a recordset of the file names

     --that we need to load from the filesystem into the

     --Oracle database.

     SELECT

       CONTENT_INVENTORY_ID,

       FILE_NAME

       FROM teste_ctx.CONTENT_INVENTORY

       WHERE FILE_NAME IS NOT NULL;

   varContentInv_id CONTENT_INVENTORY.CONTENT_INVENTORY_ID%TYPE;

   varFileName      CONTENT_INVENTORY.FILE_NAME%TYPE;

BEGIN

 open ContentInv_cursor;

 loop

   varFileName := NULL;

   varContentInv_id := NULL;

   fetch ContentInv_cursor into varContentInv_id, varFileName;

   exit when ContentInv_cursor%notfound;

   Src_loc := BFILENAME('DCTX', varFileName);

   IF DBMS_LOB.FILEEXISTS (Src_loc) = 1 THEN

     SELECT text INTO Dest_loc FROM CONTENT_INVENTORY

        WHERE CONTENT_INVENTORY_ID = varContentInv_id FOR UPDATE;

     /* Opening the LOB is mandatory */

     DBMS_LOB.OPEN(Src_loc, DBMS_LOB.LOB_READONLY);

     DBMS_LOB.LOADFROMFILE(Dest_loc, Src_loc, dbms_lob.getlength(Src_loc));

     /* Closing the LOB is mandatory */

     DBMS_LOB.CLOSE(Src_loc);

                    /* Optional update statement */

     UPDATE teste_ctx.CONTENT_INVENTORY

       SET TEXT_LOADED = 'Y'

       WHERE CONTENT_INVENTORY_ID = varContentInv_id;

     COMMIT;

   END IF;

end loop;

EXCEPTION

 WHEN OTHERS THEN

 RAISE_APPLICATION_ERROR (-20001, 'Error occurred while loading LOBs.');

 close ContentInv_cursor;

END;

/

 

set serveroutput on;

EXECUTE loadLOBFromBFILE;

 

begin

  ctx_ddl.create_preference('doc_lexer', 'BASIC_LEXER');

  ctx_ddl.set_attribute('doc_lexer', 'printjoins', '_-');

end;

/

 

 

 

create index idxContentMgmtBinary on TESTE_CTX.CONTENT_INVENTORY(TEXT)

indextype is ctxsys.context parameters ('lexer doc_lexer sync (on commit)');

 

select content_inventory_id, file_name

                from TESTE_CTX.content_inventory

                where contains(text,'Oracle') > 0;
