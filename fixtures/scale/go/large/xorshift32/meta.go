package xorshift32

// Xorshift32Name identifies this hash family in reports and registries.
const Xorshift32Name = "xorshift32"

// Xorshift32Describe returns a short human-readable summary of the algorithm.
func Xorshift32Describe() string {
	return "deterministic xorshift32 byte-mixing digest over arbitrary input"
}
