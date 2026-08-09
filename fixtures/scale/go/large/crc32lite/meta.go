package crc32lite

// Crc32liteName identifies this hash family in reports and registries.
const Crc32liteName = "crc32lite"

// Crc32liteDescribe returns a short human-readable summary of the algorithm.
func Crc32liteDescribe() string {
	return "deterministic crc32lite byte-mixing digest over arbitrary input"
}
