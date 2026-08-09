package wanghash

// WanghashName identifies this hash family in reports and registries.
const WanghashName = "wanghash"

// WanghashDescribe returns a short human-readable summary of the algorithm.
func WanghashDescribe() string {
	return "deterministic wanghash byte-mixing digest over arbitrary input"
}
