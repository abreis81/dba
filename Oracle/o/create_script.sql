 CONNECT system/manager@orat10.world
    CREATE USER repadmin IDENTIFIED BY repadmin;
    ALTER USER repadmin DEFAULT TABLESPACE ts_dados;
    ALTER USER repadmin TEMPORARY TABLESPACE ts_temp;

    GRANT connect, resource TO repadmin;
    EXECUTE dbms_repcat_admin.grant_admin_any_schema('repadmin');
    GRANT comment any table TO repadmin;
    GRANT lock any table TO repadmin;

    CREATE USER snapproxy IDENTIFIED BY snapproxy;
    ALTER USER snapproxy DEFAULT TABLESPACE ts_dados;
    ALTER USER snapproxy TEMPORARY TABLESPACE ts_temp;

    BEGIN
        dbms_repcat_admin.register_user_repgroup(
                username =>       'snapproxy',
                privilege_type => 'proxy_snapadmin',
                list_of_gnames =>  NULL);
    END;
/

    BEGIN
        dbms_repcat_admin.register_user_repgroup(
                username =>       'snapproxy',
                privilege_type => 'receiver',
                list_of_gnames =>  NULL);
    END;
/

    GRANT create session TO snapproxy;
    GRANT select any table to snapproxy;

    CREATE USER repdba IDENTIFIED BY repdba1;
    ALTER USER repdba DEFAULT TABLESPACE ts_dados;
    ALTER USER repdba TEMPORARY TABLESPACE ts_temp;
    GRANT connect, resource TO repdba;


rem
rem Then run the following script from sqlplus at each snapshot site :
rem

    CONNECT system/manager@orat11.world

    CREATE USER snapadmin IDENTIFIED BY snapadmin;
    ALTER USER snapadmin DEFAULT TABLESPACE ts_dados;
    ALTER USER snapadmin TEMPORARY TABLESPACE ts_temp;

    EXECUTE dbms_repcat_admin.grant_admin_any_schema('snapadmin');
    GRANT comment any table TO snapadmin;
    GRANT lock any table TO snapadmin;

    EXECUTE DBMS_DEFER_SYS.REGISTER_PROPAGATOR('snapadmin');

    GRANT create any snapshot TO snapadmin;
    GRANT alter any snapshot TO snapadmin;

    CREATE USER repdba IDENTIFIED BY repdba2;
    ALTER USER repdba DEFAULT TABLESPACE ts_dados;
    ALTER USER repdba TEMPORARY TABLESPACE ts_temp;

    GRANT connect, resource TO repdba;
    GRANT create table TO repdba;
    GRANT create snapshot TO repdba;

    CREATE PUBLIC DATABASE LINK orat10.world USING 'orat10.world';

    CONNECT snapadmin/snapadmin@orat11.world
    CREATE DATABASE LINK orat10.world
              CONNECT TO snapproxy IDENTIFIED BY snapproxy;

    CONNECT repdba/repdba2@orat11.world
    CREATE DATABASE LINK orat10.world
              CONNECT TO snapproxy IDENTIFIED BY snapproxy;

    CONNECT snapadmin/snapadmin@orat11.world
    BEGIN
       dbms_defer_sys.schedule_push(
           destination =>   'orat10.world',
           interval =>      '/*1:Mins*/ sysdate + 1/(60*24)',
           next_date =>     sysdate,
           stop_on_error => FALSE,
           delay_seconds => 0,
           parallelism =>   1);
    END;
/

    BEGIN
       dbms_defer_sys.schedule_purge(
           next_date =>        sysdate,
           interval =>         '/*1:Hr*/ sysdate + 1/24',
           delay_seconds =>    0,
           rollback_segment => '');
    END;
/
