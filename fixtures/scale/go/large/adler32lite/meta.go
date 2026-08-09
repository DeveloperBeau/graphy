package adler32lite

// Adler32liteName identifies this hash family in reports and registries.
const Adler32liteName = "adler32lite"

// Adler32liteDescribe returns a short human-readable summary of the algorithm.
func Adler32liteDescribe() string {
	return "deterministic adler32lite byte-mixing digest over arbitrary input"
}
