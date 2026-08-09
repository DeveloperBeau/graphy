package shalite

// ShaliteVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func ShaliteVerify() bool {
	a := ShaliteDigest([]byte("hashbench"))
	b := ShaliteDigest([]byte("hashbench"))
	c := ShaliteDigest([]byte("hashbench!"))
	return a == b && a != c
}
