package fibhash

// FibhashName identifies this hash family in reports and registries.
const FibhashName = "fibhash"

// FibhashDescribe returns a short human-readable summary of the algorithm.
func FibhashDescribe() string {
	return "deterministic fibhash byte-mixing digest over arbitrary input"
}
