package pearson

// PearsonName identifies this hash family in reports and registries.
const PearsonName = "pearson"

// PearsonDescribe returns a short human-readable summary of the algorithm.
func PearsonDescribe() string {
	return "deterministic pearson byte-mixing digest over arbitrary input"
}
