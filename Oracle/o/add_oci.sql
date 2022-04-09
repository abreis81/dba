#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <oci.h>

#pragma comment(lib, "d:\\orant\\oci80\\lib\\msvc\\ora803.lib")

static OCIEnv           *p_env;
static OCIError         *p_err;
static OCISvcCtx        *p_svc;
static OCIStmt          *p_sql;
static OCIDefine        *p_dfn    = (OCIDefine *) 0;
static OCIBind          *p_bnd    = (OCIBind *) 0;

void main()
{
   int             p_bvi;
   char            p_sli[20];
   int             rc;
   char            errbuf[100];
   int             errcode;

   rc = OCIInitialize((ub4) OCI_DEFAULT, (dvoid *)0,  /* Initialize OCI */
           (dvoid * (*)(dvoid *, size_t)) 0,
           (dvoid * (*)(dvoid *, dvoid *, size_t))0,
           (void (*)(dvoid *, dvoid *)) 0 );

   /* Initialize evironment */
   rc = OCIEnvInit( (OCIEnv **) &p_env, OCI_DEFAULT, (size_t) 0, (dvoid **) 0 );

   /* Initialize handles */
   rc = OCIHandleAlloc( (dvoid *) p_env, (dvoid **) &p_err, OCI_HTYPE_ERROR,
           (size_t) 0, (dvoid **) 0);
   rc = OCIHandleAlloc( (dvoid *) p_env, (dvoid **) &p_svc, OCI_HTYPE_SVCCTX,
           (size_t) 0, (dvoid **) 0);

   /* Connect to database server */
   rc = OCILogon(p_env, p_err, &p_svc, "scott", 5, "tiger", 5, "d458_nat", 8);
   if (rc != 0) {
      OCIErrorGet((dvoid *)p_err, (ub4) 1, (text *) NULL, &errcode, errbuf, (ub4) sizeof(errbuf), OCI_HTYPE_ERROR);
      printf("Error - %.*s\n", 512, errbuf);
      exit(8);
   }

   /* Allocate and prepare SQL statement */
   rc = OCIHandleAlloc( (dvoid *) p_env, (dvoid **) &p_sql,
           OCI_HTYPE_STMT, (size_t) 0, (dvoid **) 0);
   rc = OCIStmtPrepare(p_sql, p_err, "select ename from emp where deptno=:x",
           (ub4) 37, (ub4) OCI_NTV_SYNTAX, (ub4) OCI_DEFAULT);

   /* Bind the values for the bind variables */
   p_bvi = 10;     /* Use DEPTNO=10 */
   rc = OCIBindByName(p_sql, &p_bnd, p_err, (text *) ":x",
           -1, (dvoid *) &p_bvi, sizeof(int), SQLT_INT, (dvoid *) 0,
           (ub2 *) 0, (ub2 *) 0, (ub4) 0, (ub4 *) 0, OCI_DEFAULT);

   /* Define the select list items */
   rc = OCIDefineByPos(p_sql, &p_dfn, p_err, 1, (dvoid *) &p_sli,
           (sword) 20, SQLT_STR, (dvoid *) 0, (ub2 *)0,
           (ub2 *)0, OCI_DEFAULT);

   /* Execute the SQL statment */
   rc = OCIStmtExecute(p_svc, p_sql, p_err, (ub4) 1, (ub4) 0,
           (CONST OCISnapshot *) NULL, (OCISnapshot *) NULL, OCI_DEFAULT);

   while (rc != OCI_NO_DATA) {             /* Fetch the remaining data */
      printf("%s\n",p_sli);
      rc = OCIStmtFetch(p_sql, p_err, 1, 0, 0);
   }

   rc = OCILogoff(p_svc, p_err);                           /* Disconnect */
   rc = OCIHandleFree((dvoid *) p_sql, OCI_HTYPE_STMT);    /* Free handles */
   rc = OCIHandleFree((dvoid *) p_svc, OCI_HTYPE_SVCCTX);
   rc = OCIHandleFree((dvoid *) p_err, OCI_HTYPE_ERROR);

   return;
}

Back to top of file 
--------------------------------------------------------------------------------

How does one compile and link an OCI program?
Write an OCI program (e.g. myoci.c). You can find examples in the $ORACLE_HOME/rdbms/demo directory.

Copy the make file $ORACLE_HOME/rdbms/demo/demo_rdbms.mk into the directory where your OCI program is located. You can also copy some of the sample OCI files (cdemo1.c, etc.) provided by Oracle to compile and link.

Issue the following command
	make -f demo_rdbms.mk build EXE=cdemo1 OBJS=cdemo1.o

