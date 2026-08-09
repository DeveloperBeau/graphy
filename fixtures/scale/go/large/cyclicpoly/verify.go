package cyclicpoly

// CyclicpolyVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func CyclicpolyVerify() bool {
	a := CyclicpolyDigest([]byte("hashbench"))
	b := CyclicpolyDigest([]byte("hashbench"))
	c := CyclicpolyDigest([]byte("hashbench!"))
	return a == b && a != c
}
