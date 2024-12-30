#import "@preview/charged-ieee:0.1.2": ieee
#import "@preview/unify:0.6.0": num, qty, numrange, qtyrange, unit
#import "common/constants.typ": m, y
#import "common/helpers.typ": appendix
#import "figures/triangle.typ": triangle

#ieee(
  title: [Performing string multiphonics on any pitched sound],
  abstract: [
    Multiphonics and flageolet tones on string instruments are performed by lightly touching the vibrating string.
    This paper investigates physical models of the lightly touched string and develops a model where the untouched string and the touching finger are split in separate parts.
    This separation allows for replacing the untouched string model with an arbitrary sound and applying the effect of the finger to it.
    In practice, this means that flageolet tones and string multiphonics can be applied to non-string sounds, like sounds of other instruments and synthesized electronic sounds.
    The proposed model is developed in the form of a non-recursive, time-based formula.
    A software implementation of the touching finger model is presented and used in a small scale evaluation study.
    Limitations are identified and possible solutions discussed.
    Beyond the case of the touching finger, a wider research objective is proposed, aimed at abstracted modelling of acoustic qualities and effects.
  ],
  authors: (
    (
      name: "Dimitrios Aatos Ellinas",
      department: [Interactive Media Technology],
      organization: [KTH Royal Institute of Technology],
      location: [Stockholm, Sweden],
      email: "ellinas@kth.se",
    ),
  ),
  index-terms: ("physical modelling", "audio effects"),
  paper-size: "a4",
  bibliography: bibliography("refs.bib"),
)[
  #show math.equation: set text(8.5pt)

  = Introduction
  Consider a musician playing a piece of music on an acoustic instrument and wishing to play the same piece on a synthesizer.
  While pitch and loudness are easily transferable to a synth, it's not equally trivial to transfer timbral effects from acoustic to synthesized sounds.
  A skilled sound designer might be able to program a synthesizer to simulate timbral techniques of an acoustic instrument, but will inevitably reach the limits of simulation.
  The usual alternative to simulation is physical modelling, where, instead of simulating the sound itself, the physical phenomena leading to the sound are simulated.
  Physical modelling is often able to create high quality synthesized versions of acoustic sounds, including timbral techniques.
  The main obstacle for the task in question is that physical models are designed for synthesizing sounds that incorporate the desired timbral effects, rather than letting their user choose the sound to which the effect will be applied to.
  This paper aims to overcome that obstacle for the acoustic effects based on lightly touching a string.

  Lightly touching a vibrating string is a practice associated with a number of string instrument playing techniques.
  Depending on the touching position and the touching agent, a different technique is performed.
  Flageolet tones (harmonics) are performed by lightly touching a string with a finger on specific fractions of its length.
  The produced sound has a pitch much higher than the original string and a different timbre, comparable to a whistle @kamien_music_2008[p.~13].
  Multiphonics is a technique where single pitch sound sources produce sounds with more than one perceivable pitch.
  They are often performed on wind instruments and, although less popular, can also be performed on plucked strings @torres_multiphonics_2012-1, @torres_multiphonics_2012-2.
  Plucked string multiphonics are achieved by lightly touching the string at positions other than those producing harmonics, their timbre has a bell like quality @torres_multiphonics_2012-1.
  Prepared strings is another technique where instead of a finger, a variety of objects such as rubbers, bolts or crocodile clips may be attached to the string, the position of the object might be either that of an multiphonic or a harmonic.

  Modelling the lightly touched string techniques in a way that allows them to be applied to arbitrary sounds is viewed as part of a wider research objective with additional applications.

  Extending

  // Applying acoustic effects to synths or arbitrary sounds can be attractive for creative purposes, acoustic techniques can bring physical qualities to synthesized sounds.
  // Incorporating physicality in sound synthesis serves more than just aesthetics, a well modelled acoustic technique may involve recognizable parameters that can be utilized for information encoding, sonification and interaction design.

  = Background
  Numerous developments in the history of electronic music could be viewed as attempts to bridge electronic and acoustic sounds.
  Common concepts in sound synthesis have been brought from the acoustic world, such as the ADSR envelope (attack, decay, sustain, release) and spatial audio effects like reverb and echo.
  Although timbre specific effects have mainly been part of sound synthesis there are some cases where the timbral effects are independent from the sound source.
  Formant filters or models of the human vocal tract are typically applied to arbitrary synthesizers to produce robot voices.
  The _talking bass_ (or _YaYa bass_) in dubstep #footnote([Dubstep is a genre of electronic dance music.]) is a similar case, that combines a low pass filtering and sample rate reduction to create vocal qualities. There are no academic publications on _YaYa bass_ but online tutorials reveal @audio_digital_how_2014, @dorincourt_reason_2010.
  Lastly, _linear arithmetic synthesis_ @russ_l_1987 is a sound synthesis technique where recorded attacks of acoustic instruments are placed on the onset of synthesized tones, creating hybrids that have both acoustic and synthesized qualities.

  The open and lightly touched string has been modelled and decomposed in the following papers.
  Matti Karjalainen et al. in @karjalainen_plucked-string_1998 decompose the model of the open string in modules for _string excitation_, the _string_ itself, _pickup mic_ and _bridge_.
  In @pakarinen_physical_2005, Jyri Pakarinen adapts these modules to include a touching finger.
  Guttler and Thelin in @guettler_bowed-string_2012 take a different approach, providing an analysis of a touched string's impulse response, explaining step-by-step how its waveform is constructed.

  // filter violin body @holm_modeling_2000

  = The lightly touched string
  This paper relies on _digital waveguide_ (DWG) synthesis @smith_physical_1992, a _physical modelling_ technique that employs D'Alambert's principle to analyse a standing wave (e.g. a vibrating string) into the sum of two travelling waves propagating in opposite directions.
  All parts of the model are described in terms of traveling waves which are combined in the final step to produce the physical motion of the string.
  Propagation losses are modelled with filters, and termination reflections are implemented with a direction inversion, a reflection loss filter and a sign inversion (often implemented as part of the loss filter).
  @fig-pickup depicts a DWG model of a simple plucked string with a pickup output.
  Although the string touching agent may vary, it will be referred to as the _finger_.
  The terms _bridge_ and _nut_ will be used for the left and the right termination, respectively.

  #figure(
    include "figures/wg.typ",
    caption: [A digital waveguide model of a string with a pickup output.
      Where $N$ is the duration of a roundtrip.],
    placement: none,
  )<fig-pickup>


  The touching point has been modelled in DWG synthesis as a three-port scattering-junction (SJ) @scavone_digital_1997 @valimaki_modeling_1993.
  This splits the model into three waveguides meeting at the SJ, one leading to the _nut_, one leading to the _bridge_ and one leading to the _finger_.
  Since the _finger_ waveguide contains only a lossless reflection the SJ can be simplified as suggested in @pakarinen_physical_2005.
  A string model with a simplified _finger_ SJ is depicted in @fig-waveguide_sj.
  The SJ coefficients $rho_1 - rho_4$ are defined in @pakarinen_physical_2005 as

  $
    rho_1=(Z_1-Z_2-Z_3) / (Z_1+Z_2+Z_3) wide rho_2=(2Z_2) / (Z_1+Z_2+Z_3) \
    rho_3=(2Z_1) / (Z_1+Z_2+Z_3) wide rho_4=(Z_2-Z_1-Z_3) / (Z_1+Z_2+Z_3)
  $

  where $Z_1$, $Z_2$ and $Z_3$ denote the impedance of the _bridge_, _nut_ and _finger_ waveguides, respectively.
  As the _bridge_ and _nut_ waveguides are part of the same string, their impedances should be equal, thus we have $Z_1=Z_2$.
  Consequently, this equality leads to $rho_1=rho_4$ and $rho_2=rho_3$, leaving only coefficients $rho_1$ and $rho_2$.
  Both can be expressed in relation to

  $ rho=(Z_3) / (2Z_1+Z_3) $ <eq-rho>
  #align(center, [as $rho_1=-rho$ and $rho_2=1-rho$])

  The impedance $Z_3$ of the _finger_ waveguide varies depending on the pressure applied to the string.
  The state of the SJ should span from disabled (no _finger_) to a total reflection (the _finger_ acting as a termination), this implies that $0 lt.eq rho lt.eq 1$.

  #figure(
    include "figures/wg-sj.typ",
    caption: [A digital waveguide model with a scattering junction. \ _Bridge-finger_ loop (red), _finger-nut_ loop (green) and _bridge-nut_ loop (blue)],
    placement: none,
  )<fig-waveguide_sj>

  To reduce the computational complexity of the proposed model, the scattering of waves from the nut to the finger is disregarded.
  This means that no reflections or coefficient multiplications occur from _nut_ to _bridge_.
  This SJ will be referred to as the _single-sided_ SJ, a depiction can be seen in @fig-waveguide_simple_sj.
  Although this might seem like a crude simplification, comparing audio outputs reveals that the only discernible effect of the _single-sided_ SJ is a "metallic" or "rough" quality (evaluated in #ref(<evaluation>)), which is an acceptable compromise for the purpose of this paper.

  #figure(
    include "figures/wg-simple-sj.typ",
    caption: [A digital waveguide with a simplified scattering junction.],
    placement: none,
  )<fig-waveguide_simple_sj>

  As previously mentioned, the SJ is the meeting point for three waveguides.
  This results in the formation of one loop for each combination of waveguides, namely the _bridge-finger_ loop, the _bridge-nut_ loop, and the _finger-nut_ loop.
  Using the _single-sided_ SJ eliminates the _finger-nut_ loop, leaving only the _bridge-finger_ and the _bridge-nut_ loop, also referred to as $F$- and $N$-roundtrips.

  = Explicit model
  // wavetable synthesis, phase accumulator, unipolar sawtooth wave
  In @pakarinen_physical_2005 a touched string DWG model is decomposed to three parts, namely, _plucking position_, _touched string_, and _pickup output_.
  The touched string part can be used as a starting point for obtaining a model for only the finger.
  At first, the _finger-nut_ loop needs to be removed.
  @fig-sdl_simple_sj depicts an _string loop_ model that includes the touching finger using a _single-sided_ SJ, it consists of two coupled loops and their corresponding coefficients.
  By detaching the finger ($rho = 1$), it's easy to distinguish what parts are relevant to the finger (red) and to the string (blue).
  This depiction, as most DWG models, shows a recursive process, where the effect of the string and the finger is applied to previous results.
  In order to isolate the overall effect of a finger to a string, an explicit formula is proposed, where string looping, losses and finger coefficients are applied to the initial excitation signal.

  #figure(
    [a],
    caption: [String loop with a scattering junction.
      $N$-roundtrip (blue), $F$-roundtrip (red)],
    placement: none,
  )<fig-sdl_simple_sj>

  // similar to the approach taken in @guettler_bowed-string_2012.

  For an initial excitation signal $y_(#text([in]))(t)$, the traveling wave of a touched string is given by

  $
    y_(#text([out]))(t)=sum_(k=0)^floor(frac(t,T_F))(y(t - k T_F - m T_N)binom(m+k,k) (1 - rho)^k rho^m R_N^m R_F^k)
  $ <eq-explicit>
  #align(center, [for $T_F<T_N<t #text([and]) 0 lt.eq rho lt.eq 1$])

  Here, the variables and terms used are defined as follows:
  - $t$ denotes the current time,
  - $T_N$ and $T_F$ denote the duration of the $N$ and $F$ roundtrips, respectively,
  - $rho$ is the finger pressure coefficient defined in @eq-rho,
  - $R_N$ and $R_F$ denote the reflection and propagation losses of $N$ and $F$ roundtrips, respectively, and
  - $m$ is defined as
  $ m = #m $
  <eq-m>
  The initial values are given by $y(t)$ for $0 lt.eq t < T_N$.
  Each addend of the sum calculates the signal produced after $k$ $F$-roundtrips and $m$ $N$-roundtrips in a given time $t$.
  The argument of the summation in @eq-explicit can be split into four parts,
  - shifts $ y(t - k T_F - m T_N) $<eq-shifts>
  - permutations $ binom(m+k,k) $ <eq-perm>
  - coefficients $ (1 - rho)^k rho^m $<eq-coef>
  - and losses $ R_N^m R_F^k $<eq-loss>.
  Firstly, @eq-shifts loops the excitation signal by shifting it forward in time by an amount proportional to the number of $N$- and $F$-roundtrips performed.
  Variables $m$ and $k$ work as counters for the number of complete $N$ and $F$-roundtrips respectively.
  A depiction of the shifts can be seen in Figure @eq-shifts.
  The first @fig-shifts (1) plot starts with the initial excitation signal (thicker stoke), followed by shifts of $N$-roundtrips, i.e. multiples of $T_N$.
  Since $T_F<T_F$, $F$-roundtrip shifts will fall on top of $N$-roundtrip shifts in the current depiction (dotted lines).
  In order to avoid a confusing illustration, shifts starting with a single $F$-roundtrip are moved to the above @fig-shifts (2), shifts starting with two $F$-roundtrips are moved to @fig-shifts (3) and so on.
  @fig-triangle is a concise form of figure @eq-shifts, where the initial excitation signal and each of it's shifts are enclosed in a box, forming a "brick wall triangle".
  This depiction is going to be used as a basis in following figures, to illustrate characteristics of each shift.

  #figure(
    include "figures/shifts.typ",
    caption: [Shifts of the initial excitation signal (bold), split in separate plots according to the number of $F$-roundtrips.],
    placement: none,
  )<fig-shifts>

  #figure(
    triangle(variant: "plot"),
    caption: [The brick wall triangle, a compact version of @fig-shifts where each shift is enclosed in a box.],
    placement: none,
  )<fig-triangle>

  Combinations of roundtrips are handled by the shifts, however, permutations within each combination are not currently considered.
  Let's consider a case where $k = 2$ and $m = 1$.
  In this case, three permutations of roundtrips are performed concurrently, namely $F F N$, $F N F$, and $N F F$.
  It is important to note that since $k$ and $m$ remain the same, each permutation yields an identical signal.
  Therefore, obtaining the sum of all three permutations is simply a matter of tripling the amplitude.
  Generalizing, accounting for permutations is achieved by multiplying the shifted signal by the number of allowed permutations.
  This number can be obtained using the binomial coefficient as shown in @eq-perm.
  On the brick wall triangle, permutation coefficients can be obtained by counting the number of paths leading from the initial excitation to the shift in question (@fig-perm).
  Also, if the permutation coefficient of each shift is written in the corresponding box, the triangle becomes a slightly stretched version of Pascal's triangle turned on it's left side.

  #figure(
    triangle(variant: "permutations"),
    caption: [The brick wall triangle with each box containing the number of permutations for the shift.],
    placement: none,
  )<fig-perm>

  Each roundtrip involves a SJ coefficient as defined in @eq-rho.
  The cumulative effect of the coefficients, for a given $k$ and $m$ can be computed as demonstrated in @eq-coef.

  Lastly, @eq-loss represents the roundtrip losses for any given $k$ and $m$.
  The loss implementation might vary depending on the modelling approach, in this case we choose a plain loss coefficient which can be potentially replaced by a more elaborate loss model.

  = Multiphonics abstraction

  This section presents various modifications of @eq-explicit capable of receiving the traveling wave of an untouched string, or an arbitrary periodic signal as input.
  Firstly, we obtain the formula of the untouched string (#y([nof])) using @eq-explicit and setting $rho=1$
  This causes every addend in the summation @eq-explicit where $k > 0$, evaluate to zero.
  Therefore, the original sum reduces to just the fist term where $k = 0$.

  $ y_(#text([nof]))(t) = y_(#text([in]))(t-floor(frac(t,T_N)) T_N)R_N^floor(frac(t,T_N)) $<eq-rho0>

  Note that the argument of #y([in]) has the form of a sawtooth wave with a period of $T_N$.
  Therefore, #y([nof]) has a period of $T_N$ and each cycle undergoes the losses of a $T_N$ roundtrip ($R_N$).
  Using the definition of #y([nof]) we can rewrite @eq-explicit as follows

  $
    y_(#text([out]))(t)=sum_(k=0)^floor(frac(t, T_F))(y_(#text([nof]))(t - k T_F) binom(m+k,k) (1 - rho)^k rho^m R_F^k)
  $ <eq-y0rf>

  See @appendix-a for a derivation.

  This formula takes a traveling wave of an open string as input (#y([nof])) and converts it to the traveling wave of an identical string with an additional touching finger.
  By treating an arbitrary signal as the traveling wave of an open string, the formula can be used to add the effect of the touching finger to synths or sounds of other instruments.
  The only limitation is that #y([nof]) needs to be periodic with a period of $T_N$.

  One term needing clarification is $R_F$.
  The losses of the finger loop ($R_F$) should be related to the losses of the open string ($R_N$) since both loops share the nut reflection and a part of string propagation.
  A suitable value for $R_F$ should thus be derived from $R_N$.
  This can be tricky if #y([nof]) comes from an external source (e.g. a recorded string) where $R_N$ is unknown.
  An approximation would be achievable comparing consecutive cycles of #y([nof]), however, the need for finding $R_N$ can be avoided altogether if $R_F = R_N$.
  This is a reasonable simplification since the two losses should be relatively close, especially when $T_F approx T_N$, when the roundtrips are mostly the same.
  If the two losses are equal, the $n$-th cycle of #y([nof]) i.e. the cycle that has undergone $R_N^n$ losses, will be identical to cycles that have undergone $R_F^k$ and $R_N^m$ losses, where $k+m=n$.
  Equal loss cycles occur at different points in time, this means that achieving the right losses is a matter of shifting #y([nof]).
  Given that $R_F = R_N$, formula @eq-y0rf becomes

  $
    y_(#text([out]))(t)=sum_(k=0)^floor(frac(t,T_F))(y_(#text([nof]))(t - k T_F + k T_N)binom(m+k, k) (1 - rho)^k rho^m)
  $

  giving us the appropriate shifts (see @appendix-b).

  #figure(
    triangle(variant: "losses"),
    caption: [losses],
    placement: none,
  )<fig-losses>

  = Software implementation

  An implementation of equation @eq-y0rf was developed in the form of a _Max for Live_ device (M4L) using the _gen\~_ environment in Cycling'74's _Max 8_.
  The implementation creates an instance of _mc.gen\~_ for each shift of #y([nof]) including corresponding delays and coefficients.
  The M4L was designed to receive both audio and MIDI note messages, the audio being used for #y([nof]) and the MIDI note determining $T_N$ (the wavelength of #y([nof])).
  The source code for the M4L device can be found in https://github.com/dimitriaatos/prepared.

  #figure(
    image("figures/m4l.png", width: 50%),
    caption: [The user interface of the _Max for Live_ device.],
    placement: none,
  )<fig-m4l>

  The touching point $T_F$ and finger pressure $rho$ are set with a mappable on screen slider and dial, respectively.
  The M4L device is intended to be used with a monophonic synth, with MIDI routed both to the synth and the M4L and audio routed from the synth to the M4L.

  = Evaluation study <evaluation>


  = Discussion
  This section points the limitations of the model and proposes future development steps to overcome them.
  The model is not computationally sustainable for long durations due to the increasing number of concurrent shifts.
  An input signal with a frequency of $440 unit("hertz")$ ($T_N approx 2.27 unit("ms")$) and a touching finger at the middle of the string ($T_F approx 1.14 unit("ms")$) will reach $440$ concurrent shifts in half a second.
  This number will increase linearly by $880$ shifts per second.
  Since the losses and coefficients lower the amplitude of the signal on each cycle, resources could be freed after the amplitude decreases below a threshold, and repurposed for new shifts.

  When the finger fully presses a physical string it shortens its active length, producing a higher pitch.
  The model in this case should act as a pitch shifting algorithm, which it does, but in a very basic way, producing poor results.
  The model could be improved by adopting elements of pitch shifting algorithms.

  The shifts of the input signal are positive, this means that future signal is shifted to the current time.
  This requires having future values of the input signal available beforehand, which can be done with a pre-recorded input signal, but makes real-time implementations impossible.
  A number of approaches can be taken for a real-time version, such as using the most recent past signal instead of a future signal, or projecting the signal losses into the future and constructing a future signal approximation.
]
#pagebreak()

#show: appendix
= Appendix: equation of #y([nof]) and #y([out])<appendix-a>
#include "appendix-a.typ"


= Appendix: eliminating losses <appendix-b>
#include "appendix-b.typ"
