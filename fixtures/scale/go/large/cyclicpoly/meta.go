package cyclicpoly

// CyclicpolyName identifies this hash family in reports and registries.
const CyclicpolyName = "cyclicpoly"

// CyclicpolyDescribe returns a short human-readable summary of the algorithm.
func CyclicpolyDescribe() string {
	return "deterministic cyclicpoly byte-mixing digest over arbitrary input"
}
