# equations

$\sum_{k=0}^{\lfloor \frac{n}{T_F} \rfloor}\left(S(n,k)P(n,k)C(n,k)\right)$

## open string

$y[n] = -y[n - 2(n \mod T/2) - 1]$

$y_n = y[n-T], n \geq T$

## touched string

$y[n] = \rho y[n-T_N] + (1-\rho)^2 y[n-T_F]$

---

$y[n] = y[n] + y[n-T_F], T_N > x > T_F$

$y[n] = y[n-T_N] + y[n-T_F], x \geq T_N$

$y[n] = \rho y[n-T_N] + (1-\rho) y[n-T_F]$

$f[n] = \rho y[t-T_N] + (1-\rho) y[t-T_F]$

$
f(t) = \sum_{k=0}^{\lfloor \frac{t}{T_N} \rfloor}\left(f(t - k T_N - n T_F)\binom{n + k}{k}(1 - \rho)^{k} \rho^{n}\right)
$

## Proof

$T_N > T_F$, $T_N \approx T_F$

$
f(t) = \rho f(t-T_N) + (1-\rho) f(t-T_F)
$

$
f(t) = \\
  1 \rho^1 (1-\rho)^0 f(t-0T_F-1T_N) + \\
  1 \rho^0 (1-\rho)^1 f(t-1T_F-0T_N), \\
  T_N<t
$

$
f(t) = \\
  1 \rho^2 (1-\rho)^0 f(t-0T_F-2T_N) + \\
  2 \rho^1 (1-\rho)^1 f(t-1T_F-1T_N) + \\
  1 \rho^0 (1-\rho)^2 f(t-2T_F-0T_N), \\
	2T_N<t
$

$
f(t) = \\
  1 \rho^3 (1-\rho)^0 f(t-0T_F-3T_N) + \\
  3 \rho^2 (1-\rho)^1 f(t-1T_F-2T_N) + \\
  3 \rho^1 (1-\rho)^2 f(t-2T_F-1T_N) + \\
  1 \rho^0 (1-\rho)^3 f(t-3T_F-0T_N), \\
	3T_N<t
$

$
f(t) =\\
  1 \rho^4 (1-\rho)^0 f(t-0T_F-4T_N) + \\
  4 \rho^3 (1-\rho)^1 f(t-1T_F-3T_N) + \\
  6 \rho^2 (1-\rho)^2 f(t-2T_F-2T_N) + \\
  4 \rho^1 (1-\rho)^3 f(t-3T_F-1T_N) + \\
  1 \rho^0 (1-\rho)^4 f(t-4T_F-0T_N), \\
	4T_N<t
$
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
$
f(n) = \sum_{k=0}^{\lfloor \frac{n}{T_N} \rfloor}\left(y(n - (k T_F + m T_N))\binom{m+k}{k}(1 - \rho)^{k} \rho^{m}\right)
$

$
y(n -k T_F - \lfloor \frac{n-kT_F}{T_N} \rfloor T_N)
$

$
y(n -k T_F - \lfloor \frac{n}{T_N}-\frac{kT_F}{T_N} \rfloor T_N)
$

$
y(n -k T_F - \lfloor \frac{n}{T_N}-\frac{kT_F}{T_N} \rfloor T_N + \lfloor \frac{n}{T_N} \rfloor T_N - \lfloor \frac{n}{T_N} \rfloor T_N)
$

$
y'(n -k T_F - \lfloor \frac{n}{T_N}-\frac{kT_F}{T_N} \rfloor T_N + \lfloor \frac{n}{T_N} \rfloor T_N)
$

$
y'(n -k T_F + ( \lfloor \frac{n}{T_N} \rfloor - \lfloor \frac{n}{T_N}-\frac{kT_F}{T_N} \rfloor) T_N)
$

$
y'(n -k T_F + ( \lfloor \frac{n}{T_N} \rfloor - \lfloor \frac{n}{T_N}-\frac{kT_F}{T_N} \rfloor) T_N)
$

$
y(n-\lfloor \frac{n}{T_N} \rfloor T_N)
$

$
f(n) = \sum_{k=0}^{\lfloor \frac{n}{T_N} \rfloor}\left(y(n + k(T_N - T_F))\binom{m+k}{k}(1 - \rho)^{k} \rho^{m}\right)
$

---

$
y'(n + k(T_N - T_F)) \\
y'(n + kT_N - kT_F) \\
y(n - \lfloor\frac{n}{T_N}\rfloor T_N + kT_N - kT_F) \\
y(n - (\lfloor\frac{n}{T_N}\rfloor - k ) T_N - kT_F) \\
y(n - (kT_F + (\lfloor\frac{n}{T_N}\rfloor - k ) T_N)) \\
y(n - (kT_F + (\lfloor\frac{n}{T_N}-k\rfloor ) T_N)) \\
y(n -k T_F - \lfloor \frac{n-kT_Ν}{T_N} \rfloor T_N) \\
$
$
y(n -k T_F - \lfloor \frac{n-kT_F}{T_N} \rfloor T_N)
$

---

$
y(n -k T_F - \lfloor \frac{n-kT_F}{T_N} \rfloor T_N)
$

---

$
f(t - T_F)\binom{n}{0} \rho +
f(t - T_N - T_F)\binom{2}{1}(1 - \rho) \rho
$

$
f(t) = \rho f(t-M) + (1-\rho) f(t-m)
$

$
f(t) = \rho f(t-M) + (1-\rho) f(t-m)
$

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

$\lfloor \frac{t-kT_F}{T_N} \rfloor T_N = \lfloor \frac{t}{T_N} \rfloor T_N - kT_F$