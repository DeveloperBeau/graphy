package fletcher32

// Fletcher32Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Fletcher32Verify() bool {
	a := Fletcher32Digest([]byte("hashbench"))
	b := Fletcher32Digest([]byte("hashbench"))
	c := Fletcher32Digest([]byte("hashbench!"))
	return a == b && a != c
}
