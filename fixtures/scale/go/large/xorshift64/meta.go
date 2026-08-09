package xorshift64

// Xorshift64Name identifies this hash family in reports and registries.
const Xorshift64Name = "xorshift64"

// Xorshift64Describe returns a short human-readable summary of the algorithm.
func Xorshift64Describe() string {
	return "deterministic xorshift64 byte-mixing digest over arbitrary input"
}
