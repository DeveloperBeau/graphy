package aphash

// AphashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func AphashVerify() bool {
	a := AphashDigest([]byte("hashbench"))
	b := AphashDigest([]byte("hashbench"))
	c := AphashDigest([]byte("hashbench!"))
	return a == b && a != c
}
