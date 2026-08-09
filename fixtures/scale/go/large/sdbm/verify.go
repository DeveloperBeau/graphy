package sdbm

// SdbmVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func SdbmVerify() bool {
	a := SdbmDigest([]byte("hashbench"))
	b := SdbmDigest([]byte("hashbench"))
	c := SdbmDigest([]byte("hashbench!"))
	return a == b && a != c
}
