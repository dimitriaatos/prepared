#import "waveguildes.typ": waveguide, node, arrow, add, dot, mul
#import "../common/constants.typ": spacing
#import "@preview/fletcher:0.5.1" as fletcher: node as fletchernode

#let text = (
  delay1: [$F/2$ delay],
  delay2: [$(N-F)/2$ delay],
  filter: [Reflection \ filter],
)

#waveguide(
	(
		node((0,0), text.delay1, name: <delay-1-a>),
		dot((1,0), name: <dot-1>),
		mul((2,0), [$rho$], dir: right, side: left),
		add((3, 0), name: <add-1>),
		node((4, 0), text.delay2, name: <delay-1-b>),
	).intersperse(arrow()),
	node((5,1), text.filter, name: <filter-1>),
	(
		node((4,2), text.delay2, name: <delay-2-b>),
		dot((3,2), name: <dot-2>),
		mul((2,2), [$rho$], dir: left, side: left),
		add((1,2), name: <add-2>),
		node((0,2), text.delay1, name: <delay-2-a>),
	).intersperse(arrow()),
	node((-1,1), text.filter, name: <filter-2>),

	add((-0.2, 1), name: <output-add>),
	arrow((rel:(spacing.output, 0), to: <output-add>), [Output]),

	mul((3,1), [$rho$], name: <mul-2-1>, dir: top, side: right),
	mul((1,1), [$rho$], name: <mul-1-2>, dir: bottom, side: left),
	// down
	arrow(<dot-1>, <mul-1-2>),
	arrow(<mul-1-2>, <add-2>),

	// up
	arrow(<mul-2-1>, <add-1>),
	arrow(<dot-2>, <mul-2-1>),

// corners
	arrow(<delay-1-b>, <filter-1>, corner: right),
	arrow(<filter-2>, <delay-1-a>, corner: right),

	arrow(<filter-1>, <delay-2-b>, corner: right),
	arrow(<delay-2-a>, <filter-2>, corner: right),

	arrow(<output-add>, "u", rev: true),
	arrow(<output-add>, "d", rev: true),

	fletchernode(
		enclose: (<dot-1>, <dot-2>),
		stroke: (dash: "dashed"),
		inset: 1.8em,
		snap: false,
	),
)