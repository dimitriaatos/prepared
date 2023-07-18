const m = 3
const M = 4
const h = e => e

const arr = new Array(M / 2).fill(0).map((_, i) => i)
const init = (t) => arr[t]

const string = (init) => (t) => {
	return t > M ? h(l * f(t - M) + (1 - l) * f(t - m)) : init(t)
}

// h(l * f(t - 4) + (1 - l) * f(t - 3))

const f = string(init)

f(5) == h(l * f(1) + (1 - l) * f(2))

f(6) == h(l * f(2) + (1 - l) * f(3))

f(7) == h(l * f(3) + (1 - l) * f(4))

f(8) == h(l * f(4) + (1 - l) * f(5))

f(8) == h(
	l * f(4) +
	(1 - l) * h(
		l * f(1) +
		(1 - l) * f(2)
	)
)

f(9) == h(l * f(5) + (1 - l) * f(6))

f(9) == h(
	l * h(
		l * f(1) +
		(1 - l) * f(2)
	) +
	(1 - l) * h(
		l * f(2) +
		(1 - l) * f(3)
	)
)

f(10) == h(l * f(6) + (1 - l) * f(7))

f(10) == h(
	l * h(
		l * f(2) +
		(1 - l) * f(3)
	) +
	(1 - l) * h(
		l * f(3) +
		(1 - l) * f(4)
	)
)

f(11) == h(l * f(7) + (1 - l) * f(8))

f(11) == h(
	l * h(
		l * f(3) +
		(1 - l) * f(4)
	) +
	(1 - l) * h(
		l * f(4) +
		(1 - l) * f(5)
	)
)

f(12) == h(l * f(8) + (1 - l) * f(9))

f(12) == h(
	l * h(
		l * f(4) +
		(1 - l) * h(
			l * f(1) +
			(1 - l) * f(2)
		)
	) +
	(1 - l) * h(
		l * h(
			l * f(1) +
			(1 - l) * f(2)
		) +
		(1 - l) * h(
			l * f(2) +
			(1 - l) * f(3)
		)
	)
)

f(13) == h(
	l * h(
		l * h(
			l * f(1) +
			(1 - l) * f(2)
		) +
		(1 - l) * h(
			l * f(2) +
			(1 - l) * f(3)
		)
	) +
	(1 - l) * h(
		l * h(
			l * f(2) +
			(1 - l) * f(3)
		) +
		(1 - l) * h(
			l * f(3) +
			(1 - l) * f(4)
		)
	)
)

f(t) = h(l * f(t - M) + (1 - l) * f(t - m))

sum(0, K, (k) => {
	return f(t - k * m - n * M) * fact(n + k) / (fact(n) * fact(k)) * Math.pow((1 - l), n) * Math.pow(l, k)
})