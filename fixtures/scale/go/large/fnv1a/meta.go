package fnv1a

// Fnv1aName identifies this hash family in reports and registries.
const Fnv1aName = "fnv1a"

// Fnv1aDescribe returns a short human-readable summary of the algorithm.
func Fnv1aDescribe() string {
	return "deterministic fnv1a byte-mixing digest over arbitrary input"
}
