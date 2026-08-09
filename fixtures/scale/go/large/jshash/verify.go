package jshash

// JshashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func JshashVerify() bool {
	a := JshashDigest([]byte("hashbench"))
	b := JshashDigest([]byte("hashbench"))
	c := JshashDigest([]byte("hashbench!"))
	return a == b && a != c
}
