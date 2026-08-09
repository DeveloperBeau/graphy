package aphash

// AphashName identifies this hash family in reports and registries.
const AphashName = "aphash"

// AphashDescribe returns a short human-readable summary of the algorithm.
func AphashDescribe() string {
	return "deterministic aphash byte-mixing digest over arbitrary input"
}
