package rollingmul

// RollingmulName identifies this hash family in reports and registries.
const RollingmulName = "rollingmul"

// RollingmulDescribe returns a short human-readable summary of the algorithm.
func RollingmulDescribe() string {
	return "deterministic rollingmul byte-mixing digest over arbitrary input"
}
