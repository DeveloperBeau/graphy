package fibhash

// FibhashVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func FibhashVerify() bool {
	a := FibhashDigest([]byte("hashbench"))
	b := FibhashDigest([]byte("hashbench"))
	c := FibhashDigest([]byte("hashbench!"))
	return a == b && a != c
}
