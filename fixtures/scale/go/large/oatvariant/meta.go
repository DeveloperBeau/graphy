package oatvariant

// OatvariantName identifies this hash family in reports and registries.
const OatvariantName = "oatvariant"

// OatvariantDescribe returns a short human-readable summary of the algorithm.
func OatvariantDescribe() string {
	return "deterministic oatvariant byte-mixing digest over arbitrary input"
}
