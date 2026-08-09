package fletcher16

// Fletcher16Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Fletcher16Verify() bool {
	a := Fletcher16Digest([]byte("hashbench"))
	b := Fletcher16Digest([]byte("hashbench"))
	c := Fletcher16Digest([]byte("hashbench!"))
	return a == b && a != c
}
