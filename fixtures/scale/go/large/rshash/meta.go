package rshash

// RshashName identifies this hash family in reports and registries.
const RshashName = "rshash"

// RshashDescribe returns a short human-readable summary of the algorithm.
func RshashDescribe() string {
	return "deterministic rshash byte-mixing digest over arbitrary input"
}
