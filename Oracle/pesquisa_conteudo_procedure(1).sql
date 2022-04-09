--################################################################
-- Lista o conteúdo de Package,Procedures,Functions e Triggers
--################################################################

set lines 140
col line for 99
col text for a135
SELECT 		--line,
		text 
FROM 		dba_source
WHERE		upper(name) like 'TRG_033_BLOQUEIA_FORMA_PAGTO'
AND		owner = 'CARGOPROD'
ORDER BY	line;