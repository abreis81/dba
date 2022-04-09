create or replace procedure sinc_t1
is
cursor c_pk is select c1 from scott.t1@orat11.world where c1 not in (select c1 from scott.t1);

begin
	dbms_reputil.replication_off;
	for pks in c_pk loop
		insert into scott.t1 (select * from scott.t1@orat11.world where c1=pks.c1);
	end loop;
	commit;
end;
/