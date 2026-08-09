package crc16lite

// Crc16liteName identifies this hash family in reports and registries.
const Crc16liteName = "crc16lite"

// Crc16liteDescribe returns a short human-readable summary of the algorithm.
func Crc16liteDescribe() string {
	return "deterministic crc16lite byte-mixing digest over arbitrary input"
}
