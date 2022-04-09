select round((1-(sum(getmisses)/sum(gets))),2) "dictionary Hit Ratio"
from v$rowcache;
