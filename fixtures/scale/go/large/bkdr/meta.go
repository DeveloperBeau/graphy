package bkdr

// BkdrName identifies this hash family in reports and registries.
const BkdrName = "bkdr"

// BkdrDescribe returns a short human-readable summary of the algorithm.
func BkdrDescribe() string {
	return "deterministic bkdr byte-mixing digest over arbitrary input"
}
