# wavetable shifts

$sin$ has a period of $2\pi$

$sin(x)=sin(x+2\alpha\pi)$, for $\alpha\in\mathbb{Z}$

---

when $\alpha=-\left\lfloor \frac{x}{2\pi} \right\rfloor$

$
sin(x)=sin(x-\left\lfloor \frac{x}{2\pi} \right\rfloor2\pi)
$

$
sin(x)=sin\left[\left(\frac{x}{2\pi} - \left\lfloor \frac{x}{2\pi} \right\rfloor\right) 2\pi\right]
$

Shifting by $-k$

$
sin(x-k)=sin\left[\left(\frac{x-k}{2\pi} - \left\lfloor \frac{x-k}{2\pi} \right\rfloor\right) 2\pi\right]
$

---

Generalizing, for a function $f(x)$, with period $p$

$f(x)=f(x+\alpha p)$, for $\alpha\in\mathbb{Z}$

when $\alpha=-\left\lfloor \frac{x}{p} \right\rfloor$

$
f(x)=f(x-\left\lfloor \frac{x}{p} \right\rfloor p)
$

$
f(x)=f\left[\left(\frac{x}{p} - \left\lfloor \frac{x}{p} \right\rfloor\right) p\right]
$

Shifting by $-k$

$
f(x-k)=f\left[\left(\frac{x-k}{p} - \left\lfloor \frac{x-k}{p} \right\rfloor\right) p\right]
$

---

<!-- $y(n - (k T_F + mT_N))$ -->

$\sum_{k=0}^{\lfloor \frac{n}{T_F} \rfloor}\left(y[n - (kT_F + mT_N)]\binom{m+k}{k} (1 - \rho)^{k} \rho^mR_N^mR_F^k\right)$

<!-- Function $z[n]$ is a repetitive function with a period of $T_N$, $y[n] = z[n]$ for $0\leq n <T_N$ (the first cycle of $z[n]$). We take a wavetable approach to construct $g[n]$ by repeating the a part in question of $y[n]$. -->

$
y\left[\left(\frac{n - kT_F}{T_N} - \left\lfloor \frac{n - kT_F}{T_N} \right\rfloor\right) T_N\right]
$

<!-- $y[n -k T_F - \lfloor \frac{n-kT_F}{T_N} \rfloor T_N]$ -->

<!-- $z[n] = y\left[\left(\frac{n}{T_N} - \left\lfloor \frac{n}{T_N} \right\rfloor\right) T_N\right]$ -->

$z[n-kT_F] = y\left[\left(\frac{n - kT_F}{T_N} - \left\lfloor \frac{n - kT_F}{T_N} \right\rfloor\right) T_N\right]$

$y[n]$ can be viewed as the excitation signal of a string, and $z[n]$ as the traveling wave on the string. A sequence of values is used as input, the sequence should theoretically be produced by a process of the following form

$\rho=1 => k=0$

$g[n] = z[n]R_N^{\lfloor\frac{n}{T_N}\rfloor}$,

note that $z[n]$ and $R_N$ are unknown and only their product is known.

$g[n-kT_F]R_F^{k} = z[n-kT_F]R_N^{\lfloor\frac{n-kT_F}{T_N}\rfloor}R_F^{k}$

$R_F$ is also unknown, we assume that $R_F=R_N$

$g[n-kT_F]R_F^{k} = z[n-kT_F]R_N^{\lfloor\frac{n-kT_F}{T_N}\rfloor+k}$

$g[n-kT_F]R_F^{k} = z[n-kT_F]R_N^{\lfloor\frac{n-kT_F+kT_N}{T_N}\rfloor}$

$g[n-kT_F]R_F^{k} = z[n-kT_F + kT_N]R_N^{\lfloor\frac{n-kT_F + kT_N}{T_N}\rfloor}$

$g[n-kT_F]R_F^{k} = g[n-kT_F+kT_N]$

$g[n + k(T_N - T_F)]$

$\sum_{k=0}^{\lfloor \frac{n}{T_F} \rfloor}\left(g[n-kT_F+kT_N]\binom{m+k}{k} (1 - \rho)^{k} \rho^m\right)$

These shifts move signal backwards in time i.e. they require future values of $g[n]$. This is realistic where values of $g[n]$ are available beforehand for reasonably large values of $n$. On a real-time implementation future values are not available making shifting from future signal impossible
