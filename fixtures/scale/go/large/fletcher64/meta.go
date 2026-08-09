package fletcher64

// Fletcher64Name identifies this hash family in reports and registries.
const Fletcher64Name = "fletcher64"

// Fletcher64Describe returns a short human-readable summary of the algorithm.
func Fletcher64Describe() string {
	return "deterministic fletcher64 byte-mixing digest over arbitrary input"
}
