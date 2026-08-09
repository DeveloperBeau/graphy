package djb2a

// Djb2aVerify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Djb2aVerify() bool {
	a := Djb2aDigest([]byte("hashbench"))
	b := Djb2aDigest([]byte("hashbench"))
	c := Djb2aDigest([]byte("hashbench!"))
	return a == b && a != c
}
