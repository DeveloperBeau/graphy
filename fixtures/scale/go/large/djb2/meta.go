package djb2

// Djb2Name identifies this hash family in reports and registries.
const Djb2Name = "djb2"

// Djb2Describe returns a short human-readable summary of the algorithm.
func Djb2Describe() string {
	return "deterministic djb2 byte-mixing digest over arbitrary input"
}
