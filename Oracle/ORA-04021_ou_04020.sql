--DBAll.

--Tive um problema estranho esta noite, pois o banco de dados NW da OESP estava em operação e foi solicitado a realização de um alter table.
--Após isso, foram recompilados os objetos inválidos, porém um único dava timeout e não conseguíamos recompilá-lo.
--Matei todas as sessões antigas e que estavam inativas. Com as instruções que eu tinha não conseguia achar qual sessão estava  realizando um lock de objeto. Não conseguia dropar o objeto e tentei tudo o que eu poderia tentar.
--Após pesquisa encontrei a seguinte dica e a partir desta dica resolvi a questão. Essa query mostra todas as sessões que estão gerando os erros acima citados.


--FYI: You need to run the script called "catblock.sql" first. 
--===  This script can be found in:  $ORACLE_HOME/rdbms/admin/catblock.sql 
 

select /*+ ordered */ w1.sid  waiting_session,
	h1.sid  holding_session,
	w.kgllktype lock_or_pin,
        w.kgllkhdl address,
	decode(h.kgllkmod,  0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',
	   'Unknown') mode_held, 
	decode(w.kgllkreq,  0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',
	   'Unknown') mode_requested
  from dba_kgllock w, dba_kgllock h, v$session w1, v$session h1
 where
  (((h.kgllkmod != 0) and (h.kgllkmod != 1)
     and ((h.kgllkreq = 0) or (h.kgllkreq = 1)))
   and
     (((w.kgllkmod = 0) or (w.kgllkmod= 1))
     and ((w.kgllkreq != 0) and (w.kgllkreq != 1))))
  and  w.kgllktype	 =  h.kgllktype
  and  w.kgllkhdl	 =  h.kgllkhdl
  and  w.kgllkuse     =   w1.saddr
  and  h.kgllkuse     =   h1.saddr
/

