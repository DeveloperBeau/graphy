package djb2a

// Djb2aName identifies this hash family in reports and registries.
const Djb2aName = "djb2a"

// Djb2aDescribe returns a short human-readable summary of the algorithm.
func Djb2aDescribe() string {
	return "deterministic djb2a byte-mixing digest over arbitrary input"
}
