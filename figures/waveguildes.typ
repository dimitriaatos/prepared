#import "@preview/fletcher:0.5.1" as fletcher: diagram, node as _node, edge, shapes

#let arrow(rev: auto, ..args) = if rev == true {
	edge(marks: ("<|-"), ..args)
} else {
	edge(marks: ("-|>"), ..args)
}

#let waveguide(..args) = {
	set text(size: 7pt)
	diagram(
		spacing: (4mm, 3mm),
		edge-stroke: .5pt,
		node-stroke: .5pt,
		mark-scale: 60%,
		..args,
	)
}

#let add(..args) = _node(..args, [+], shape: circle, radius: 1em)

#let node(..args) = _node(..args, inset: .6em)

#let mul(
	..args,
	pos: auto,
	label: none,
	name: none,
	side: left,
	dir: right
	) = {
	// interpret first two positional arguments
	if args.pos().len() == 2 {
		(pos, label) = args.pos()
	} else if args.pos().len() == 1 {
		let arg = args.pos().at(0)
		// one positional argument may be the coordinate or the label
		if type(arg) in (array, dictionary, label) {
			pos = arg
			label = none
		} else {
			pos = if enclose.len() > 0 { auto } else { () }
			label = arg
		}
	}

	let bton(bool) = {
		if bool { 1 } else { 0 }
	}

// left left -> down
// right right -> down
// left right -> up
// right left -> up
// 

let dy = if dir in (left, right) {
	if side == dir  {
		-1em
	} else {
		1em
	}
} else { 0em }

let dx = if dir in (top, bottom) {
	if side==left {
		-1em
	} else {
		1em
	}
} else { 0em }


let size = .5em
	_node(
		pos: pos,
		name: name,
		shape: shapes.triangle.with(dir: dir),
		radius: size,
	)
	_node(
		(rel: (dx, dy), to: pos), [#label],
		stroke: none,
		snap: false,
	)
}

#let dot(..args) = _node(..args, shape: circle, radius: .2em, fill: black)