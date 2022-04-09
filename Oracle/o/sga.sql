select pool
       name,
       sgasize/1024/1024 "Allocated (M)",
       bytes/1024 "Free (K)",
       round(bytes/sgasize*100, 2) "% Free"
from   (select sum(bytes) sgasize from sys.v_$sgastat) s, sys.v_$sgastat f
where  f.name like 'free memory';
