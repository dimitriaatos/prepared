#import "@preview/cetz:0.2.2": canvas, plot, draw, decorations

#let tf = 0.6

#canvas(
  length: 1cm,
  {
    import draw: *
    include "triangle.typ"
    // arrows
    group({
      set-origin((1 / 2, 1 / 2))
      set-style(mark: (end: "straight"))
      line((0, 0), (2, 0), (2 + tf, 1), stroke: green)
      set-origin((0, 0.1))
      line((0, 0), (1, 0), (1 + tf, 1), (2 + tf, 1), stroke: blue)
      set-origin((0, 0.1))
      line((0, 0), (tf, 1), (2 + tf, 1), stroke: red)
    })
  },
)