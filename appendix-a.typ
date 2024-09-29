#import "common/constants.typ": m

The function of the untouched string
\
$y_(#text([nof]))(t) = y_(#text([in]))(t-floor(frac(t,T_N)) T_N)R_N^(floor(frac(t,T_N)))$ //@eq-rho0
\
is part of the explicit formula of the touched string @eq-explicit,
this relationship can shown by shifting $y_(#text([nof]))$ forward in time by $-k T_F$
\
$y_(#text([nof]))(t-k T_F) = y_(#text([in]))(t-k T_F-#m T_N)R_N^#m$
\
and using $m=#m$ to obtain
\
$y_(#text([nof]))(t-k T_F) = y_(#text([in]))(t-k T_F-m T_N)R_N^m$.
\
In this form it is easy to recognize $y_(#text([nof]))$ inside
\
$y_(#text([out]))(t)=sum_(k=0)^(floor(frac(t,T_F)))(y_(#text([in]))(t - k T_F - m T_N)binom(m+k,k) (1 - rho)^k rho^m R_N^m R_F^k)$ //@eq-explicit
\
and substituted with $y_(#text([nof]))(t-k T_F)$, resulting in
\
$y_(#text([out]))(t)=sum_(k=0)^(floor(frac(t,T_F)))(y_(#text([nof]))(t - k T_F)binom(m+k,k) (1 - rho)^k rho^m R_F^k)$.
