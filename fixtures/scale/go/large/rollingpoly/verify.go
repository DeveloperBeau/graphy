package rollingpoly

// RollingpolyVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func RollingpolyVerify() bool {
	a := RollingpolyDigest([]byte("hashbench"))
	b := RollingpolyDigest([]byte("hashbench"))
	c := RollingpolyDigest([]byte("hashbench!"))
	return a == b && a != c
}
