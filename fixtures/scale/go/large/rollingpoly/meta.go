package rollingpoly

// RollingpolyName identifies this hash family in reports and registries.
const RollingpolyName = "rollingpoly"

// RollingpolyDescribe returns a short human-readable summary of the algorithm.
func RollingpolyDescribe() string {
	return "deterministic rollingpoly byte-mixing digest over arbitrary input"
}
