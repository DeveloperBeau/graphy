package lcghash

// LcghashName identifies this hash family in reports and registries.
const LcghashName = "lcghash"

// LcghashDescribe returns a short human-readable summary of the algorithm.
func LcghashDescribe() string {
	return "deterministic lcghash byte-mixing digest over arbitrary input"
}
