package rollingadd

// RollingaddVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func RollingaddVerify() bool {
	a := RollingaddDigest([]byte("hashbench"))
	b := RollingaddDigest([]byte("hashbench"))
	c := RollingaddDigest([]byte("hashbench!"))
	return a == b && a != c
}
