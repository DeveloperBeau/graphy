package murmur2lite

// Murmur2liteName identifies this hash family in reports and registries.
const Murmur2liteName = "murmur2lite"

// Murmur2liteDescribe returns a short human-readable summary of the algorithm.
func Murmur2liteDescribe() string {
	return "deterministic murmur2lite byte-mixing digest over arbitrary input"
}
