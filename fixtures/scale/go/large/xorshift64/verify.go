package xorshift64

// Xorshift64Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Xorshift64Verify() bool {
	a := Xorshift64Digest([]byte("hashbench"))
	b := Xorshift64Digest([]byte("hashbench"))
	c := Xorshift64Digest([]byte("hashbench!"))
	return a == b && a != c
}
