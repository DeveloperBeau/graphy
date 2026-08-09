package fnv1

// Fnv1Name identifies this hash family in reports and registries.
const Fnv1Name = "fnv1"

// Fnv1Describe returns a short human-readable summary of the algorithm.
func Fnv1Describe() string {
	return "deterministic fnv1 byte-mixing digest over arbitrary input"
}
