select round((1-(sum(decode(name,'physical reads',value,0))
/(sum(decode(name,'db block gets',value,0))
+sum(decode(name,'consistent gets',value,0))))),2)
"data buffer hit ratio"
from v$sysstat;
