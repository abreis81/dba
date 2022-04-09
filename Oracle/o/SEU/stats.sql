exec dbms_stats.gather_index_stats(ownname => 'SEUMIG', indname => 'IX_SEUABE_01', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE);
exec dbms_stats.gather_table_stats(ownname => 'SEUMIG', tabname => 'SEUACB', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,CASCADE=>TRUE);
exec dbms_stats.gather_schema_stats(ownname => 'SEUMIG', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE);