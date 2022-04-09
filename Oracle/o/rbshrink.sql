rem
rem
rem Script para "encolher os segmentos de rollback
rem
rem
set serveroutput on;
declare
	cursor rb is select * from dba_rollback_segs where status='ONLINE';
	rb_rec rb%rowtype;
	str varchar2(2000);
begin
	open rb;
	loop
		fetch rb into rb_rec;
		exit when rb%notfound;
		dbms_output.put_line(rb_rec.segment_name);
		str:='alter rollback segment '||rb_rec.segment_name||' shrink';
		execute immediate str;
	end loop;
	close rb;
end;
/