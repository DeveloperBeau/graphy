package rshash

// RshashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func RshashVerify() bool {
	a := RshashDigest([]byte("hashbench"))
	b := RshashDigest([]byte("hashbench"))
	c := RshashDigest([]byte("hashbench!"))
	return a == b && a != c
}
