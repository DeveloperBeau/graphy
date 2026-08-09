package rollingadd

// RollingaddName identifies this hash family in reports and registries.
const RollingaddName = "rollingadd"

// RollingaddDescribe returns a short human-readable summary of the algorithm.
func RollingaddDescribe() string {
	return "deterministic rollingadd byte-mixing digest over arbitrary input"
}
