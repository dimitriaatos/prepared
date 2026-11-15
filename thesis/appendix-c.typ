// ignore this error, this file is included in the main file which has access to the bibliography
The following z-transform transfer functions are are given by @pakarinen_physical_2005:

- touched string loop \ $S(z) = 1 / (1 - [delta(z) + epsilon(z) + zeta(z)])$
- bridge-finger-bridge roundtrip \ $delta(z) = R_b(z) H_(R 2, alpha_2)(z) rho_4 H_(b_2, E 1)(z) H_(E 1, R 1)(z)$
- bridge-nut-bridge roundtrip \ $epsilon(z) = R_b(z) H_(R 2, alpha_2)(z) rho_2 H_(b_1, alpha_1)(z) rho_3 H_(b_2, R 1)(z)$
- bridge-nut-finger-nut-bridge roundtrip \ $zeta(z) = R_b(z) H_(R 2, alpha_2)(z) rho_2 H_(b_1, alpha_1)(z) rho_1 H_(b_1, alpha_1)(z) rho_3 H_(b_2, R 1)(z)$.

Acounting for simplification presentin in @eq-rho:

- $rho_1 = rho_4$
- $rho_2 = rho_3$

and the _single-sided_ SJ simplification which eliminates one of the $rho_2$ coefficient on the $epsilon$ path and the entire $zeta$ path, leaves us with the simplified versions of $delta$, $epsilon$ and $S$ named $delta_s$, $epsilon_s$ and $S_s$ respectively:

$
delta_s(z) = R_b(z) H_(R 2, alpha_2)(z) rho_1 H_(b_2, E 1)(z) H_(E 1, R 1)(z)
$

$
epsilon_s(z) = R_b(z) H_(R 2, alpha_2)(z) rho_2 H_(b_1, alpha_1)(z) H_(b_2, R 1)(z)
$

$
S_s(z) = 1 / (1 - [delta_s(z) + epsilon_s(z)])\
= 1 / (1 - (
R_b(z) H_(R 2, alpha_2)(z) rho_1 H_(b_2, E 1)(z) H_(E 1, R 1)(z)
+ R_b(z) H_(R 2, alpha_2)(z) rho_2 H_(b_1, alpha_1)(z) H_(b_2, R 1)(z)
))
$

Replacing the path segments with their definitions, as defined in @pakarinen_physical_2005,
- $H_(R 2, alpha_2)(z) = z^(2d_2 + d_3)$
- $H_(b_2, E 1)(z) = z^(d_2)$
- $H_(E 1, R 1)(z) = z^(d_3)$
- $H_(b_1, alpha_1)(z) = R_f(z) z^(2d_1)$
- $H_(b_2, R 1)(z) = z^(d_2 + d_3)$

we get
$
S_s(z) = 1 / (1 - (
R_b(z) rho_1 z^(2d_2 + 2d_3)
+ R_b(z) R_f(z) rho_2 z^(2d_1 + 2d_2 + 2d_3)
))
$

and defining the following:

- bridge-nut roundtrip duration \ $T_N = 2d_1 + 2d_2 + 2d_3$
- bridge-finger roundtrip duration \ $T_F = 2d_2 + 2d_3$
- finger losses \ $R_F(z) = R_b(z)$
- nut losses \ $R_N(z) = R_b(z) R_f(z)$

$
S_s(z) = 1 / (1 - (
R_F(z) rho_1 z^(T_F)
+ R_F(z) rho_2 z^(T_N)
))
$

$
S_s(z) = Y(z) / X(z)
= 1 / (1 - (
R_F(z) rho_1 z^(T_F)
+ R_F(z) rho_2 z^(T_N)
))
$

$
Y(z) = rho_1 Y(z) z^(T_F) R_F (z)
+ rho_2 Y(z) z^(T_N) R_N (z) X(z)
+ X(z)
$

Simlifying $R_F (z)$ and $R_N (z)$ to constant coefficients $r_F$ and $r_N$ respectively

$
Y(z) = rho_1 Y(z) z^(T_F) r_F
+ rho_2 Y(z) z^(T_N) r_N X(z)
+ X(z)
$

$
y[n] = rho_1 y[n - T_F] r_F
+ rho_2 y[n - T_N] r_N
+ x[n]
$
