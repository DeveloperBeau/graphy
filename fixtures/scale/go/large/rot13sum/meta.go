package rot13sum

// Rot13sumName identifies this hash family in reports and registries.
const Rot13sumName = "rot13sum"

// Rot13sumDescribe returns a short human-readable summary of the algorithm.
func Rot13sumDescribe() string {
	return "deterministic rot13sum byte-mixing digest over arbitrary input"
}
