package checksum8

// Checksum8Name identifies this hash family in reports and registries.
const Checksum8Name = "checksum8"

// Checksum8Describe returns a short human-readable summary of the algorithm.
func Checksum8Describe() string {
	return "deterministic checksum8 byte-mixing digest over arbitrary input"
}
