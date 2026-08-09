package fletcher32

// Fletcher32Name identifies this hash family in reports and registries.
const Fletcher32Name = "fletcher32"

// Fletcher32Describe returns a short human-readable summary of the algorithm.
func Fletcher32Describe() string {
	return "deterministic fletcher32 byte-mixing digest over arbitrary input"
}
