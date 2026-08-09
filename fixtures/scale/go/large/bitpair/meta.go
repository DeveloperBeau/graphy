package bitpair

// BitpairName identifies this hash family in reports and registries.
const BitpairName = "bitpair"

// BitpairDescribe returns a short human-readable summary of the algorithm.
func BitpairDescribe() string {
	return "deterministic bitpair byte-mixing digest over arbitrary input"
}
