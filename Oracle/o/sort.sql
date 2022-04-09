select a.value "disk sorts", b.value "memory sorts",
round(a.value/(b.value+a.value)*100,2) "Disk Sort Porcentage"
from v$sysstat a, v$sysstat b
where a.name='sorts (disk)' and b.name = 'sorts (memory)';
