package lcghash

// LcghashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func LcghashVerify() bool {
	a := LcghashDigest([]byte("hashbench"))
	b := LcghashDigest([]byte("hashbench"))
	c := LcghashDigest([]byte("hashbench!"))
	return a == b && a != c
}
