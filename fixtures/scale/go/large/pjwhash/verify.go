package pjwhash

// PjwhashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func PjwhashVerify() bool {
	a := PjwhashDigest([]byte("hashbench"))
	b := PjwhashDigest([]byte("hashbench"))
	c := PjwhashDigest([]byte("hashbench!"))
	return a == b && a != c
}
