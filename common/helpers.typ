#let appendix(body) = {
  set heading(numbering: "A", supplement: [Appendix])
  counter(heading).update(0)
	show math.equation: set block(spacing: 0.65em)
	set text(10pt, weight: 400)
	  // Set the body font.
  set text(font: "TeX Gyre Termes", size: 10pt)
  // Configure the page.
  set page(
    paper: "a4",
    margin: (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
  )
  set par(justify: true, first-line-indent: 0em, leading: 2em)
  show par: set block(spacing: 0.65em)
  body
}