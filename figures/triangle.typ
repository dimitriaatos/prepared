#import "@preview/cetz:0.2.2": canvas, plot, draw, decorations

// params
#let tf = 0.6
#let steps = 5
// computed
#let t = tf * steps + 1;
#let lines = calc.ceil(steps/tf);

#canvas(length: 1cm, {
	import draw: *
	scale(y: 50%)
	group({
		for lineIndex in range(lines) {
			plot.plot(size: (steps, lines),
				axis-style: "left",
				x-tick-step: none,
				// y-tick-step: none,
				y-label: [k],
				x-label: [t],
				y-min: 0,
				y-max: lines,
				{
					plot.add(
						domain: (0, steps),
						(x) => 0)
				}
			)
			let stepsPerLine = steps - lineIndex * tf;
			let fullStepsPerLine = calc.floor(stepsPerLine);
			for stepIndex in range(0, fullStepsPerLine) {
				let start = stepIndex + lineIndex * tf
				rect((start, lineIndex), (rel: (1, 1)))
				// content((start + 1/2, lineIndex + 1/2), [#calc.binom(stepIndex + lineIndex, stepIndex)])
			}
			// partial bricks
			let start = lineIndex * tf + fullStepsPerLine;
			line((steps, lineIndex), (start, lineIndex), (start, lineIndex + 1), (steps, lineIndex + 1))
			// braces
		}
	})
	decorations.brace.with(stroke: red)((0,1),(tf,1), name: "tf-brace")
	content("tf-brace.north", [$T_F$], anchor: "south")
	decorations.brace.with(stroke: blue)((1,0),(0,0), name: "tn-brace")
	content("tn-brace.south", [$T_N$], anchor: "north")
	// arrows
	// group({
	// 	set-origin((1/2, 1/2))
	// 	set-style(mark: (end: "straight"))
	// 	line((0,0), (2, 0), (2+tf, 1), stroke: green)
	// 	set-origin((0, 0.1))
	// 	line((0,0), (1, 0), (1+tf, 1), (2+tf, 1), stroke: blue)
	// 	set-origin((0, 0.1))
	// 	line((0,0), (tf, 1), (2+tf, 1), stroke: red)
	// })
})
