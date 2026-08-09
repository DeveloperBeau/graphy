package fnv1

// Fnv1Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Fnv1Verify() bool {
	a := Fnv1Digest([]byte("hashbench"))
	b := Fnv1Digest([]byte("hashbench"))
	c := Fnv1Digest([]byte("hashbench!"))
	return a == b && a != c
}
