#import "@preview/cetz:0.2.2": canvas, plot, draw

// params
#let tf = 0.6
#let steps = 5
#let lines = 4
// spacing
#let lineSpacing = 3.5
#let bracesOffesY = -1.1

#for revIndex in range(lines) {
	let plotIndex = lines - revIndex
	[(#plotIndex)]
	canvas(length: 1cm, {
		plot.plot(size: (6, 2),
			axis-style: "school-book",
			x-tick-step: none,
			y-tick-step: none,
			y-label: [A],
			x-label: [t],
			{
				plot.add(
					style: (stroke: black),
					domain: (0, steps), (x) => {
						if x < (plotIndex - 1)*tf {
							0
						} else {
							calc.sin((x + (plotIndex - 1)*(1-tf)) * calc.pi * 2)
						}
					},
					samples: steps * 25,
				)
				plot.add-vline(..range(4).map((a) => (a+tf*(plotIndex - 1))), style: (stroke: blue))
				plot.add-vline(..range(plotIndex).map((a) => (a * tf)), style: (stroke: red))
			},
		)
	})
}

// \draw[-, color=black, domain=0:1, line width=1mm] plot (\x,{sin(\x*2*pi r)});	

// 	\foreach \lineIndex in {0, ..., \lineMax} {
// 			\tikzmath {
// 				int \lineNum, \fullStepsPerLine;
// 				\linePosition = \lineIndex * \lineSpacing;
// 				\lineNum = \lineIndex + 1;
// 				\fullStepsPerLine = floor(\steps - \lineIndex*\tf);
// 			}
// 			\ifnum \fullStepsPerLine>0
// 				% axes
// 				\draw[-] (-0.2,\linePosition) node[left] {(\lineNum)} -- (\steps,\linePosition) node[right] {$t$};
// 				\draw[-] (0,-1.2+\linePosition) -- (0,1.2+\linePosition) node[above] {$A$};
// 				% plot
// 				\draw[-, color=black, domain=0:\steps-\lineIndex*\tf] plot (\lineIndex*\tf+\x,{sin(\x*2*pi r)+\linePosition});
// 				% dotted plot on the first line
// 				\draw[-, color=gray, dotted, thin, domain=0:\steps-\lineIndex*\tf] plot (\lineIndex*\tf+\x,{sin(\x*2*pi r)});
// 				% exclude the first plot
// 				\ifnum \lineIndex>0
// 					% T_F brackets
// 					\foreach \tfPerLine in {1, ..., \lineIndex} {
// 							\draw[|-|, thin, color=red] (\tfPerLine*\tf-\tf, \bracesOffesY+\linePosition) -- (\tfPerLine*\tf, \bracesOffesY+\linePosition) node[midway, below] () {$T_F$};
// 						}
// 					% arrows
// 					\draw[->, thin, color=gray] (1/4+\lineIndex*\tf, 1+0.1) -- (1/4+\lineIndex*\tf, \lineIndex*\lineSpacing-0.5);
// 					% T_F brackets and dividers on the fist line
// 					\draw[|-|, thin, color=red] (\lineIndex*\tf-\tf, \bracesOffesY*2) -- (\lineIndex*\tf, \bracesOffesY*2) node[midway, above] () {$T_F$};
// 					\draw[-, dashed, thin, color=red] (\lineIndex*\tf, \bracesOffesY*2) -- (\lineIndex*\tf, 1);
// 				\fi
// 				% tn grid
// 				\tikzmath{
// 					int \fullStepsPerLineMax;
// 					\fullStepsPerLineMax = \fullStepsPerLine-1;
// 				}
// 				\foreach \stepIndex in {0, ..., \fullStepsPerLineMax} {
// 						% brackets
// 						\draw[|-|, thin, color=blue] (\lineIndex*\tf+\stepIndex, \bracesOffesY+\linePosition) -- (\lineIndex*\tf+\stepIndex+1, \bracesOffesY+\linePosition) node[midway, below] () {$T_N$};
// 						% dividers (left and right)
// 						\draw[-, very thin, blue] (\lineIndex*\tf+\stepIndex+1, 1+\linePosition) -- (\lineIndex*\tf+\stepIndex+1, \bracesOffesY+\linePosition);
// 						\draw[-, very thin, gray] (\lineIndex*\tf+\stepIndex, 1+\linePosition) -- (\lineIndex*\tf+\stepIndex, \bracesOffesY+\linePosition);
// 					}
// 			\fi
// 		}

// \end{tikzpicture}
