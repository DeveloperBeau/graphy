package murmur2lite

// Murmur2liteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Murmur2liteVerify() bool {
	a := Murmur2liteDigest([]byte("hashbench"))
	b := Murmur2liteDigest([]byte("hashbench"))
	c := Murmur2liteDigest([]byte("hashbench!"))
	return a == b && a != c
}
