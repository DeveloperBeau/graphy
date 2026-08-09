package siphashlite

// SiphashliteName identifies this hash family in reports and registries.
const SiphashliteName = "siphashlite"

// SiphashliteDescribe returns a short human-readable summary of the algorithm.
func SiphashliteDescribe() string {
	return "deterministic siphashlite byte-mixing digest over arbitrary input"
}
