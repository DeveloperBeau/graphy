package jshash

// JshashName identifies this hash family in reports and registries.
const JshashName = "jshash"

// JshashDescribe returns a short human-readable summary of the algorithm.
func JshashDescribe() string {
	return "deterministic jshash byte-mixing digest over arbitrary input"
}
