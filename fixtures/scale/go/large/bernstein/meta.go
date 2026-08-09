package bernstein

// BernsteinName identifies this hash family in reports and registries.
const BernsteinName = "bernstein"

// BernsteinDescribe returns a short human-readable summary of the algorithm.
func BernsteinDescribe() string {
	return "deterministic bernstein byte-mixing digest over arbitrary input"
}
