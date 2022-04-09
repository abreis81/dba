prompt colocar o valor do p1raw para ver quem está provocando o library cache pin

SELECT s.sid, kglpnmod "Mode", kglpnreq "Req"
    FROM x$kglpn p, v$session s
   WHERE p.kglpnuse=s.saddr
     AND kglpnhdl='&P1RAW'
  ;