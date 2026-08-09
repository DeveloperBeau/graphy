package fletcher64

// Fletcher64Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Fletcher64Verify() bool {
	a := Fletcher64Digest([]byte("hashbench"))
	b := Fletcher64Digest([]byte("hashbench"))
	c := Fletcher64Digest([]byte("hashbench!"))
	return a == b && a != c
}
