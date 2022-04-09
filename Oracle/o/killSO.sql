/*

   kill.sql - identificar e matar o processo via sistema operacional
   josivan

*/


1-na visao dinamica ( V$SESSION ) selecione o usuario atraves do atributo SID.

select sid
       ,serial#
       ,username
       ,osuser
       ,paddr 
from v$session
where username= 'BR_CONSULTA_PROD'
AND MACHINE= 'DCPM8232'
/


2-na visao dinamica ( V$PROCESS ) faca:

select spid
from v$process
where addr='ADABFF50'
/


  ( conteudo do atributo PADDR na consulta anterior )

3-mate o processo

  kill -9 <spid>

