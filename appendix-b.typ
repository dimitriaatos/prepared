#import "common/constants.typ": m

Starting from the expression of the untouched string
\
$y_(#text([nof]))(t) = y_(#text([in]))((frac(t,T_N)-floor(frac(t,T_N)))T_N)R_N^floor(frac(t,T_N))$,
\
we give a separate definition to the lossless signal of the untouched string, as follows
\
$y_(#text([nol])) = y_(#text([in]))((frac(t,T_N)-floor(frac(t,T_N)))T_N)$,
\
and rewriting $y_(#text([nof]))$ accordingly
\
$y_(#text([nof]))(t) = y_(#text([nol]))(t)R_N^floor(frac(t,T_N))$.
\
$y_(#text([out]))(t)=sum_(k=0)^floor(frac(t,T_F))(y_(#text([nol]))(t - k T_F)binom(m+k,k) (1 - rho)^k rho^m R_N^#m R_F^k)=$
\
We assume that $R_F=R_N$
\
$y_(#text([out]))(t)=sum_(k=0)^floor(frac(t, T_F))(y_(#text([nol]))(t - k T_F)binom(m+k, k)(1 - rho)^k rho^m R_N^(#m+k))=$
#v(2em)
$sum_(k=0)^floor(frac(t, T_F))(y_(#text([nol]))(t - k T_F)binom(m+k, k)(1 - rho)^k rho^m R_N^floor(frac(t - k T_F + k T_N, T_N)))=$
#v(2em)
$sum_(k=0)^floor(frac(t, T_F))(y_(#text([nol]))(t - k T_F + k T_N)binom(m+k, k)(1 - rho)^k rho^m R_N^floor(frac(t - k T_F + k T_N, T_N)))=$
\
$sum_(k=0)^floor(frac(t, T_F))(y_(#text([nof]))(t - k T_F + k T_N)binom(m+k, k)(1 - rho)^k rho^m)$
