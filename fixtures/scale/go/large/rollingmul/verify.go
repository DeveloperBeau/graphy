package rollingmul

// RollingmulVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func RollingmulVerify() bool {
	a := RollingmulDigest([]byte("hashbench"))
	b := RollingmulDigest([]byte("hashbench"))
	c := RollingmulDigest([]byte("hashbench!"))
	return a == b && a != c
}
