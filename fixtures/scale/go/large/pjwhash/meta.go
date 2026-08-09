package pjwhash

// PjwhashName identifies this hash family in reports and registries.
const PjwhashName = "pjwhash"

// PjwhashDescribe returns a short human-readable summary of the algorithm.
func PjwhashDescribe() string {
	return "deterministic pjwhash byte-mixing digest over arbitrary input"
}
