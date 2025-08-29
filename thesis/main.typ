#import "@preview/charged-ieee:0.1.4": ieee
#import "@preview/unify:0.7.1": num, qty, numrange, qtyrange, unit
#import "common/constants.typ": m, y
#import "common/helpers.typ": appendix
#import "figures/triangle.typ": triangle

#ieee(
  title: [Performing string multiphonics on any pitched sound],
  abstract: [
    Multiphonics and flageolet tones on string instruments are performed by lightly touching the vibrating string.
    The lightly touched string can be conceptualized as the interaction between two entities, the untouched string and the touching finger.
    This paper proposes a model that reflects this conceptualization, providing separate parts for each interacting entity.
    This separation allows for replacing the part of the untouched string with an arbitrary sound.
    In practice, this means that multiphonics and flageolet tones can be applied to non-string sounds, like sounds of other instruments and synthesized electronic sounds.
    The proposed model is developed in the form of a non-recursive, time-based formula.
    A software implementation of the touching finger model is presented and used in a small scale evaluation study.
    Limitations are identified and possible solutions discussed.
    Beyond the case of the lightly touched string, a wider research objective is put forward, aimed at developing models that allow for similar separation of other acoustic effects and qualities from their original sound source.
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
  The main obstacle for the task in question is that physical models are designed for synthesizing sounds that incorporate the desired timbral effect, rather than letting their user choose the sound to which the effect will be applied.

  This paper focuses on the effects performed by lightly touching a vibrating string and proposes a model that allows these effects to be applied to arbitrary sounds.
  Lightly touching a vibrating string is a practice associated with a number of timbral string instrument playing techniques.
  Depending on the touching position and the touching agent, a different technique is performed.
  Flageolet tones (or harmonics) are performed by lightly touching a string with a finger on specific fractions of its length.
  The produced sound has a pitch much higher than the original string and a different timbre, comparable to a whistle @kamien_music_2008[p.~13].
  Multiphonics is a technique where single pitch sound sources produce sounds with more than one perceivable pitch.
  They are often performed on wind instruments and, although less popular, can also be performed on plucked strings @torres_multiphonics_2012-1, @torres_multiphonics_2012-2.
  Plucked string multiphonics are achieved by lightly touching the string at positions other than those producing harmonics, their timbre has a bell-like or buzzing quality @torres_multiphonics_2012-1.
  Prepared strings is another technique where instead of a finger, a variety of objects such as rubbers, bolts or crocodile clips may be attached to the string, the position of the object might be either that of an multiphonic or a harmonic.

  Applying the effects of the lightly touched string to arbitrary sounds is viewed as part of a wider research objective.
  This paper hopes to attract interest in research on decoupling acoustic effects and qualities from their original sources.
  One obvious application of this research topic is its use as a creative tool, where novel combinations of acoustic features can be used for aesthetic purposes.
  Decoupled timbral effects can also contributes to a deeper understanding of the perception of timbre, which is a notoriously complex field.
  Perceptual experiments on sound could potentially take advantage of the more "sterile" isolated timbre that might yield more precise results, linking stimuli to perception.
  Lastly, decoupled timbral effect should, in principle, retain some auditory cues that carry information about the object the sound was produced by and the action that triggered the sound.
  Successful identification of the action or object might vary depending on a number of factors e.g. the chosen timbral effect or the chosen sound source the effect is applied to.
  Regardless, correlations with an object or an action can make decoupled timbral effects a good candidate for information encoding, resulting potentially in novel flexible parameters for sonification strategies and new forms of intuitive sonic interaction design.

  = Background
  Numerous developments in the history of electronic music could be viewed as attempts to replicate acoustic audio features.
  Common concepts in sound synthesis such as the ADSR envelope (attack, decay, sustain, release) and spatial audio effects like reverb and echo, come from the acoustic world.
  Although timbre specific effects have mainly been part of sound synthesis, there are some cases where they have been modelled independently from the associated sound source.

  == Vowels on any sound
  In speech synthesis, modelling of the human vocal tract has historically preceded the modelling of the vocal folds.
  Early speech synthesis such as VODER @dudley_synthetic_1939 as well as later text-to-speech technology like the DECtalk @hallahan_dectalk_1995 have relied on models of the vocal tract and used arbitrary pitched sounds in place of the vocal folds.
  Although speech is a special case of sound, the vocal tract is essentially a timbral effect.
  Uses of the vocal tract's effect in non-speech contexts include the _talkbox_, a guitar pedal that directs sound through a tube, in the performer's mouth.
  Many commercial software and hardware products designed for musicians have mimicked the _talkbox_ by implementing formant filters, a common simulation of the vocal tract.
  Formant filters have also been used in sound design for electric vehicles @chang_study_2015.

  == Synths with acoustic attacks
  _Linear arithmetic synthesis_ @russ_l_1987 is a sound synthesis technique where recorded attacks of acoustic instruments are placed on the onset of synthesized tones.
  While this does not defer technically from sound collage, the perceptual importance of the attack transients @thayer_effect_1974 makes the resulting sound resemble a hybrid between the two rather than a simple succession.

  == Timbre transfer using neural networks

  Using artificial intelligence techniques to abstract timbral effects and qualities of sounds has been attempted in recent years.
  In @roche_make_2021 a variational autoencoder (a specific kind of neural network) is used alter the timbre of sound in a number of perceptual dimensions such as _metallic_, _warm_, _breathy_ etc.
  This approach uses perceptually labeled sounds for learning and is thus extensible to new perceptual dimensions.

  Differential digital signal processing (DDSP) is a technique used in combination with neural networks to map timbral changes on a source sound to analogous timbral changes on a target sound.
  This has be done for inherent timbral envelopes of the instrument @engel_ddsp_2020 and also for timbal playing techniques @shier_real-time_2024.
  The downside of DDSP is that it works only with quantifiable timbral features like brightness and noisiness.

  == String model decomposition
  An important step in achieving the abstraction of the touching finger effect is decomposition of the string's physical model, isolating parts like the plucking and pickup position.
  This has been pursued for various reasons other than abstracting acoustic effects.
  Matti Karjalainen et al. in @karjalainen_plucked-string_1998 decompose the model of the open string in modules for _string excitation_, the _string_ itself, _pickup mic_ and _bridge_, to achieve computational efficiency.
  In @pakarinen_physical_2005, Jyri Pakarinen adapts these modules to include a touching finger.
  Another work demystifying the mechanism producing multiphonics is by Guttler and Thelin.
  They provide an analysis of the touched string's impulse response in @guettler_bowed-string_2012, providing a step-by-step explanation for the construction of its waveform.

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
  Although this might seem like a crude simplification, comparing audio outputs reveals that the only discernible effects of the _single-sided_ SJ are a rough quality and a slightly longer decay time (evaluated in #ref(<evaluation>)), which is an acceptable compromise for the purpose of this paper.

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
  This formulation is inconvenient for isolating the parts relative to the finger, an explicit formula is thus proposed.
  This formula is derived by following the steps of the waveguide model, but an algebraic derivation is yet to be provided.
  // In the explicit formulation, string looping, losses and finger coefficients are applied to the initial excitation signal, rather than previous values.

  #figure(
    image("figures/sdl-js.png"),
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

  == Shifts
  Firstly, @eq-shifts loops the excitation signal by shifting it forward in time by an amount proportional to the number of $N$- and $F$-roundtrips performed.
  Variables $m$ and $k$ work as counters for the number of complete $N$ and $F$-roundtrips respectively.
  A depiction of the shifts can be seen in Figure @eq-shifts.
  The first @fig-shifts (1) plot starts with the initial excitation signal (thicker stoke), followed by shifts of $N$-roundtrips, i.e. multiples of $T_N$.
  Since $T_F<T_F$, $F$-roundtrip shifts will fall on top of $N$-roundtrip shifts in the current depiction (dotted lines).
  In order to avoid a confusing illustration, shifts starting with a single $F$-roundtrip are moved to the above @fig-shifts (2), shifts starting with two $F$-roundtrips are moved to @fig-shifts (3) and so on.
  @fig-triangle is a concise form of figure @eq-shifts, where the initial excitation signal and each of it's shifts are enclosed in a box, forming a "brick wall triangle".
  This depiction is going to be used as a basis in following figures, to illustrate characteristics of each shift.

  #figure(
    triangle(variant: "plot"),
    caption: [The brick wall triangle, a compact version of @fig-shifts where each shift is enclosed in a box.],
    placement: none,
  )<fig-triangle>

  #figure(
    // include "figures/shifts.typ",
    image("figures/shifts.png"),
    caption: [Shifts of the initial excitation signal (bold), split in separate plots according to the number of $F$-roundtrips.],
    placement: none,
  )<fig-shifts>

  == Permutations
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

  == Coefficient
  Each roundtrip involves a SJ coefficient as defined in @eq-rho.
  The cumulative effect of the coefficients, for a given $k$ and $m$ can be computed as demonstrated in @eq-coef.

  == Losses
  Lastly, @eq-loss represents the roundtrip losses for any given $k$ and $m$.
  The loss implementation might vary depending on the modelling approach, in this case we choose a plain loss coefficient which can be potentially replaced by a more elaborate loss model.

  = Multiphonics abstraction

  This section presents various modifications of equation @eq-explicit that are capable of receiving the traveling wave of an untouched string, or an arbitrary periodic signal as input.
  Firstly, we obtain the formula of the untouched string (#y([nof])) using @eq-explicit and setting $rho=1$
  This causes every addend in the summation @eq-explicit where $k > 0$, evaluate to zero.
  Therefore, the original sum reduces to just the first term where $k = 0$.

  $
    y_(#text([nof]))(t) = y_(#text([in]))(t-floor(frac(t,T_N)) T_N)R_N^floor(frac(t,T_N))
  $<eq-rho0>

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

  An implementation of equation @eq-y0rf (with a small variation) was developed in the form of a _Max for Live_ device (M4L) using the _gen\~_ environment in Cycling'74's _Max 8_.
  The point where the software implementation differs from @eq-y0rf is in the timing of the shifts, instead of shifting future signal to the present, the most recent (closest to the future) signal is preferred, this is done to allow the software work in real-time audio.
  An instance of _mc.gen\~_ is created for each shift of #y([nof]) including corresponding delays and coefficients.
  The M4L was designed to receive both audio and MIDI note messages, the audio being used for #y([nof]) and the MIDI note determining $T_N$ (the wavelength of #y([nof])).
  A second utility M4L was also provided for routing MIDI to the main M4L, simplifying the required configuration.
  The source code for the M4L device can be found in https://github.com/dimitriaatos/prepared .

  #figure(
    image("figures/m4l.png", width: 50%),
    caption: [The user interface of the _Max for Live_ device.],
    placement: none,
  )<fig-m4l>

  The touching point $T_F$ and finger pressure $rho$ are set with a mappable on screen slider and dial, respectively.
  The M4L device is intended to be used with a monophonic synth, with MIDI routed both to the synth and the M4L and audio routed from the synth to the M4L.

  = Evaluation study <evaluation>
  A small scale perceptual study, involving 8 trained musicians was conducted for evaluating the results and intermediate decisions of the paper.
  The musicians had experience with several instruments, including the guitar and other stringed instruments.
  The study consisted of several perceptual experiments each with a different goal.

  == Touched string effect on arbitrary sounds
  This part of the study employed the action/object paradigm @conan_intuitive_2014, which posits that everyday sounds contain auditory cues that convey information about both the action that produced the sound and the object involved in that action.
  The primary aim was to investigate whether participants could accurately identify both the action and the object associated with a series of sounds where multiphonics and harmonics where applied.
  Participants where asked to describe the action and the object they perceived to be the source of the sound.

  To mitigate potential carryover effects, the parts of the study were organized along a gradient from less "string-like" to more "string-like".
  This ordering strategy aimed to reduce perceptual bias that might arise from prior exposure to string characteristics.
  The sorting of sounds within each part was randomized for each participant, participants where able to repeat each sound as many times as the wished.
  All stimuli were generated using a normalized finger pressure ($rho$) of $0.5$, a value at which the effect of the touching finger, is most prominent.
  Finger position varied between stimuli, with values ranging from $0$ to $1$, where $0$ corresponds to the bridge and $1$ to the nut.

  The sounds were split in two groups:

  === String effects on non-string acoustic instruments
  Participants were presented with four harmonics and four multiphonics applied to accordion and timpani sounds.
  This group of sounds tested whether the inferred object and action from the source instrument would conflict with those implied by the string effects.
  For both instruments, the following finger position values were used,
  $1/5$, $1/4$, $1/2$ and $1/8$ for harmonics and
  $0.302$, $0.144$, $0.361$ and $0.0644$ for multiphonics.

  === String effects on simple synthesized waveforms
  This part introduced string effects to synthetic sounds.
  It served as a perceptual midpoint between acoustic non-string sounds and string sounds, where the original sound had no acoustic source.
  A sawtooth and a triangular waveform where used, all other parameters, such as finger position and the number of sounds, were kept consistent with the previous part.

  == Single sided scattering junction waveguide
  The next part of the study evaluated the impact of simplifying the touched string DWG model by replacing the original configuration with a single-sided SJ.
  Participants were presented with 5 pairs of stimuli, each pair consisting of one sound generated using the full model and the other using a simplified model.
  Participants were asked to quantify their perception of difference in a 5-point scale, with $1$ indicating no difference and $5$ indicating extreme difference.
  Participants were also asked to provide a brief description explaining how they perceived the sounds to differ.
  The touching points used where $0.56$, $0.83$, $0.875$, $0.8$ and $0.922$.
  // 1 = No difference, 7 = Extremely different
  == Use of the software
  In the final part of the study, 3 participants were given access to the software implementation, allowing them to interact with it directly.
  This exploratory session aimed to gather qualitative feedback on the model's behavior in practice.
  Participants were encouraged to manipulate parameters freely and to identify potential issues, limitations, or unexpected behaviors.

  = Results
  All participants successfully identified the general sound source category for each of the presented stimuli.
  The accordion was identified as either an accordion or a melodica, the timpani was recognized as a struck membranophone, and the sawtooth and triangular waveforms were identified as synthesized sounds.
  This suggests that the added effect didn't obscure any of the auditory cues of the original sounds.
  On the non-string acoustic sounds, the applied harmonics and multiphonics where attributed to some kind of resonating mute operated by hand.
  While this doesn't link directly to strings, it is not entirely irrelevant, as the lightly touching finger is also a muting agent of the string.
  While for the simple waveform stimuli the touching finger effect was perceived as filtering.
  Three out of eight participants remarked that these sounds exhibited a quality reminiscent of plucking a string.
  Only two participants made a corelation with a lightly touched string.

  The single-sided SJ DWG was distinguished from the full string model, 75% of the participants giving it a score of $2$, right above $1$ which represented no difference, and 25% giving it a score of 3.
  Descriptions of their difference varied, but pointed to the same direction.
  Tones generated with the single-sided SJ where characterized as less damped, having a richer attack or a longer decay.

  Participants who used the software implementation found it to be useful as a creative tool.
  In particular, participants made comparisons with resonant filters, which they had used previously for boosting harmonics.
  They noted that a key advantage of the software was its ability to enhance harmonics without muffling the attack of the input sound, even enhanced the attack's character in some cases.
  However, several limitations were noted.
  The model did not perform well with all types of input sounds, for instance, long sustained sounds were always shortened, and for some kinds of sounds, varying the finger position yielded minimal variation, particularly with percussive sounds like mallets and simple waveforms such as square waves.
  Additionally, setting the finger pressure to zero (fully pressed) resulted in distorting artifacts, which participants perceived as a fault.
  An unintended use of the software was also explored, using it with chords and non-pitched sounds, this kind of use had also a positive response in regards to its creative potential.

  = Discussion
  This section discusses the limitations of the model and proposes future developments to overcome them.

  While the experiments showed a low corelation to the lightly touched string, the general descriptions of the added effect pointed to a direction that might require more examination.
  Further studies could be conducted, identifying whether the operation of the resonating/muting agent is perceived as having similar dimensions of control as the touched string.

  The limited duration that users of the software noted is caused by an inefficiency of equation @eq-y0rf, the number of concurrent signal shifts increase linearly with time making the model computationally unsustainable.
  An input signal with a frequency of $440 unit("hertz")$ ($T_N approx 2.27 unit("ms")$) and a touching finger at the middle of the string ($T_F approx 1.14 unit("ms")$) will reach $440$ concurrent shifts in half a second.
  This number will increase linearly by $880$ shifts per second.
  Since the losses and coefficients lower the amplitude of the signal on each cycle, resources could be freed after the amplitude decreases below a threshold, and repurposed for new shifts.

  When the finger fully presses a physical string it shortens its active length, producing a higher pitch.
  The model in this case should in theory act as a pitch shifting algorithm, which it does, but also produces the artifacts reported by users of the software.
  Potential improvements could be achieved by adopting elements of pitch shifting algorithms.

  The lack of sound variation reported on mallet and square wave sounds is possibly caused by the incomplete series of harmonics on these specific sounds.
  The touching finger effect on the output should at least lack the harmonics that are not present in the input signal.

  The single-sided SJ was shown to be a reasonable simplification with a discernible but minimal effect.
  The temporal and timbral changes caused could be minimized with small tweaks on the parameters of the model to adjust the decay of the output, and possibly filtering for bringing back the smoother quality of the full model.

  The software implementation used a slightly altered version of the shifts in equation @eq-y0rf, to offer users real-time processing.
  This was required due to the shifts being positive, which means that future signal is shifted to the current time.
  This requires future values of the input signal to be available beforehand, which can be done with a pre-recorded input signal, but makes real-time implementations impossible.
  The approach taken in the software, while somewhat effective, is a computational trick trying to minimize loss, alternative approaches with a better justification should be explored.

  = Conclusion
  A physical model of the lightly touched string was presented.
  The part of the model representing the open string was isolated to allow using arbitrary pitched sounds in its place, arriving at an audio effect capable of applying the effects of the touched string, namely flageolet tones and string multiphonics, to arbitrary sounds.
  An evaluation study, involving trained musicians, was conducted.
  The results suggest that the perceptual cues linking the model directly to a string are only weakly discernible, but they are still perceived as an acoustic muting and resonating agent.
  Participants found the model compelling on single-pitched, multi-pitched and non-pitch sounds, highlighting its potential as a creative tool.
  However, limitations were also identified, the model limited the duration of sustained sounds, finger position variation sometimes produced minimal audible change, and edge cases such as a finger position of zero yielded artifacts interpreted as undesirable distortion.
  Overall, the study highlights the expressive potential and the areas for improvement of the model, laying a foundation for future development.
]
#pagebreak()

#show: appendix
= Appendix: equation of #y([nof]) and #y([out])<appendix-a>
#include "appendix-a.typ"


= Appendix: eliminating losses <appendix-b>
#include "appendix-b.typ"
