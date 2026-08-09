package xorshift32

// Xorshift32Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Xorshift32Verify() bool {
	a := Xorshift32Digest([]byte("hashbench"))
	b := Xorshift32Digest([]byte("hashbench"))
	c := Xorshift32Digest([]byte("hashbench!"))
	return a == b && a != c
}
