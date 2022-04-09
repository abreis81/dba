Prompt Nao pode ser maior que 1

select (req.value*5000)/entries.value "Ratio" 
from v$sysstat req, v$sysstat entries 
where req.name = 'redo log space requests'  
and entries.name = 'redo entries';
 