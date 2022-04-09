prompt R-free - Shared Pool Reserved Size
prompt R_freea - memoria reservada que foi usada mas que esta disponivel
prompt free - quantidade total de memoria contigua
prompt freebl - memoria que foi usada mas que esta disponivel
prompt perm - memoria que ainda nao foi movida para a area livre porque esta sendo usada
prompt rect - memoria reservada para o Oracle???

compute sum of bytes on report;
break on report;
select sum(ksmchsiz) bytes, ksmchcls status
from sys.x$ksmsp
group by ksmchcls;
prompt somar os valores de free e perm, 
prompt dividir pela somatoria acima e depois multiplicar por 100
prompt porc. ideal: entre 10-25/%
