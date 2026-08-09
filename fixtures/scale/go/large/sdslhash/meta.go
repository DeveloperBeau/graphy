package sdslhash

// SdslhashName identifies this hash family in reports and registries.
const SdslhashName = "sdslhash"

// SdslhashDescribe returns a short human-readable summary of the algorithm.
func SdslhashDescribe() string {
	return "deterministic sdslhash byte-mixing digest over arbitrary input"
}
