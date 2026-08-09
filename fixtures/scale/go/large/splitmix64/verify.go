package splitmix64

// Splitmix64Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Splitmix64Verify() bool {
	a := Splitmix64Digest([]byte("hashbench"))
	b := Splitmix64Digest([]byte("hashbench"))
	c := Splitmix64Digest([]byte("hashbench!"))
	return a == b && a != c
}
