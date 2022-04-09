create database sta03p
	character set WE8ISO8859P1
	datafile
	'/ora07/app/oracle/oradata/sta03p/dat/system01.dbf' size 150M
	logfile
	'/ora07/app/oracle/oradata/sta03p/rdo/log01.dbf' size 5M,
	'/ora07/app/oracle/oradata/sta03p/rdo/log02.dbf' size 5M,
	'/ora07/app/oracle/oradata/sta03p/rdo/log03.dbf' size 5M;
	maxdatafiles 150;

