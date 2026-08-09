package checksumxor

// ChecksumxorName identifies this hash family in reports and registries.
const ChecksumxorName = "checksumxor"

// ChecksumxorDescribe returns a short human-readable summary of the algorithm.
func ChecksumxorDescribe() string {
	return "deterministic checksumxor byte-mixing digest over arbitrary input"
}
