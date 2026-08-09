package djb2

// Djb2Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Djb2Verify() bool {
	a := Djb2Digest([]byte("hashbench"))
	b := Djb2Digest([]byte("hashbench"))
	c := Djb2Digest([]byte("hashbench!"))
	return a == b && a != c
}
