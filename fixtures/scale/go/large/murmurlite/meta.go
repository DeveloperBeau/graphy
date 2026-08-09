package murmurlite

// MurmurliteName identifies this hash family in reports and registries.
const MurmurliteName = "murmurlite"

// MurmurliteDescribe returns a short human-readable summary of the algorithm.
func MurmurliteDescribe() string {
	return "deterministic murmurlite byte-mixing digest over arbitrary input"
}
