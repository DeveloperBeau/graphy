package sdbm

// SdbmName identifies this hash family in reports and registries.
const SdbmName = "sdbm"

// SdbmDescribe returns a short human-readable summary of the algorithm.
func SdbmDescribe() string {
	return "deterministic sdbm byte-mixing digest over arbitrary input"
}
