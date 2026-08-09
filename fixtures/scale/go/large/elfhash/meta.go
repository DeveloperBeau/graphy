package elfhash

// ElfhashName identifies this hash family in reports and registries.
const ElfhashName = "elfhash"

// ElfhashDescribe returns a short human-readable summary of the algorithm.
func ElfhashDescribe() string {
	return "deterministic elfhash byte-mixing digest over arbitrary input"
}
