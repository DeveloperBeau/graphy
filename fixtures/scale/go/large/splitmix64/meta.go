package splitmix64

// Splitmix64Name identifies this hash family in reports and registries.
const Splitmix64Name = "splitmix64"

// Splitmix64Describe returns a short human-readable summary of the algorithm.
func Splitmix64Describe() string {
	return "deterministic splitmix64 byte-mixing digest over arbitrary input"
}
