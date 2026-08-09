package checksum8

// Checksum8Verify checks that the digest is deterministic and sensitive to
// small input changes, catching accidental breakage of the mixing
// constants.
func Checksum8Verify() bool {
	a := Checksum8Digest([]byte("hashbench"))
	b := Checksum8Digest([]byte("hashbench"))
	c := Checksum8Digest([]byte("hashbench!"))
	return a == b && a != c
}
