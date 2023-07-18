---
title: "Performing multiphonics on any pitched sound"
output: pdf_document
bibliography: bibliography.bib
---

## Abstract

Harmonics and multiphonics in string instruments are playing techniques typically performed by lightly touching a vibrating string. Digital waveguide models use recursive functions to model such strings. This paper introduces an explicit (non-recursive) formula for the touched string. This formulation can be easily rewritten as the output of an open (untouched) string with touch dependent coefficients and timeshifts, which effectively enables converting sounds of one kind to the other. Furthermore, the sounds to be converted are sounds of an open string only by assumption, in practice there're no such restrictions, this makes it possible to "perform" multiphonics with any pitched sound. Simplifying assumptions and necessary compromises are discussed as well as computation power issues and possible solutions.

The technique is approached from a sonic interaction design standpoint.

The explicit formula allows for coefficients, initial values and losses to be separate

## Introduction

Multiphonics, harmonics and prepared strings are three string instrument techniques based on partially blocking the string vibration at a single point. On the first two, the performer blocks the vibration, typically, by lightly touching (not fully pressing) the string with a finger. The vibration of a prepared string is blocked with an object such as a rubber or a bolt. Existing physical models are capable of modelling the touched string and performing the associated techniques. This paper proposes a way for abstracting the effect of touching a string, and applying it to other pitched sounds. In audio engineering terms, this paper starts with a touched string synth and proposes a touched string audio effect. Besides sonic and musical experimentation, this paper is motivated by the perceptual aspect of the proposed process. Abstracting an acoustic effect can retain its cross-modal corelation, making it useful for information encoding and intuitive for

Plucking a clamped string produces a standing wave, there's a number of ways to analyse this motion, each leading to a different modelling approach. This paper builds on digital waveguide synthesis, a modelling technique developed primarily by Julius Smith [@smith_physical_1992]. Waveguides use D'Alambert's principle to analyse a standing wave to the sum of two travelling waves, all parts of the model are described in terms of traveling waves and only at the final steps the two waves are summed to obtain the physical motion of the string. The traveling waves are propagating to opposite directions, propagation and reflection losses are modelled with filters, and termination reflections are performed with a sign and a direction inversion.

Not many publications investigate lightly touched string modelling per se, however, the touching point shares the same model with woodwind toneholes [@valimaki_modeling_1993] [@takala_expressive_2000]. Toneholes are modelled with a (traveling wave) scattering-junction (SJ), which is essentially a semi-permeable point. A wave arriving to a SJ is partially reflected and partially passed through. In this paper, the Kelly-Lochbaum SJ is used [@scavone_digital_1997].

analysing the touched string output (impulse response)[@guettler_bowed-string_2012]

analysing the output of a touched string model in term of its initial values (initial string displacement), the closest formulation to the waveguide model is a recursive function

τελευταια παραγραφος THIS PAPER PROPOSES...εξηγηση των κεφαλαιων επιγραμματικα

~~These techniques have two dimensions of control, the position of the vibration blocking (finger position) and the amount of pressure applied to the string (finger pressure).~~

new sounds, flexibility, cross modal corelation

<!-- Decoupling the touching part from a string model is similar, This is a process that is similar in principle to the decoupling of vowels from the human voice -->

<!-- Sonic interaction design takes advantage
motivation: tremolo/vibrato on synths, formants
sonic interaction: what parameter to map to a slider -->

## Multiphonics synthesis

although perceivable, a feed-forward comb filter doesn't have a particularly prominent effect.

Consider the case of a perfect string, propagation is described by $w^{(+),n}_l=w^{(+), n-1}_{l-1}$ and $w^{(-),n}_l=w^{(-), n-1}_{l+1}$ for right- and left-going waves respectively, and boundary conditions are described by $w^+(n)=-w^-(n)$. After these equations typical introduction to digital waveguide synthesis will present an implementation in code. However, a mathematical formulation of the implementation is needed. The non-physical output at the bridge (B) is a sequence of the following form $$y[1], y[2] \ldots y[T/2-2], y[T/2-1], y[T/2], -y[T/2], -y[T/2-1], -y[T/2-2]\ldots -y[2], -y[1], y[1], y[2] \ldots$$ where $T$ is the  time-steps needed for a roundtrip. The sequence is given by formula (1)

$$y[n] = -y[n - 2(n \mod T/2) - 1]$$ for $n > T/2$

where $a$ is the duration a roundtrip in samples, and $y[n]$ for $n \leq T/2$ gives the initial values of the string.

$$f[n]=f[n-T]r$$

where $T$ is the duration of a roundtrip and $f[n]$ for $n<T$ is a function $r$ reflection losses

$\lfloor \frac{n}{T} \rfloor$ functions as a counter for the number of roundtrips

writing an explicit formula of (1) $f(n)=f(n-\lfloor \frac{n}{T} \rfloor T)r^{\lfloor \frac{n}{T} \rfloor}$. Note that $0<n-\lfloor \frac{t}{T} \rfloor T<T$ for any $n$, the

The recursive formula 

Abbreviate trip notation by the letter of their intermediate node i.e. $BNB \equiv N$ trip $BFB \equiv F$

$f(n-\lfloor \frac{n}{T_F} \rfloor T_F-\lfloor \frac{n}{T_N} \rfloor T_N)$

Scattering coefficients $\rho^k(1-\rho)^n$

Let the initial values be given by $S(t)$ for $t < N$. There are two mechanisms of energy losses occurring on the input signal while it goes through the string. The scattering losses and the propagation losses. Since there are two types of roundtrips, the $F$-roundtrip (finger roundtrip) and the $N$-roundtrip (nut roundtrip), we assume that their corresponding loss coefficients are $a$ and $b$.

$f(t) = \sum_{k=0}^{n}\left(S(t - kT_m - nT_M)\binom{n+k}{k} (1 - \rho)^{k} \rho^n\right)$

Consider next a case where n roundtrips of types $F$ and $N$ respectively. The total number of such $m$ roundtrips is determined by considering the combinatorial problem of choosing $f$ scatterings of $F$ type out the off total $m = f + n$ scatterings. The answer is $\binom{m}{f}$. Equivalently we could ask the combinatorial problem of choosing n roundtrips of $N$ type out of the total $m = f + n$ roundtrips.

initial condition of the string - recursive function base case/beginning values

## Summary


## References

$f(t) = \sum_{k=0}^{n}\left(S(t - kT_m - nT_M)\binom{n+k}{k} (1 - \rho)^{k} \rho^n\right)$

$f(t) = (1-\rho)f(t-m) + \rho f(t-M)$
$M = am$
$f(t) = (1-\rho)f(t-m) + \rho f(t-M)$