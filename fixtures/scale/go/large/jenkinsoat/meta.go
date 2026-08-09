package jenkinsoat

// JenkinsoatName identifies this hash family in reports and registries.
const JenkinsoatName = "jenkinsoat"

// JenkinsoatDescribe returns a short human-readable summary of the algorithm.
func JenkinsoatDescribe() string {
	return "deterministic jenkinsoat byte-mixing digest over arbitrary input"
}
