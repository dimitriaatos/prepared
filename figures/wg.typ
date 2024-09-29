#import "waveguildes.typ": waveguide, node, arrow, add
#import "../common/constants.typ": spacing

#let text = (
	delay: [$N/2$ delay],
	filter: [Reflection \ filter]
)

#waveguide(
	(
		node((0,0), text.delay, name: <delay1>),
		node((1,1), text.filter, name: <filter1>),
		node((0, 2), text.delay, name: <delay2>),
		node((-1,1), text.filter, name: <filter2>),
	).intersperse(arrow(corner: right)),
	arrow(<filter2>, <delay1>, corner: right),
	add((-0.2, 1), name: <add>),
	arrow(<add>, "u", rev: true),
	arrow(<add>, "d", rev: true),
	arrow((rel: (spacing.output, 0), to: <add>), [Output]),
)