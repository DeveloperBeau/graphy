package fletcher16

// Fletcher16Name identifies this hash family in reports and registries.
const Fletcher16Name = "fletcher16"

// Fletcher16Describe returns a short human-readable summary of the algorithm.
func Fletcher16Describe() string {
	return "deterministic fletcher16 byte-mixing digest over arbitrary input"
}
