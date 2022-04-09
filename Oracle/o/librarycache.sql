select sum(pins) "Total Pins",
sum(reloads) "total reloads",
round((1-(sum(reloads)/sum(pins))),2) "Hit Ratio"
from v$librarycache;
