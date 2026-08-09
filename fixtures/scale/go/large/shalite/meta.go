package shalite

// ShaliteName identifies this hash family in reports and registries.
const ShaliteName = "shalite"

// ShaliteDescribe returns a short human-readable summary of the algorithm.
func ShaliteDescribe() string {
	return "deterministic shalite byte-mixing digest over arbitrary input"
}
