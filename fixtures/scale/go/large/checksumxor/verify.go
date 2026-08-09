package checksumxor

// ChecksumxorVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func ChecksumxorVerify() bool {
	a := ChecksumxorDigest([]byte("hashbench"))
	b := ChecksumxorDigest([]byte("hashbench"))
	c := ChecksumxorDigest([]byte("hashbench!"))
	return a == b && a != c
}
