let z1, z2, z3

z1 = 1
z2 = 1
z3 = Infinity

const calc = () => {
	p1 = ((z1 - z2 - z3) / (z1 + z2 + z3)).toFixed(2)
	p2 = ((2 * z2) / (z1 + z2 + z3)).toFixed(2)
	p3 = ((2 * z1) / (z1 + z2 + z3)).toFixed(2)
	p4 = ((z2 - z1 - z3) / (z1 + z2 + z3)).toFixed(2)
	return `	${p3}	\n${p1}		${p4}\n	${p2}`
}

// p1 = (- z3) / (2* z1 + z3);
// p2 = (2* z1) / (2* z1 + z3);



console.log(calc())