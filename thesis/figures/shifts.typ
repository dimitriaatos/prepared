#import "@preview/cetz:0.4.1": canvas, draw, decorations
#import "@preview/cetz-plot:0.1.2": plot

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
  canvas(
    length: 1cm,
    {
      plot.plot(
        size: (6, 2),
        axis-style: "school-book",
        x-tick-step: none,
        y-tick-step: none,
        y-label: [A],
        x-label: [t],
        {
          plot.add(
            style: (stroke: black),
            domain: (0, steps),
            x => {
              if x < (plotIndex - 1) * tf {
                0
              } else {
                calc.sin((x + (plotIndex - 1) * (1 - tf)) * calc.pi * 2)
              }
            },
            samples: steps * 25,
          )
          plot.add-vline(..range(4).map(a => (a + tf * (plotIndex - 1))), style: (stroke: blue))
          plot.add-vline(..range(plotIndex).map(a => ((a) * tf)), style: (stroke: red))
        },
      )
    },
  )
}
